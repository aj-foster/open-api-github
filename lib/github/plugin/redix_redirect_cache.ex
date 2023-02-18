if Code.ensure_loaded?(Redix) do
  defmodule GitHub.Plugin.RedixRedirectCache do
    @moduledoc """
    Use Redis to cache redirect locations to avoid unexpected rate limits

    > #### Warning {:.warning}
    >
    > This plugin caches information about the names and locations of private repositories,
    > potentially disclosing information if not used carefully.

    GitHub's API uses [Conditional Requests](https://docs.github.com/en/rest/overview/resources-in-the-rest-api#conditional-requests)
    to provide fast responses when the client already has the latest information. Furthermore, apps
    with heavy API usage benefit from the fact that 304 responses don't count against rate limits.

    **However**, it may not be obvious to API users that redirect responses always count against
    your rate limit, even if the ultimate location returns a 304 response.

    This module provides two plugins: `check_cache/2` and `update_cache/2`. When run before an API
    request, `check_cache/2` will check the configured Redis server for a known final location for
    the intended request. If found, it will modify the request to use the new URL instead.

    If the API returns a successful or unmodified response, and the final location differs from
    the original location (meaning a redirect took place), then is will store the new location in
    in the cache.

    ## Limitations

    * This plugin requires the client plugin to modify the Operation when a redirection takes place.
      Otherwise, it will not know that the final location has changed.

    * This plugin cannot know the exact HTTP status code that accompanied the redirect. As a result,
      there is a risk that it will cache temporary redirects as well as permanent ones.

    ## Configuration

      * `server`: **Required** global name of a Redis server, as found in the `name` option of
        `Redix.start_link/2`. This library is not responsible for starting the Redix app or
        connecting to the server.

      * `cache_prefix`: Prefix to use for all Redis cache keys. Defaults to `"oapi_github"`.

      * `expiration`: Time, in seconds, before cached data should expire. Defaults to 30 days.

    These options may be passed via the plugin definition or by global configuration:

        config :oapi_github,
          stack: [
            {#{inspect(__MODULE__)}, :check_cache, server: :redix_server_1},
            # ...
          ]

        config :oapi_github, #{inspect(__MODULE__)},
          server: :redix_server_1

    ## Cache Keys

    Cache keys used by this module have the following parts (separated by colons):

      * A standard prefix (see `prefix` configuration),
      * The server for the request (ex. `api.github.com`),
      * The path of the request (ex. `/repos/aj-foster`),
      * A SHA-256 hash of the auth token used.

    By including the hashed auth token in the key, we can be reasonably sure that cached data will
    not be returned to a user that does not have access to the original data. While this may seem
    trivial for location data, remember that GitHub deliberately returns 404 responses for private
    repositories rather than 403 responses.
    """
    alias GitHub.Config
    alias GitHub.Operation

    @default_cache_prefix "oapi_github:redirect"
    @default_expiration_sec 60 * 60 * 24 * 30
    @private_key :redix_redirect_cache

    #
    # Before Request
    #

    @doc """
    Check Redis for cached location changes for the current request

    This plugin only affects GET requests. If a cached location is found, the URL of the operation
    will change to match the known final destination.

    ## Configuration

    This plugin requires the `server` configuration, and uses the `cache_prefix` configuration.
    See **Configuration** above for more information.
    """
    @spec check_cache(Operation.t(), keyword) :: {:ok, Operation.t()}
    def check_cache(operation, options)

    def check_cache(%Operation{request_method: :get} = operation, opts) do
      %Operation{
        private: %{__opts__: operation_opts},
        request_server: original_server,
        request_url: original_path
      } = operation

      opts = Keyword.merge(opts, operation_opts)
      server = Config.plugin_config!(opts, __MODULE__, :server)
      key = cache_key(operation, opts)

      with {:ok, data} when is_binary(data) <- Redix.command(server, ["GET", key]),
           {:ok, %{"server" => server, "path" => path}} <- Jason.decode(data) do
        operation =
          operation
          |> Operation.put_private(@private_key, %{
            original: %{server: original_server, path: original_path},
            cached: %{server: server, path: path}
          })
          |> Map.put(:request_server, server)
          |> Map.put(:request_url, path)

        {:ok, operation}
      else
        _ ->
          operation =
            Operation.put_private(operation, @private_key, %{
              original: %{server: original_server, path: original_path}
            })

          {:ok, operation}
      end
    end

    def check_cache(operation, _opts), do: {:ok, operation}

    #
    # After Request
    #

    @doc """
    Cache redirect locations

    This plugin only affects GET requests. In the event of a successful (200) or unmodified (304)
    response, this will check whether the original URL matches the final URL for the request. If
    they differ, then it will store the updated location. If they do not differ because the
    location was updated in `check_cache/2`, then the expiration of the cached location will be
    extended.
    """
    @spec update_cache(Operation.t(), keyword) :: {:ok, Operation.t()}
    def update_cache(operation, options)

    def update_cache(
          %Operation{
            private: %{@private_key => %{cached: %{server: server, path: path}}},
            request_server: server,
            request_url: path,
            response_code: code
          } = operation,
          opts
        )
        when code in [200, 304] do
      %Operation{private: %{__opts__: operation_opts}} = operation
      opts = Keyword.merge(opts, operation_opts)
      server = Config.plugin_config!(opts, __MODULE__, :server)
      key = cache_key(operation, opts)
      expiration = Config.plugin_config(opts, __MODULE__, :expiration, @default_expiration_sec)

      Redix.noreply_command(server, ["EXPIRE", key, expiration, "GT"])

      {:ok, operation}
    end

    def update_cache(
          %Operation{
            private: %{@private_key => %{original: %{server: server, path: path}}},
            request_server: server,
            request_url: path,
            response_code: code
          } = operation,
          _opts
        )
        when code in [200, 304] do
      {:ok, operation}
    end

    def update_cache(%Operation{response_code: code} = operation, opts) when code in [200, 304] do
      %Operation{
        private: %{__opts__: operation_opts},
        request_server: final_server,
        request_url: final_path
      } = operation

      opts = Keyword.merge(opts, operation_opts)
      server = Config.plugin_config!(opts, __MODULE__, :server)
      key = cache_key(operation, opts)
      expiration = Config.plugin_config(opts, __MODULE__, :expiration, @default_expiration_sec)

      with {:ok, data} <- Jason.encode(%{server: final_server, path: final_path}) do
        Redix.noreply_command(server, ["SET", key, data, "EX", expiration])
      end

      {:ok, operation}
    end

    def update_cache(operation, _opts), do: {:ok, operation}

    #
    # Helpers
    #

    @spec cache_key(Operation.t(), keyword) :: String.t()
    defp cache_key(operation, opts) do
      [
        cache_key_prefix(opts),
        cache_key_server(operation),
        cache_key_url(operation),
        cache_key_auth(operation)
      ]
      |> Enum.reject(&is_nil/1)
      |> Enum.join(":")
    end

    @spec cache_key_auth(Operation.t()) :: String.t()
    defp cache_key_auth(%Operation{private: %{__auth__: nil}}), do: nil

    defp cache_key_auth(%Operation{private: %{__auth__: auth}}) do
      :crypto.hash(:sha256, auth)
      |> Base.encode64(padding: false)
    end

    @spec cache_key_prefix(keyword) :: String.t()
    defp cache_key_prefix(opts) do
      Config.plugin_config(opts, __MODULE__, :cache_prefix, @default_cache_prefix)
    end

    @spec cache_key_server(Operation.t()) :: String.t()
    defp cache_key_server(%Operation{private: %{@private_key => %{original: %{server: server}}}}) do
      server
    end

    defp cache_key_server(%Operation{request_server: server}), do: server

    @spec cache_key_url(Operation.t()) :: String.t()
    defp cache_key_url(%Operation{private: %{@private_key => %{original: %{path: path}}}}) do
      path
    end

    defp cache_key_url(%Operation{request_url: url}), do: url
  end
end
