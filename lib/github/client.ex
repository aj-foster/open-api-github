defmodule GitHub.Client do
  @moduledoc false
  alias GitHub.Error
  alias GitHub.Config
  alias GitHub.Operation

  @spec request(map) :: {:ok, term} | {:error, term} | Operation.t()
  def request(%{opts: opts} = info) do
    result =
      Operation.new(info)
      |> reduce_stack()

    if Config.wrap(opts) do
      wrap_result(result)
    else
      result
    end
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

  @spec wrap_result(Operation.t() | Error.t()) :: {:ok, term} | {:error, term}
  defp wrap_result(%Operation{response_body: nil, response_code: code}) when code < 300,
    do: :ok

  defp wrap_result(%Operation{response_body: response, response_code: code}) when code < 300,
    do: {:ok, response}

  defp wrap_result(%Operation{response_body: response}), do: {:error, response}
  defp wrap_result(%Error{} = error), do: {:error, error}
end
