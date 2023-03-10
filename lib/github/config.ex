defmodule GitHub.Config do
  @external_resource ".api-version"

  @default_server "https://api.github.com"
  @default_version File.read!(".api-version") |> String.trim()

  @default_stack [
    {GitHub.Plugin.JasonSerializer, :encode_body},
    {GitHub.Plugin.HTTPoisonClient, :request},
    {GitHub.Plugin.JasonSerializer, :decode_body},
    {GitHub.Plugin.TypedDecoder, :decode_response},
    {GitHub.Plugin.TypedDecoder, :normalize_errors}
  ]

  @moduledoc """
  Configuration for the API client and plugins

  > #### Note {:.info}
  >
  > Functions in this module is unlikely to be used directly by applications. Instead, they are
  > useful for plugins. See `GitHub.Plugin` for more information.

  Callers of API operation functions can pass in some configuration directly using the final
  argument. Configuration passed in this way always takes precedence over global configuration.

      # Local options:
      GitHub.Repos.get("aj-foster", "open-api-github", server: "https://gh.example.com")

      # Application environment (ex. config/config.exs):
      config :oapi_github, server: "https://gh.example.com"

  ## Options

  The following configuration is available using **local options**:

    * `server` (URL): API server to use. Useful if the client would like to target a GitHub
      Enterprise installation. Defaults to `#{@default_server}`.

    * `version` (string): API version to use. Setting this option is not recommended, as the default
      value is the version of the API used to generate this client's code. Overriding it risks the
      client raising an error. To see the default value, open `.api-version` in the root of this
      project.

  The following configuration is available using the **application environment**:

    * `app_name` (string): Name of the application using this client, used for User Agent and
      logging purposes.

    * `default_auth` (`t:GitHub.Auth.auth/0`): Default API authentication credentials to use when
      authentication was not provided for a request. OAuth applications can provide their client ID
      and secret to increase their unauthenticated rate limit.

    * `server` (URL): API server to use. Useful if the client would like to target a GitHub
      Enterprise installation. Defaults to `#{@default_server}`.

    * `stack` (list of plugins): Plugins to control the execution of client requests. See
      `GitHub.Plugin` for more information. Defaults to the default stack below.

  ## Plugins

  Client requests are implemented using a series of plugins. Each plugin accepts a
  `GitHub.Operation` struct and returns either a modified operation or an error. The collection of
  plugins configured for a request form a **stack**.

  The default stack uses `Jason` as a serializer/deserializer and `HTTPoison` as an HTTP client:

  ```
  #{inspect(@default_stack, pretty: true, width: 98)}
  ```

  In general, plugins can be defined as 2- or 3-tuples specifying the module and function name and
  any options to pass to the function. For example:

      {MyPlugin, :my_function}
      #=> MyPlugin.my_function(operation)

      {MyPlugin, :my_function, some: :option}
      #=> MyPlugin.my_function(operation, some: :option)

  By modifying the stack, applications can easily use a different HTTP client library or serializer.
  """

  @typedoc """
  Plugin definition

  Plugins are defined in the stack using module and function tuples with an optional keyword list.
  Options, if provided, will be passed as the second argument.
  """
  @type plugin ::
          {module :: module, function :: atom, options :: keyword}
          | {module :: module, function :: atom}

  #
  # Client Configuration
  #

  @doc """
  Get the configured app name

  ## Example

      iex> Config.app_name()
      "Test App"

  """
  @spec app_name :: String.t() | nil
  def app_name do
    Application.get_env(:oapi_github, :app_name)
  end

  @doc """
  Get the configured default auth credentials

  ## Example

      iex> Config.default_auth()
      {"client_one", "abc123"}

  """
  @spec default_auth :: GitHub.Auth.auth()
  def default_auth do
    Application.get_env(:oapi_github, :default_auth)
  end

  @doc """
  Get the configured default API server, or `#{@default_server}` by default

  ## Example

      iex> Config.server([])
      "https://api.github.com"

      iex> Config.server(server: "https://gh.example.com")
      "https://gh.example.com"

  """
  @spec server(keyword) :: String.t()
  def server(opts) do
    config(opts, :server, @default_server)
  end

  @doc """
  Get the configured plugin stack

  ## Example

      iex> Config.stack()
      [
        {GitHub.Plugin.JasonSerializer, :encode_body},
        # ...
      ]

  """
  @spec stack :: [plugin]
  def stack do
    Application.get_env(:oapi_github, :stack, @default_stack)
  end

  @doc """
  Get the configured API version, or `#{@default_version}` by default

  ## Example

      iex> Config.version([])
      #{inspect(@default_version)}

      iex> Config.version(version: "2020-01-01")
      "2020-01-01"

  """
  @spec version(keyword) :: String.t()
  def version(opts) do
    config(opts, :version, @default_version)
  end

  #
  # Plugin Configuration
  #

  @doc """
  Get configuration namespaced with a plugin module

  Plugins can provide a keyword list of options (such as a pre-merged keyword list of the plugin
  options argument and the operation's options) to be used if the given key is present. Otherwise,
  the response will fall back to the application environment given with the following form:

      config :oapi_github, MyPlugin, some: :option

  Where `MyPlugin` is the `plugin` module given as the second argument.

  See `plugin_config!/3` for a variant that raises if the configuration is not found.
  """
  @spec plugin_config(keyword, module, atom, term) :: term
  def plugin_config(config \\ [], plugin, key, default) do
    if value = Keyword.get(config, key) do
      value
    else
      Application.get_env(:oapi_github, plugin, [])
      |> Keyword.get(key, default)
    end
  end

  @doc """
  Get configuration namespaced with a plugin module, or raise if not present

  Plugins can provide a keyword list of options (such as a pre-merged keyword list of the plugin
  options argument and the operation's options) to be used if the given key is present. Otherwise,
  the response will fall back to the application environment given with the following form:

      config :oapi_github, MyPlugin, some: :option

  Where `MyPlugin` is the `plugin` module given as the second argument.

  See `plugin_config/4` for a variant that accepts a default value.
  """
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
