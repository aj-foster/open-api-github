defmodule GitHub.Plugin.TestClient do
  alias GitHub.Error
  alias GitHub.Operation
  alias GitHub.Testing

  @spec request(Operation.t(), keyword) :: {:ok, Operation.t()} | {:error, Error.t()}
  def request(%Operation{} = operation, _opts) do
    case Testing.get_mock(operation) do
      fun when is_function(fun, 0) ->
        case fun.() do
          {:ok, code, data} ->
            {:ok, %Operation{operation | response_body: data, response_code: code}}

          {:error, reason} ->
            message = "Error during test request"
            step = {__MODULE__, :request}

            {:error,
             Error.new(message: message, operation: operation, source: reason, step: step)}
        end

      {:ok, code, data} ->
        {:ok, %Operation{operation | response_body: data, response_code: code}}

      {:error, reason} ->
        message = "Error during test request"
        step = {__MODULE__, :request}

        {:error, Error.new(message: message, operation: operation, source: reason, step: step)}
    end
  end
end
