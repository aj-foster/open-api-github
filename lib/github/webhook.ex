defmodule GitHub.Webhook do
  @moduledoc """
  Helpers for validating and handling webhooks dispatched by GitHub

  This module is made for Plug / Phoenix applications that wish to accept webhook requests that
  are sent from the GitHub API. Receiving these requests requires setting up a webhook or GitHub
  App, which is out of scope for this documentation.

  ## Configuration

  In order to validate that incoming webhooks are, in fact, from GitHub, it is **strongly
  advised** to set a webhook secret. This is a secret value that you generate and supply to GitHub
  in the webhook or GitHub App settings. If you are using Phoenix, an easy way to generate this
  value is by running `mix phx.gen.secret`.

  Then, supply this value to the library at runtime using the following configuration:

      config :oapi_github,
        webhook_secret: "my secret"

  It is common to use `System.fetch_env!/1` or a similar function to load this type of secret
  from environment variables. Alternatively, the webhook secret can be supplied directly to
  `verify_github_signature/2` at compile time.

  ## Usage

  If the optional dependencies `Plug` and `Plug.Crypto` are installed, this module provides
  several helpers to simplify the process of handling webhook requests. A typical webhook
  controller might look like this:

      defmodule MyAppWeb.GitHubController do
        use MyAppWeb, :controller
        import GitHub.Webhook

        plug :verify_github_event
        plug :verify_github_signature

        def webhook(conn, params) do
          # Handle the webhook...
        end
      end

  In order to perform verification of the signature, it is necessary to store the original request
  body in an assign `:raw_body` or `:body`. This usually requires implementing a custom
  `Plug.Parser` for webhook requests.

  See `verify_github_event/2` and `verify_github_signature/2` for more information.
  """

  @doc """
  Construct the value of the `:body_reader` option for `Plug.Parsers` for caching request bodies

  This function, called at compile time, creates a valid value for the `:body_reader` option in
  a call to the `Plug.Parsers` plug. Usually called in a Phoenix Endpoint, the code looks like:

      plug Plug.Parsers,
        parsers: [:json, ...],
        json_decoder: Jason,
        # ...
        body_reader: GitHub.Webhook.body_reader()

  It sets up `cache_request_body/2` as the body reader, which will in turn cache the raw request
  body as an assign `:raw_body` for use during signature verification.

  ## Options

    * `:fallback`: If using the `:routes` option below, which body reader function to call for
      requests that do not match one of the specified routes. Defaults to
      `{Plug.Conn, :read_body, []}`.

    * `:routes`: Optionally restrict the caching of request bodies to specific routes, given as
      a list of strings (ex. `["/hook/github"]`). Defaults to caching request bodies for all
      requests, which can cause a significant performance impact.

  """
  @spec body_reader(keyword) :: tuple
  def body_reader(opts \\ []) do
    {GitHub.Webhook, :cache_request_body, [fallback: opts[:fallback], routes: opts[:routes]]}
  end

  @doc """
  Cache request body as `:raw_body` assign for chosen connections

  This function adheres to the needs of the `:body_reader` option for the `Plug.Parsers` plug. It
  saves the raw request body as a binary to the `:raw_body` assign on the `Plug.Conn`, so that it
  can be used for signature verification later.

  This function is not usually called directly. Instead, use `body_reader/1`.
  """
  @spec cache_request_body(Plug.Conn.t(), keyword) ::
          {:ok, binary, Plug.Conn.t()} | {:error, term}
  def cache_request_body(conn, opts)

  if Code.ensure_loaded?(Plug) do
    def cache_request_body(conn, opts) do
      %Plug.Conn{path_info: path_info} = conn

      fallback =
        case opts[:fallback] do
          {module, function, args} when is_atom(module) and is_atom(function) and is_list(args) ->
            {module, function, args}

          nil ->
            {Plug.Conn, :read_body, []}

          _else ->
            raise ArgumentError, "Invalid value for option `:fallback`"
        end

      routes =
        case opts[:routes] do
          route when is_binary(route) -> [String.split(route, "/", trim: true)]
          routes when is_list(routes) -> Enum.map(routes, &String.split(&1, "/", trim: true))
          nil -> nil
          _else -> raise ArgumentError, "Invalid value for option `:routes`"
        end

      if is_list(routes) and path_info not in Enum.map(routes, &String.split(&1, "/", trim: true)) do
        {fallback_module, fallback_function, fallback_opts} = fallback
        apply(fallback_module, fallback_function, [conn, fallback_opts])
      else
        case Plug.Conn.read_body(conn, Keyword.put(opts, :length, 25_000_000)) do
          {:ok, body, conn} ->
            conn = update_in(conn.assigns[:raw_body], &[body | &1 || []])
            {:ok, body, conn}

          {:more, _, _} ->
            {:error, "Webhook payload is too large (over 25MB)"}

          {:error, _} = err ->
            err
        end
      end
    end
  else
    def cache_request_body(conn, _opts) do
      raise GitHub.Error.new(
              source: conn,
              message: """
              Plug Not Installed

              Optional dependency Plug was not installed at the
              time `GitHub.Webhook` was compiled. Please ensure
              it is installed and run:

              `mix deps.compile --force oapi_github`
              """
            )
    end
  end

  @doc """
  Get and store the GitHub webhook event type

  This function looks at the `X-GitHub-Event` header to ensure the incoming request is a webhook
  event and stores the event as a `:github_event` assign on the connection. If the header is
  missing, the connection is immediately halted with a simple error message that will appear in
  GitHub's UI.
  """
  @spec verify_github_event(Plug.Conn.t(), keyword) :: Plug.Conn.t()
  def verify_github_event(conn, opts)

  if Code.ensure_loaded?(Plug) do
    def verify_github_event(conn, _opts) do
      case Plug.Conn.get_req_header(conn, "x-github-event") do
        [event | _] ->
          Plug.Conn.assign(conn, :github_event, event)

        [] ->
          conn
          |> Plug.Conn.send_resp(:bad_Request, "Missing event header")
          |> Plug.Conn.halt()
      end
    end
  else
    def verify_github_event(conn, _opts) do
      raise GitHub.Error.new(
              source: conn,
              message: """
              Plug Not Installed

              Optional dependency Plug was not installed at the
              time `GitHub.Webhook` was compiled. Please ensure
              it is installed and run:

              `mix deps.compile --force oapi_github`
              """
            )
    end
  end

  @doc """
  Check the validity of a GitHub webhook request

  This function uses the configured `:webhook_secret` or an option `:secret` to verify the
  signature of an incoming GitHub webhook. If the signature is missing or invalid, the connection
  is immediately halted with a simple error message that will appear in GitHub's UI.

  ## Configuration

    * `:webhook_secret`: Secret given to GitHub to use when signing webhook requests. If not
      supplied via configuration nor the `:secret` option, an error is raised.

  ## Options

    * `:secret`: Compile-time secret to use as the webhook secret. If not supplied at compile time
      nor via the `:webhook_secret` configuration, an error is raised.

  """
  @spec verify_github_signature(Plug.Conn.t(), keyword) :: Plug.Conn.t()
  def verify_github_signature(conn, opts)

  if Code.ensure_loaded?(Plug) do
    def verify_github_signature(conn, opts) do
      request_body = conn.assigns[:raw_body] || conn.assigns[:body]
      secret = opts[:secret] || get_secret()
      signature = Plug.Conn.get_req_header(conn, "x-hub-signature-256") |> List.first()

      unless is_binary(request_body) do
        raise GitHub.Error.new(
                source: conn,
                message: """
                Request Body Not Present

                In order to verify the signature of a GitHub
                webhook request, a special parser must be used.
                This plug expects the raw request body to be read
                and present on the connection as a binary
                `:raw_body` or `:body` assign.

                For more information, see the documentation for
                `GitHub.Webhook`.
                """
              )
      end

      unless is_binary(secret) do
        raise GitHub.Error.new(
                source: conn,
                message: """
                Webhook Secret Not Configured

                In order to verify the signature of a GitHub
                webhook request, a webhook secret must be
                configured or passed in as an option `:secret`
                to this plug.

                For more information, see the documentation for
                `GitHub.Webhook`.
                """
              )
      end

      hash =
        "sha256=" <>
          Base.encode16(:crypto.mac(:hmac, :sha256, secret, request_body), case: :lower)

      cond do
        is_nil(signature) ->
          conn
          |> Plug.Conn.send_resp(:bad_request, "Missing signature")
          |> Plug.Conn.halt()

        Plug.Crypto.secure_compare(hash, signature) ->
          conn

        :else ->
          conn
          |> Plug.Conn.send_resp(:unauthorized, "Invalid signature")
          |> Plug.Conn.halt()
      end
    end

    @spec get_secret :: String.t() | nil
    defp get_secret, do: Application.get_env(:oapi_github, :webhook_secret)
  else
    def verify_github_signature(conn, _opts) do
      raise GitHub.Error.new(
              source: conn,
              message: """
              Plug Not Installed

              Optional dependency Plug was not installed at the
              time `GitHub.Webhook` was compiled. Please ensure
              it is installed and run:

              `mix deps.compile --force oapi_github`
              """
            )
    end
  end
end
