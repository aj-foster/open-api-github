defmodule GitHub.Config do
  @default_server "https://api.github.com"

  @moduledoc """
  Configuration for the API client and plugins

  ## Configuration

  Here are the available options:

    * `app_name` (string): Name of the application using this client, used for User Agent and
      logging purposes.

    * `default_auth` (`t:GitHub.Auth.auth/0`): Default API authentication credentials to use when
      authentication was not provided for a request. OAuth applications can provide their client ID
      and secret to increase their unauthenticated rate limit.

    * `server` (URL): API server to use. Useful if the client would like to target a GitHub
      Enterprise installation. Defaults to `#{@default_server}`.

    * `stack` (list of plugins): Plugins to control the execution of client requests. See
      `GitHub.Plugin` for more information.

  """

  #
  # Client Configuration
  #

  @doc "Get the configured app name"
  @spec app_name :: String.t() | nil
  def app_name do
    Application.get_env(:oapi_github, :app_name)
  end

  @doc "Get the configured default auth credentials"
  @spec default_auth :: GitHub.Auth.auth()
  def default_auth do
    Application.get_env(:oapi_github, :default_auth)
  end

  @doc "Get the configured default API server, or `#{@default_server}` by default"
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

  @doc "Get the configured plugin stack"
  @spec stack :: [{module, atom}]
  def stack do
    Application.get_env(:oapi_github, :stack, @default_stack)
  end

  #
  # Plugin Configuration
  #

  @doc "Get configuration namespaced with a plugin module"
  @spec plugin_config(keyword, module, atom, term) :: term
  def plugin_config(config \\ [], plugin, key, default) do
    if value = Keyword.get(config, key) do
      value
    else
      Application.get_env(:oapi_github, plugin, [])
      |> Keyword.get(key, default)
    end
  end

  @doc "Get configuration namespaced with a plugin module, or raise if not present"
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
