defmodule GitHub.Config do
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
    config([], :stack, @default_stack)
  end

  @spec config(keyword, atom, any) :: any
  defp config(config, key, default) do
    Keyword.get(config, key, Application.get_env(:oapi_github, key, default))
  end
end
