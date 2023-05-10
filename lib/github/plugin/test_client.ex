defmodule GitHub.Plugin.TestClient do
  alias GitHub.Error
  alias GitHub.Operation

  # @pd_call_key :oapi_github_test_call
  @pd_mock_key :oapi_github_test_mock

  @type mock :: %{
          :args => [any] | :_,
          :implicit => boolean,
          :limit => pos_integer | :infinity,
          :return =>
            {:ok, integer, any} | {:error, any} | (() -> {:ok, integer, any} | {:error, any})
        }

  @type mocks :: %{{module, atom} => [mock]}

  @spec request(Operation.t(), keyword) :: {:ok, Operation.t()} | {:error, Error.t()}
  def request(%Operation{} = operation, _opts) do
    case get_mock(operation) do
      fun when is_function(fun, 0) ->
        case fun.() do
          {:ok, code, data} ->
            {:ok, %Operation{operation | response_body: data, response_code: code}}
        end

      {:ok, code, data} ->
        {:ok, %Operation{operation | response_body: data, response_code: code}}
    end
  end

  defp get_mock(operation) do
    {module, function, args} = Operation.get_caller(operation)

    Process.get(@pd_mock_key, %{})
    |> Map.get({module, function})
    |> choose_mock(args)
    |> case do
      %{args: ^args, return: mock} ->
        mock

      %{return: mock} ->
        put_mock(module, function, args, true, :infinity, mock.())

      nil ->
        mock = generate_response(operation)
        open_args = Enum.map(args, fn _ -> :_ end)
        put_mock(module, function, open_args, true, :infinity, mock)
        put_mock(module, function, args, true, :infinity, mock.())
    end
  end

  defp choose_mock(nil, _args), do: nil

  defp choose_mock(mocks, args) do
    mocks
    |> Enum.reject(fn %{args: mock_args} -> length(mock_args) != length(args) end)
    |> Enum.reject(fn %{args: mock_args} ->
      Enum.zip(mock_args, args)
      |> Enum.any?(fn
        {:_, _} -> false
        {same_value, same_value} -> false
        _else -> true
      end)
    end)
    |> Enum.sort_by(fn
      %{args: ^args, implicit: false} ->
        1

      %{args: ^args, implicit: true} ->
        2

      %{args: mock_args, implicit: false} ->
        Enum.zip(mock_args, args)
        |> Enum.count(fn {mock_arg, arg} -> mock_arg == arg end)
        |> Kernel.+(10)

      %{args: mock_args, implicit: true} ->
        Enum.zip(mock_args, args)
        |> Enum.count(fn {mock_arg, arg} -> mock_arg == arg end)
        |> Kernel.+(50)

      _else ->
        99
    end)
    |> List.first()
  end

  defp generate_response(%Operation{response_types: [{code, type} | _]}) do
    fn ->
      {:ok, code, GitHub.Testing.generate(nil, nil, type)}
    end
  end

  def put_mock(module, function, args, implicit, limit, mock) do
    all_mocks = Process.get(@pd_mock_key, %{})
    new_mock = %{args: args, implicit: implicit, limit: limit, return: mock}
    new_mocks = [new_mock | Map.get(all_mocks, {module, function}, [])]

    updated_mocks = Map.put(all_mocks, {module, function}, new_mocks)
    Process.put(@pd_mock_key, updated_mocks)

    mock
  end
end
