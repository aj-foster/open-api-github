defmodule GitHub.Client do
  @moduledoc false
  alias GitHub.Error
  alias GitHub.Config
  alias GitHub.Operation

  @spec request(map) :: {:ok, term} | {:error, term} | Operation.t()
  def request(%{opts: opts} = info) do
    %Operation{
      request_method: method,
      request_server: server,
      request_url: url
    } = operation = Operation.new(info)

    metadata = %{
      client: __MODULE__,
      info: info,
      request_method: method,
      request_server: server,
      request_url: url
    }

    :telemetry.span([:oapi_github, :request], metadata, fn ->
      result = reduce_stack(operation)

      if Config.wrap(opts) do
        wrap_result(result, metadata)
      else
        {result, Map.put(metadata, :response_code, 0)}
      end
    end)
  end

  @spec reduce_stack(Operation.t()) :: Operation.t() | Error.t()
  defp reduce_stack(%Operation{private: %{__opts__: opts}} = operation) do
    stack = Config.stack(opts)

    Enum.reduce_while(stack, operation, fn
      {module, function}, operation ->
        case apply(module, function, [operation, []]) do
          {:ok, operation} -> {:cont, operation}
          {:error, error} -> {:halt, error}
        end

      {module, function, options}, operation ->
        case apply(module, function, [operation, options]) do
          {:ok, operation} -> {:cont, operation}
          {:error, error} -> {:halt, error}
        end
    end)
  end

  @spec wrap_result(Operation.t() | Error.t(), map) ::
          {:ok, map} | {{:ok, term}, map} | {{:error, term}, map}
  defp wrap_result(%Operation{response_body: nil, response_code: code}, metadata)
       when code < 300 do
    {:ok, Map.put(metadata, :response_code, code)}
  end

  defp wrap_result(%Operation{response_body: response, response_code: code}, metadata)
       when code < 300 do
    {{:ok, response}, Map.put(metadata, :response_code, code)}
  end

  defp wrap_result(%Operation{response_body: response, response_code: code}, metadata) do
    {{:error, response}, Map.put(metadata, :response_code, code)}
  end

  defp wrap_result(%Error{code: code, reason: reason} = error, metadata) do
    {{:error, error}, Map.merge(metadata, %{response_code: code, error: reason})}
  end
end
