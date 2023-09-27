if Mix.env() == :dev do
  defmodule GitHub.Processor do
    @moduledoc false
    use OpenAPI.Processor

    def operation_docstring(state, operation_spec, params) do
      OpenAPI.Processor.Operation.docstring(state, operation_spec, params)
      |> String.replace("](/", "](https://docs.github.com/")
    end
  end
end
