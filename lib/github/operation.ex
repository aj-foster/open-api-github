defmodule GitHub.Operation do
  alias GitHub.Auth
  alias GitHub.Config

  @type t :: %__MODULE__{}
  @type auth :: nil | (token :: String.t()) | {username :: String.t(), password :: String.t()}

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
      private: %{__info__: request_info},
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
    |> put_user_agent()
  end

  @spec put_auth_header(t, auth) :: t
  defp put_auth_header(operation, nil) do
    if auth = Config.default_auth() do
      put_auth_header(operation, auth)
    else
      operation
    end
  end

  defp put_auth_header(operation, token) when is_binary(token) do
    put_request_header(operation, "Authorization", "Bearer #{token}")
  end

  defp put_auth_header(operation, {username, password}) do
    basic_auth = Base.encode64("#{username}:#{password}")
    put_request_header(operation, "Authorization", "Basic #{basic_auth}")
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

  @spec put_request_header(t, String.t(), String.t()) :: t
  def put_request_header(operation, header, value) do
    %__MODULE__{request_headers: headers} = operation
    %__MODULE__{operation | request_headers: [{header, value} | headers]}
  end
end
