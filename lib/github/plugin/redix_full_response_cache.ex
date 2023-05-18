if Code.ensure_loaded?(Redix) do
  defmodule GitHub.Plugin.RedixFullResponseCache do
    @moduledoc """
    Use Redis to cache full API responses and perform conditional requests

    > #### Warning {:.warning}
    >
    > This plugin caches full API responses. This may include sensitive data, and it may use a lot
    > of memory. Memory usage can be controlled using the `expiration` configuration.

    GitHub's API uses [Conditional Requests](https://docs.github.com/en/rest/overview/resources-in-the-rest-api#conditional-requests)
    to provide fast responses when the client already has the latest information. Furthermore, apps
    with heavy API usage benefit from the fact that 304 responses don't count against rate limits.

    This module provides two plugins: `check_cache/2` and `use_cache/2`. When run before an API
    request, `check_cache/2` will check the configured Redis server for a cached response matching
    the request's URL and auth information. If found, the cached response's ETag will be added to
    the request headers as an `If-None-Match` header.

    If the API returns a `304 Not Modified` response, then `use_cache/2` will fill in the cached
    response body and reset the status to `200`. Otherwise, if the API returns a `200` response with
    new data, that response will be placed in the cache.

    In addition to the response body, the cache will also fill in the `Content-Length`,
    `Content-Type`, `X-Accepted-OAuth-Scopes`, and `X-OAuth-Scopes` headers, if available.

    ## Configuration

      * `server`: **Required** global name of a Redis server, as found in the `name` option of
        `Redix.start_link/2`. This library is not responsible for starting the Redix app or
        connecting to the server. This can be a single connection name or a list of connections
        in a pool. If a list is provided, a random server will be chosen for each interaction.

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
      * URL-encoded parameters (ex. `page=1`), and
      * A SHA-256 hash of the auth token used.

    By including the hashed auth token in the key, we can be reasonably sure that cached data will
    not be returned to a user that does not have access to the original data.
    """
    alias GitHub.Config
    alias GitHub.Operation

    @default_cache_prefix "oapi_github:response"
    @default_expiration_sec 60 * 60 * 24 * 30
    @private_key :redix_full_response_cache

    #
    # Before Request
    #

    @doc """
    Check Redis for cached responses for the current request

    This plugin only affects GET requests. If a cached response is found, the corresponding ETag
    will be included in the HTTP request as an `If-None-Match` header. This allows the API to
    respond with a `304 Not Modified` response that does not count against rate limits. Use the
    `use_cache/2` plugin to capture 304 responses and replace the body with the cached response.

    ## Configuration

    This plugin requires the `server` configuration, and uses the `cache_prefix` configuration.
    See **Configuration** above for more information.
    """
    @spec check_cache(Operation.t(), keyword) :: {:ok, Operation.t()}
    def check_cache(operation, options)

    def check_cache(%Operation{request_method: :get} = operation, opts) do
      %Operation{private: %{__opts__: operation_opts}} = operation
      opts = Keyword.merge(opts, operation_opts)
      server = redix_server(opts)
      key = cache_key(operation, opts)

      with {:ok, data} when is_binary(data) <- Redix.command(server, ["GET", key]),
           {:ok, %{"etag" => etag, "response" => response} = cached_data} <- Jason.decode(data) do
        accepted_oauth_scopes = Map.get(cached_data, "accepted_oauth_scopes", "")
        content_length = Map.get(cached_data, "content_length", to_string(byte_size(response)))
        content_type = Map.get(cached_data, "content_type", "application/json")
        oauth_scopes = Map.get(cached_data, "oauth_scopes", "")

        operation =
          operation
          |> Operation.put_private(@private_key, %{
            accepted_oauth_scopes: accepted_oauth_scopes,
            content_length: content_length,
            content_type: content_type,
            etag: etag,
            oauth_scopes: oauth_scopes,
            response: response
          })
          |> Operation.put_request_header("If-None-Match", etag)

        {:ok, operation}
      else
        _ -> {:ok, operation}
      end
    end

    def check_cache(operation, _opts), do: {:ok, operation}

    #
    # After Request
    #

    @doc """
    Replace 304 responses with cached data, and cache new data

    This plugin only affects GET requests. In the event of a `304 Not Modified` response (presumably
    because `check_cache/2` provided an `If-None-Match` header), this plugin will replace the
    empty response body with cached data and reset the status code to 200. In the event of a 200
    response, the new data will be added to the cache.
    """
    @spec use_cache(Operation.t(), keyword) :: {:ok, Operation.t()}
    def use_cache(operation, options)

    def use_cache(%Operation{request_method: :get, response_code: 200} = operation, opts) do
      %Operation{private: %{__opts__: operation_opts}, response_body: response} = operation
      opts = Keyword.merge(opts, operation_opts)

      accepted_oauth_scopes = Operation.get_response_header(operation, "x-accepted-oauth-scopes")
      content_length = Operation.get_response_header(operation, "content-length")
      content_type = Operation.get_response_header(operation, "content-type")
      etag = Operation.get_response_header(operation, "etag")
      oauth_scopes = Operation.get_response_header(operation, "x-oauth-scopes")

      server = redix_server(opts)
      key = cache_key(operation, opts)
      expiration = Config.plugin_config(opts, __MODULE__, :expiration, @default_expiration_sec)

      with {:ok, data} <-
             Jason.encode(%{
               accepted_oauth_scopes: accepted_oauth_scopes,
               content_length: content_length,
               content_type: content_type,
               etag: etag,
               oauth_scopes: oauth_scopes,
               response: response
             }) do
        Redix.noreply_command(server, ["SET", key, data, "EX", expiration])
      end

      {:ok, Operation.put_private(operation, :cached, false)}
    end

    def use_cache(
          %Operation{
            private: %{@private_key => %{response: response} = cached_data},
            response_code: 304
          } = operation,
          opts
        ) do
      %Operation{private: %{__opts__: operation_opts}, response_headers: headers} = operation

      accepted_oauth_scopes = Map.get(cached_data, :accepted_oauth_scopes)
      content_length = Map.get(cached_data, :content_length)
      content_type = Map.get(cached_data, :content_type, "application/json")
      oauth_scopes = Map.get(cached_data, :oauth_scopes)

      headers =
        headers
        |> maybe_add_header("Content-Length", content_length)
        |> maybe_add_header("Content-Type", content_type)
        |> maybe_add_header("X-Accepted-OAuth-Scopes", accepted_oauth_scopes)
        |> maybe_add_header("X-OAuth-Scopes", oauth_scopes)

      opts = Keyword.merge(opts, operation_opts)
      server = redix_server(opts)
      key = cache_key(operation, opts)
      expiration = Config.plugin_config(opts, __MODULE__, :expiration, @default_expiration_sec)

      Redix.noreply_command(server, ["EXPIRE", key, expiration, "GT"])

      operation = %Operation{
        operation
        | response_body: response,
          response_code: 200,
          response_headers: headers
      }

      {:ok, Operation.put_private(operation, :cached, true)}
    end

    def use_cache(operation, _opts), do: {:ok, operation}

    #
    # Helpers
    #

    @spec cache_key(Operation.t(), keyword) :: String.t()
    defp cache_key(operation, opts) do
      [
        cache_key_prefix(opts),
        cache_key_server(operation),
        cache_key_url(operation),
        cache_key_params(operation),
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

    @spec cache_key_params(Operation.t()) :: String.t()
    defp cache_key_params(%Operation{request_params: nil}), do: nil

    defp cache_key_params(%Operation{request_params: params}) do
      params
      |> Enum.sort_by(fn {key, _value} -> key end)
      |> URI.encode_query()
    end

    @spec cache_key_prefix(keyword) :: String.t()
    defp cache_key_prefix(opts) do
      Config.plugin_config(opts, __MODULE__, :cache_prefix, @default_cache_prefix)
    end

    @spec cache_key_server(Operation.t()) :: String.t()
    defp cache_key_server(%Operation{request_server: server}), do: server

    @spec cache_key_url(Operation.t()) :: String.t()
    defp cache_key_url(%Operation{request_url: url}), do: url

    @spec maybe_add_header(Operation.headers(), String.t(), String.t() | nil) ::
            Operation.headers()
    defp maybe_add_header(headers, _key, nil), do: headers
    defp maybe_add_header(headers, key, value), do: [{key, value} | headers]

    @spec redix_server(keyword) :: Redix.connection()
    defp redix_server(opts) do
      case Config.plugin_config!(opts, __MODULE__, :server) do
        servers when is_list(servers) -> Enum.random(servers)
        server -> server
      end
    end
  end
end
