defmodule GitHub.Plugin do
  @moduledoc """
  Plugins provide functionality for the API client

  > #### Note {:.info}
  >
  > This module is unlikely to be used directly by applications. The documentation contained here
  > is useful for developers who would like to implement new functionality for the client.

  This library has no opinions on how to complete API requests. Instead of requiring a particular
  HTTP client or JSON serializer, requests are completed using a series of plugins called a
  **stack**. To modify the behavior of the client, applications can add or modify plugins.

  Plugins are functions that accept a `GitHub.Operation` struct — and any options — and return
  either an `:ok` or an `:error` tuple:

      alias GitHub.{Error, Operation}

      @spec my_plugin(Operation.t(), keyword) :: {:ok, Operation.t()} | {:error, Error.t()}
      def my_plugin(operation, opts) do
        # ...
      end

  An `:error` tuple will immediately stop the stack and return the error. An `:ok` tuple will
  continue running the stack with the modified operation struct. If the stack concludes with a
  successful operation, the `response_body` is returned.

  ## Options

  Plugins may accept options that modify their behavior. It is recommended that they consider
  options from three sources:

  1. Options passed to the operation function (available in the `__opts__` key of the operation
    struct's private field). This is likely to include options not relevant to the plugin.
  2. Options passed to the plugin definition (available as the second argument of the plugin
    function).
  3. Options defined globally using the application environment.

  This hierarchy can be accomplished by calling `Keyword.merge/2` on the plugin options argument and
  the operation's options (order matters!), then calling `GitHub.Config.plugin_config/4` to
  incorporate the application environment as a fallback. (For required options, the sibling
  function `GitHub.Config.plugin_config!/3` is also available.)

  In this way, plugins can be configured at all levels of the code:

      # Highest precedence: options from the caller
      GitHub.Repos.get("aj-foster", "open-api-github", some: :option)

      # Medium precedence: options in the plugin definition
      {MyPlugin, :my_function, some: :option}

      # Lowest precedence: global configuration
      config :oapi_github, MyPlugin, some: :option

  Plugins should take care to document their available options and avoid naming collisions.
  """
end
