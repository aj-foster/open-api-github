defmodule GitHub.Operation do
  @moduledoc """
  Defines a struct that tracks client requests

  > #### Note {:.info}
  >
  > This module is unlikely to be used directly by applications. Instead, functions in this module
  > are useful for plugins. See `GitHub.Plugin` for more information.

  ## Fields

    * `private` (map): This field is useful for plugins that need to store information. Plugins
      should be careful to namespace their data to avoid overlap. By default, this map will include
      an `__auth__` key with the auth credentials used for the request, `__info__` containing the
      information that originated the request, and `__opts__` containing all of the options passed
      in to the original operation function.

    * `request_body` (term): For requests that support request bodies, this key will hold the data
      to be included in an outgoing request. Depending on the plugins involved, this key may have
      Elixir terms (like a map) or strings (such as a JSON-encoded string).

    * `request_headers` (list of headers): HTTP headers to be included in the outgoing request.
      These are specified as tuples with the name of the header and its value.

    * `request_method` (atom): HTTP verb of the outgoing request.

    * `request_params` (keyword): URL-based query parameters for the outgoing request.

    * `request_server` (string): URL scheme and hostname of the API server for the request.

    * `request_types` (list of types): OpenAPI type specifications for the request body. These are
      specified as tuples with the Content-Type and the type specification.

    * `request_url` (string): URL path of the outgoing request.

    * `response_body` (term): For responses that include response bodies, this key will hold the
      data from the response. Depending on the plugins involved, this key may have raw response data
      (such as a JSON-encoded string) or Elixir terms (like a map).

    * `response_code` (integer): Response status code.

    * `response_headers` (list of headers): HTTP headers from the response. These are specified as
      tuples with the name of the header and its value.

    * `response_types` (list of types): OpenAPI type specifications for the response body. These are
      specified as tuples with the status code and the type specification.

  """

  alias GitHub.Auth
  alias GitHub.Config

  @type auth :: nil | (token :: String.t()) | {username :: String.t(), password :: String.t()}
  @type header :: {String.t(), String.t()}
  @type headers :: [header]
  @type method :: :get | :put | :post | :delete | :options | :head | :patch | :trace
  @type request_type :: {String.t(), type}
  @type request_types :: [request_type]
  @type response_type :: {integer, type | nil}
  @type response_types :: [response_type]

  @typedoc "Type annotation produced by [OpenAPI](https://github.com/aj-foster/open-api-generator)"
  @type type ::
          :binary
          | :boolean
          | :integer
          | :map
          | :number
          | :string
          | :unknown
          | {:array, type}
          | {:nullable, type}
          | {:union, [type]}
          | {module, atom}

  @typedoc "Operation struct for tracking client requests from start to finish"
  @type t :: %__MODULE__{
          private: map,
          request_body: term,
          request_headers: headers,
          request_method: method,
          request_params: keyword | [{String.t(), String.t()}] | nil,
          request_server: String.t(),
          request_types: request_types | nil,
          request_url: String.t(),
          response_body: term,
          response_code: integer | nil,
          response_headers: headers | nil,
          response_types: response_types
        }

  defstruct [
    :private,
    :request_body,
    :request_headers,
    :request_method,
    :request_params,
    :request_server,
    :request_types,
    :request_url,
    :response_body,
    :response_code,
    :response_headers,
    :response_types
  ]

  #
  # Plugin Helpers
  #

  @doc """
  Get the client's calling function and original arguments

  This level of introspection is meant for testing purposes, although other plugins can take
  advantage of it as necessary.
  """
  @spec get_caller(t) :: {module, atom, [any]}
  def get_caller(operation) do
    %__MODULE__{private: %{__info__: %{args: args, call: {module, function}}}} = operation
    {module, function, Keyword.values(args)}
  end

  @doc """
  Get the value of a response header

  If response headers have not been filled in — or the response did not have the given header —
  then `nil` will be returned.

  ## Examples

      iex> operation = %Operation{response_headers: [{"Content-Type", "application/json"}]}
      iex> Operation.get_response_header(operation, "Content-Type")
      "application/json"

      iex> operation = %Operation{response_headers: []}
      iex> Operation.get_response_header(operation, "ETag")
      nil

  """
  @spec get_response_header(t, String.t()) :: String.t() | nil
  def get_response_header(operation, header) do
    %__MODULE__{response_headers: headers} = operation
    header = String.downcase(header)

    case Enum.find(headers, fn {name, _value} -> String.downcase(name) == header end) do
      {_header, value} -> value
      _ -> nil
    end
  end

  @doc """
  Put information in the operation's private data store

  Existing data with the same key will be overridden.

  ## Example

      iex> operation = %Operation{private: %{}}
      iex> operation = Operation.put_private(operation, :my_plugin_data, "abc123")
      %Operation{private: %{my_plugin_data: "abc123"}} = operation

  """
  @spec put_private(t, atom, term) :: t
  def put_private(operation, key, value) do
    %__MODULE__{private: private} = operation
    %__MODULE__{operation | private: Map.put(private, key, value)}
  end

  @doc """
  Add a request header to an outgoing operation

  This function makes no effort to deduplicate headers.

  ## Example

      iex> operation = %Operation{request_headers: []}
      iex> operation = Operation.put_request_header(operation, "Content-Type", "application/json")
      %Operation{request_headers: [{"Content-Type", "application/json"}]} = operation

  """
  @spec put_request_header(t, String.t(), String.t()) :: t
  def put_request_header(operation, header, value) do
    %__MODULE__{request_headers: headers} = operation
    %__MODULE__{operation | request_headers: [{header, value} | headers]}
  end

  #
  # Internal
  #

  @doc false
  @spec new(map) :: t
  def new(
        %{
          url: url,
          method: method,
          response: response_types,
          opts: opts
        } = request_info
      ) do
    %__MODULE__{
      private: %{__info__: request_info, __opts__: opts},
      request_body: request_info[:body],
      request_headers: [],
      request_method: method,
      request_params: request_info[:query],
      request_server: Config.server(opts),
      request_types: request_info[:request],
      request_url: url,
      response_types: response_types
    }
    |> put_auth_header(opts[:auth])
    |> put_content_type_header()
    |> put_version_header(Config.version(opts))
    |> put_user_agent()
  end

  @spec put_auth_header(t, auth) :: t
  defp put_auth_header(operation, nil) do
    if auth = Config.default_auth() do
      put_auth_header(operation, auth)
    else
      put_private(operation, :__auth__, nil)
    end
  end

  defp put_auth_header(operation, token) when is_binary(token) do
    operation
    |> put_request_header("Authorization", "Bearer #{token}")
    |> put_private(:__auth__, token)
  end

  defp put_auth_header(operation, {username, password}) do
    basic_auth = Base.encode64("#{username}:#{password}")

    operation
    |> put_request_header("Authorization", "Basic #{basic_auth}")
    |> put_private(:__auth__, basic_auth)
  end

  defp put_auth_header(operation, value) do
    auth = Auth.to_auth(value)
    put_auth_header(operation, auth)
  end

  @spec put_content_type_header(t) :: t
  defp put_content_type_header(%__MODULE__{request_types: nil} = operation), do: operation

  defp put_content_type_header(%__MODULE__{request_types: [type]} = operation) do
    {content_type, _body_type} = type
    put_request_header(operation, "Content-Type", content_type)
  end

  @spec put_version_header(t, String.t()) :: t
  defp put_version_header(operation, version) do
    put_request_header(operation, "X-GitHub-Api-Version", version)
  end

  @spec put_user_agent(t) :: t
  defp put_user_agent(operation) do
    user_agent =
      IO.iodata_to_binary([
        Config.app_name() || "Unknown App",
        " via oapi_github ",
        Application.spec(:oapi_github, :vsn),
        "; Elixir ",
        System.version(),
        " / OTP ",
        System.otp_release()
      ])

    put_request_header(operation, "User-Agent", user_agent)
  end
end
