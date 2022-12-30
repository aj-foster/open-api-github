if Code.ensure_loaded?(Redix) do
  defmodule GitHub.Plugin.RedixFullResponseCache do
    alias GitHub.Operation

    @default_expiration_sec 60 * 60 * 24 * 30
    @private_key :redix_full_response_cache

    #
    # Before Request
    #

    @spec check_cache(Operation.t()) :: {:ok, Operation.t()}
    def check_cache(operation, options \\ [])

    def check_cache(%Operation{request_method: :get} = operation, opts) do
      server = config!(opts, :server)
      key = cache_key(operation)

      with {:ok, data} when is_binary(data) <- Redix.command(server, ["GET", key]),
           {:ok, %{"content_type" => content_type, "etag" => etag, "response" => response}} <-
             Jason.decode(data) do
        operation =
          operation
          |> Operation.put_private(@private_key, %{
            content_type: content_type,
            etag: etag,
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

    @spec use_cache(Operation.t(), keyword) :: {:ok, Operation.t()}
    def use_cache(operation, options \\ [])

    def use_cache(%Operation{request_method: :get, response_code: 200} = operation, opts) do
      %Operation{response_body: response, response_headers: headers} = operation |> IO.inspect()
      content_type = get_content_type(headers)
      etag = get_etag(headers)

      server = config!(opts, :server)
      key = cache_key(operation)
      expiration = config(opts, :expiration, @default_expiration_sec)

      with {:ok, data} <-
             Jason.encode(%{content_type: content_type, etag: etag, response: response}) do
        Redix.noreply_command(server, ["SET", key, data, "EX", expiration])
      end

      {:ok, operation}
    end

    def use_cache(
          %Operation{
            private: %{@private_key => %{content_type: content_type, response: response}},
            response_code: 304,
            response_headers: headers
          } = operation,
          _opts
        ) do
      operation = %Operation{
        operation
        | response_body: response,
          response_code: 200,
          response_headers: [{"Content-Type", content_type} | headers]
      }

      {:ok, operation}
    end

    def use_cache(operation, _opts), do: {:ok, operation}

    #
    # Helpers
    #

    @spec cache_key(Operation.t()) :: String.t()
    defp cache_key(operation) do
      [
        "oapi_github",
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

    @spec cache_key_url(Operation.t()) :: String.t()
    defp cache_key_url(%Operation{request_url: url}), do: url

    @spec config(keyword, atom, term) :: term
    defp config(config, key, default) do
      if value = Keyword.get(config, key) do
        value
      else
        Application.get_env(:oapi_github, __MODULE__, [])
        |> Keyword.get(key, default)
      end
    end

    @spec config!(keyword, atom) :: term
    defp config!(config, key) do
      config(config, key, nil) || raise "Configuration #{key} is required for #{__MODULE__}"
    end

    @spec get_content_type([{String.t(), String.t()}]) :: String.t() | nil
    defp get_content_type([]), do: nil
    defp get_content_type([{"content-type", content_type} | _rest]), do: content_type
    defp get_content_type([{"Content-Type", content_type} | _rest]), do: content_type
    defp get_content_type([_ | rest]), do: get_content_type(rest)

    @spec get_etag([{String.t(), String.t()}]) :: String.t() | nil
    defp get_etag([]), do: nil

    defp get_etag([{header, value} | rest]) do
      if String.match?(header, ~r/^etag$/i) do
        value
      else
        get_etag(rest)
      end
    end
  end
end
