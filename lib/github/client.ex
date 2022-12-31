defmodule GitHub.Client do
  @moduledoc false
  alias GitHub.Error
  alias GitHub.Config
  alias GitHub.Operation

  @spec request(map) :: {:ok, term} | {:error, term}
  def request(info) do
    Operation.new(info)
    |> reduce_stack()
    |> wrap_result()
  end

  @spec reduce_stack(Operation.t()) :: Operation.t() | Error.t()
  defp reduce_stack(operation) do
    stack = Config.stack()

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
