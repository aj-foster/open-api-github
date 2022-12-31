if Code.ensure_loaded?(Jason) do
  defmodule GitHub.Plugin.JasonSerializer do
    alias GitHub.Error
    alias GitHub.Operation

    @spec encode_body(Operation.t(), keyword) :: {:ok, Operation.t()} | {:error, Error.t()}
    def encode_body(%Operation{request_body: nil} = operation, _opts), do: {:ok, operation}
    def encode_body(%Operation{request_body: ""} = operation, _opts), do: {:ok, operation}

    def encode_body(operation, _opts) do
      %Operation{request_body: body, request_headers: headers} = operation

      if get_content_type(headers) == "application/json" do
        case Jason.encode(body) do
          {:ok, encoded_body} ->
            {:ok, %Operation{operation | request_body: encoded_body}}

          {:error, %Jason.EncodeError{} = error} ->
            message = "Error while encoding request body"
            step = {__MODULE__, :encode_body}

            {:error, Error.new(message: message, operation: operation, source: error, step: step)}
        end
      else
        {:ok, operation}
      end
    end

    @spec decode_body(Operation.t(), keyword) :: {:ok, Operation.t()} | {:error, Error.t()}
    def decode_body(%Operation{response_body: nil} = operation, _opts), do: {:ok, operation}
    def decode_body(%Operation{response_body: ""} = operation, _opts), do: {:ok, operation}

    def decode_body(operation, _opts) do
      %Operation{response_body: body, response_headers: headers} = operation

      if get_content_type(headers) =~ "application/json" do
        case Jason.decode(body) do
          {:ok, decoded_body} ->
            {:ok, %Operation{operation | response_body: decoded_body}}

          {:error, %Jason.DecodeError{} = error} ->
            message = "Error while decoding response body"
            step = {__MODULE__, :decode_body}

            {:error, Error.new(message: message, operation: operation, source: error, step: step)}
        end
      else
        {:ok, operation}
      end
    end

    @spec get_content_type(HTTPoison.headers()) :: String.t() | nil
    defp get_content_type([]), do: nil
    defp get_content_type([{"content-type", content_type} | _rest]), do: content_type
    defp get_content_type([{"Content-Type", content_type} | _rest]), do: content_type
    defp get_content_type([_ | rest]), do: get_content_type(rest)
  end
end
