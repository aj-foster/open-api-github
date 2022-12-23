defmodule GitHub.Operation do
  alias GitHub.Authentication
  alias GitHub.Config
  alias GitHub.Credential

  @type t :: %__MODULE__{}

  defstruct [
    :authentication,
    :private,
    :request_body,
    :request_headers,
    :request_method,
    :request_params,
    :request_server,
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
      authentication: authentication(opts[:auth]),
      private: %{},
      request_body: request_info[:body],
      request_headers: [],
      request_method: method,
      request_params: request_info[:query] || nil,
      request_server: Config.server(opts),
      request_url: url,
      response_types: response_types
    }
  end

  @spec authentication(nil) :: nil
  @spec authentication(String.t()) :: Credential.t()
  @spec authentication({String.t(), String.t()}) :: Credential.t()
  @spec authentication(struct) :: Credential.t()
  defp authentication(nil), do: nil

  defp authentication(token) when is_binary(token) do
    %Credential{bearer_token: token, type: :token}
  end

  defp authentication({username, password}) do
    %Credential{basic_auth_password: password, basic_auth_username: username, type: :basic}
  end

  defp authentication(value), do: Authentication.credentials(value)
end
