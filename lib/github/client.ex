defmodule GitHub.Client do
  alias GitHub.Operation
  alias GitHub.Plugin.HTTPoisonClient
  alias GitHub.Plugin.JasonSerializer

  defp temporary_stack do
    [
      {JasonSerializer, :encode_body},
      {HTTPoisonClient, :request},
      {JasonSerializer, :decode_body},
      {__MODULE__, :decode_as_type}
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

  def decode_as_type(operation) do
    %Operation{response_body: body, response_code: code, response_types: types} = operation

    if type = get_type(types, code) do
      decoded_body = do_decode(body, type)
      {:ok, %Operation{operation | response_body: decoded_body}}
    else
      {:ok, operation}
    end
  end

  defp get_type(types, code) do
    if res = Enum.find(types, fn {c, _} -> c == code end) do
      elem(res, 1)
    end
  end

  defp do_decode(%{} = value, {module, type}) do
    fields = module.__fields__(type)

    for {field_name, field_type} <- fields, reduce: struct(module) do
      decoded_value ->
        if field_value = Map.get(value, to_string(field_name)) do
          decoded_field_value = do_decode(field_value, field_type)
          struct(decoded_value, [{field_name, decoded_field_value}])
        else
          decoded_value
        end
    end
  end

  defp do_decode(value, _type), do: value
end
