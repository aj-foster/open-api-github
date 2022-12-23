defmodule GitHub.Plugin.TypedDecoder do
  alias GitHub.Error
  alias GitHub.Operation

  @spec decode_response(Operation.t()) :: {:ok, Operation.t()}
  def decode_response(operation) do
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

  @spec normalize_errors(Operation.t()) :: {:ok, Operation.t()} | {:error, Error.t()}
  def normalize_errors(%Operation{response_body: %GitHub.BasicError{} = error} = operation) do
    %Operation{response_code: code} = operation

    {:error,
     Error.new(
       code: code,
       message: error.message,
       operation: operation,
       source: error,
       step: {__MODULE__, :normalize_errors}
     )}
  end

  def normalize_errors(%Operation{response_body: %GitHub.ValidationError{} = error} = operation) do
    %Operation{response_code: code} = operation

    {:error,
     Error.new(
       code: code,
       message: error.message,
       operation: operation,
       source: error,
       step: {__MODULE__, :normalize_errors}
     )}
  end

  def normalize_errors(operation), do: {:ok, operation}
end
