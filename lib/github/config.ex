defmodule GitHub.Config do
  @moduledoc """
  Configuration for the API client and plugins
  """

  #
  # Client Configuration
  #

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
    {GitHub.Plugin.RedixFullResponseCache, :check_cache, server: :redix},
    {GitHub.Plugin.JasonSerializer, :encode_body},
    {GitHub.Plugin.HTTPoisonClient, :request},
    {GitHub.Plugin.RedixFullResponseCache, :use_cache, server: :redix},
    {GitHub.Plugin.JasonSerializer, :decode_body},
    {GitHub.Plugin.TypedDecoder, :decode_response},
    {GitHub.Plugin.TypedDecoder, :normalize_errors}
  ]

  @spec stack :: [{module, atom}]
  def stack do
    Application.get_env(:oapi_github, :stack, @default_stack)
  end

  #
  # Plugin Configuration
  #

  @spec plugin_config(keyword, module, atom, term) :: term
  def plugin_config(config \\ [], plugin, key, default) do
    if value = Keyword.get(config, key) do
      value
    else
      Application.get_env(:oapi_github, plugin, [])
      |> Keyword.get(key, default)
    end
  end

  @spec plugin_config!(keyword, module, atom) :: term | no_return
  def plugin_config!(config \\ [], plugin, key) do
    plugin_config(config, plugin, key, nil) ||
      raise "Configuration #{key} is required for #{plugin}"
  end

  #
  # Helpers
  #

  @spec config(keyword, atom, any) :: any
  defp config(config, key, default) do
    Keyword.get(config, key, Application.get_env(:oapi_github, key, default))
  end
end
