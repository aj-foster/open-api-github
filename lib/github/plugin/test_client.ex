defmodule GitHub.Plugin.TestClient do
  @moduledoc """
  Local client used for testing purposes

  For more information on the testing facilities available in this library, see `GitHub.Testing`.
  """
  alias GitHub.Error
  alias GitHub.Operation
  alias GitHub.Plugin.TypedDecoder
  alias GitHub.Testing

  @generic_documentation "https://docs.github.com/en/rest"
  @not_found_message "Not Found"
  @rate_limited_documentation "https://docs.github.com/rest/overview/resources-in-the-rest-api#rate-limiting"
  @rate_limited_message "API rate limit exceeded for xxx.xxx.xxx.xxx. (But here's the good news: Authenticated requests get a higher rate limit. Check out the documentation for more details.)"
  @unauthorized_message "Must have admin rights to [resource]"

  @doc """
  Perform a client operation using mocks, and record the call for later assertions
  """
  @spec request(Operation.t(), keyword) :: {:ok, Operation.t()} | {:error, Error.t()}
  def request(operation, _opts) do
    Testing.put_call(operation)

    case Testing.get_mock_result(operation) do
      {:ok, data} -> ok(operation, data)
      {:ok, data, opts} -> ok(operation, data, opts)
      {:error, data} -> error(operation, data)
      {:error, data, opts} -> error(operation, data, opts)
    end
  end

  @spec ok(Operation.t(), any, keyword) :: {:ok, Operation.t()}
  defp ok(operation, data, opts \\ []) do
    code = Keyword.get(opts, :code, 200)
    {:ok, %Operation{operation | response_body: data, response_code: code}}
  end

  @spec error(Operation.t(), any, keyword) :: {:error, Error.t()}
  defp error(operation, data, opts \\ [])

  defp error(operation, :not_found, _opts) do
    error = %GitHub.BasicError{
      documentation_url: @generic_documentation,
      message: @not_found_message
    }

    TypedDecoder.normalize_errors(
      %Operation{operation | response_body: error, response_code: 404},
      []
    )
  end

  defp error(operation, :rate_limited, _opts) do
    error = %GitHub.BasicError{
      documentation_url: @rate_limited_documentation,
      message: @rate_limited_message
    }

    TypedDecoder.normalize_errors(
      %Operation{operation | response_body: error, response_code: 403},
      []
    )
  end

  defp error(operation, :unauthorized, _opts) do
    error = %GitHub.BasicError{
      documentation_url: @generic_documentation,
      message: @unauthorized_message
    }

    TypedDecoder.normalize_errors(
      %Operation{operation | response_body: error, response_code: 403},
      []
    )
  end

  defp error(operation, data, opts) do
    code = opts[:code] || 400
    message = "Error during test request"
    step = {__MODULE__, :request}

    {:error,
     Error.new(code: code, message: message, operation: operation, source: data, step: step)}
  end
end
