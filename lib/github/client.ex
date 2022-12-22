defmodule GitHub.Client do
  alias GitHub.Operation
  alias GitHub.Plugin.HTTPoisonClient
  alias GitHub.Plugin.JasonSerializer

  defp temporary_stack do
    [
      {JasonSerializer, :encode_body},
      {HTTPoisonClient, :request},
      {JasonSerializer, :decode_body}
    ]
  end

  def request(info) do
    operation = Operation.new(info)

    Enum.reduce_while(temporary_stack(), operation, fn {module, function}, operation ->
      case apply(module, function, [operation]) do
        {:ok, operation} -> {:cont, operation}
        {:error, error} -> {:halt, error}
      end
    end)
  end
end
