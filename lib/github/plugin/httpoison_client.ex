if Code.ensure_loaded?(HTTPoison) do
  defmodule GitHub.Plugin.HTTPoisonClient do
    alias GitHub.Error
    alias GitHub.Operation

    @http_code_success 200..206
    @http_code_redirect [301, 302, 303, 307, 308]
    @http_code_server_error 500..511

    @spec request(Operation.t()) :: {:ok, Operation.t()} | {:error, Error.t()}
    def request(
          %Operation{
            request_body: body,
            request_headers: headers,
            request_method: method,
            request_params: params,
            request_server: server,
            request_url: url
          } = operation
        ) do
      url = Path.join(server, url)
      body = body || ""
      options = if params, do: [params: params], else: []

      case HTTPoison.request(method, url, body, headers, options) do
        {:ok, %HTTPoison.Response{} = response} ->
          process_response(operation, response)

        {:error, %HTTPoison.Error{} = error} ->
          message = "Error during HTTP request"
          step = {__MODULE__, :encode_body}

          {:error, Error.new(message: message, operation: operation, source: error, step: step)}
      end
    end

    @spec process_response(Operation.t(), HTTPoison.Response.t()) ::
            {:ok, Operation.t()} | {:error, Error.t()}
    defp process_response(operation, %HTTPoison.Response{status_code: code} = response)
         when code in @http_code_success do
      %HTTPoison.Response{body: body, headers: headers} = response

      operation = %Operation{
        operation
        | response_body: body,
          response_code: code,
          response_headers: headers
      }

      {:ok, operation}
    end

    defp process_response(operation, %HTTPoison.Response{status_code: code} = response)
         when code in @http_code_redirect do
      if location = get_redirect(response.headers) do
        operation = %Operation{operation | request_url: location}
        request(operation)
      else
        message = "Received redirect response with no Location header"
        step = {__MODULE__, :request}

        {:error,
         Error.new(
           code: code,
           message: message,
           operation: operation,
           source: response,
           step: step
         )}
      end
    end

    defp process_response(operation, %HTTPoison.Response{status_code: code} = response)
         when code in @http_code_server_error do
      message = "Received server error response (#{code})"
      step = {__MODULE__, :request}

      {:error,
       Error.new(
         code: code,
         message: message,
         operation: operation,
         source: response,
         step: step
       )}
    end

    defp process_response(operation, response) do
      %HTTPoison.Response{body: body, headers: headers, status_code: code} = response

      operation = %Operation{
        operation
        | response_body: body,
          response_code: code,
          response_headers: headers
      }

      {:ok, operation}
    end

    @spec get_redirect(HTTPoison.headers()) :: String.t() | nil
    defp get_redirect([]), do: nil
    defp get_redirect([{"location", location} | _rest]), do: location
    defp get_redirect([{"Location", location} | _rest]), do: location
    defp get_redirect([_ | rest]), do: get_redirect(rest)
  end
end
