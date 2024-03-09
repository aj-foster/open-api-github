defmodule GitHub do
  alias GitHub.Config
  alias GitHub.Error
  alias GitHub.Operation

  @doc """
  Constructs a `GitHub.App` struct using information from configuration

  This is a convenience function for creating `GitHub.App` structs that are compatible with the
  `GitHub.Auth` protocol for authenticating requests. It accepts the name of a GitHub App that is
  configured using the `apps` key:

      iex> app = GitHub.app(:my_app)
      %GitHub.App{id: 12345, pem: "\"-----BEGIN RSA PRIVATE KEY..."}

      iex> GitHub.Apps.get_installation(67890, auth: app)
      {:ok, %GitHub.Installation{...}}

  It is common (and strongly recommended) to use environment variables and runtime configuration
  for the app ID and private key.

  ## Configuration

  App configs are always given as 3-tuples containing a configuration name for the app (atom),
  the app's ID (integer), and the app's private key (string, PEM formatted).

      config :oapi_config,
        apps: [
          {:my_app, 12345, "\"-----BEGIN RSA PRIVATE KEY..."}
        ]

  ## Caching

  JWTs are designed to last for several minutes.
  """
  @spec app(atom) :: GitHub.App.t() | nil
  def app(app_name) do
    case Config.app(app_name) do
      {:ok, {_app_name, app_id, private_key}} ->
        struct(GitHub.App, %{id: app_id, pem: private_key})

      _else ->
        nil
    end
  end

  @doc """
  Run a client operation and return the raw Operation or Error

  Normal client operation calls return only the response body. This function can be useful when
  the caller needs additional information, such as data from the response headers.

  The `args` passed to this function should not include the `opts` argument usually available on
  client operations. Instead, any such options should be passed as the final argument to `raw/4`.

  ## Example

      iex> GitHub.raw(GitHub.Users, :get_authenticated, [])
      {:ok, %GitHub.Operation{}}

  """
  @spec raw(module, atom, [any], keyword) :: {:ok, Operation.t()} | {:error, Error.t()}
  def raw(module, function, args, opts \\ []) do
    opts = Keyword.put(opts, :wrap, false)

    case apply(module, function, args ++ [opts]) do
      %Operation{} = operation -> {:ok, operation}
      %Error{} = error -> {:ok, error}
    end
  end
end
