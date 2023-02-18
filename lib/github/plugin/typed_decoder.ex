defmodule GitHub.Plugin.TypedDecoder do
  alias GitHub.BasicError
  alias GitHub.Error
  alias GitHub.Operation
  alias GitHub.ValidationError

  @spec decode_response(Operation.t(), keyword) :: {:ok, Operation.t()}
  def decode_response(operation, _opts) do
    %Operation{response_body: body, response_code: code, response_types: types} = operation

    case get_type(types, code) do
      {:ok, response_type} ->
        decoded_body = do_decode(body, response_type)
        {:ok, %Operation{operation | response_body: decoded_body}}

      {:error, :not_found} ->
        {:ok, operation}
    end
  end

  defp get_type(types, code) do
    if res = Enum.find(types, fn {c, _} -> c == code end) do
      {:ok, elem(res, 1)}
    else
      {:error, :not_found}
    end
  end

  defp do_decode(nil, {:nullable, _type}), do: nil
  defp do_decode(value, {:nullable, type}), do: do_decode(value, type)

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

  defp do_decode("", nil), do: nil
  defp do_decode(value, _type), do: value

  @spec normalize_errors(Operation.t(), keyword) :: {:ok, Operation.t()} | {:error, Error.t()}
  def normalize_errors(%Operation{response_body: %BasicError{} = error} = operation, _opts) do
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

  def normalize_errors(%Operation{response_body: %ValidationError{} = error} = operation, _opts) do
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

  def normalize_errors(operation, _opts), do: {:ok, operation}
end
