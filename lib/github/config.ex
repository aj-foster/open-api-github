defmodule GitHub.Config do
  @spec app_name :: String.t() | nil
  def app_name do
    Application.get_env(:oapi_github, :app_name)
  end

  @spec default_auth :: GitHub.Auth.auth()
  def default_auth do
    Application.get_env(:oapi_github, :default_auth)
  end

  @default_server "https://api.github.com"

  @spec server(keyword) :: String.t()
  def server(opts) do
    config(opts, :server, @default_server)
  end

  @default_stack [
    {GitHub.Plugin.JasonSerializer, :encode_body},
    {GitHub.Plugin.HTTPoisonClient, :request},
    {GitHub.Plugin.JasonSerializer, :decode_body},
    {GitHub.Plugin.TypedDecoder, :decode_response},
    {GitHub.Plugin.TypedDecoder, :normalize_errors}
  ]

  @spec stack :: [{module, atom}]
  def stack do
    Application.get_env(:oapi_github, :stack, @default_stack)
  end

  @spec config(keyword, atom, any) :: any
  defp config(config, key, default) do
    Keyword.get(config, key, Application.get_env(:oapi_github, key, default))
  end
end
