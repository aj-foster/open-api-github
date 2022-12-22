if Code.ensure_loaded?(Jason) do
  defmodule GitHub.Plugin.JasonSerializer do
    alias GitHub.ClientError
    alias GitHub.Operation

    @spec encode_body(Operation.t()) :: {:ok, Operation.t()} | {:error, ClientError.t()}
    def encode_body(%Operation{request_body: nil} = operation), do: {:ok, operation}
    def encode_body(%Operation{request_body: ""} = operation), do: {:ok, operation}

    def encode_body(operation) do
      %Operation{request_body: body, request_headers: headers} = operation

      if get_content_type(headers) == "application/json" do
        case Jason.encode(body) do
          {:ok, encoded_body} ->
            {:ok, %Operation{operation | request_body: encoded_body}}

          {:error, %Jason.EncodeError{} = error} ->
            message = "Error while encoding request body"

            {:ok,
             %ClientError{message: message, phase: {__MODULE__, :encode_body}, source: error}}
        end
      else
        {:ok, operation}
      end
    end

    @spec decode_body(Operation.t()) :: {:ok, Operation.t()} | {:error, ClientError.t()}
    def decode_body(%Operation{response_body: nil} = operation), do: {:ok, operation}
    def decode_body(%Operation{response_body: ""} = operation), do: {:ok, operation}

    def decode_body(operation) do
      %Operation{response_body: body, response_headers: headers} = operation

      if get_content_type(headers) =~ "application/json" do
        case Jason.decode(body) do
          {:ok, decoded_body} ->
            {:ok, %Operation{operation | response_body: decoded_body}}

          {:error, %Jason.DecodeError{} = error} ->
            message = "Error while decoding response body"

            {:ok,
             %ClientError{message: message, phase: {__MODULE__, :decode_body}, source: error}}
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
