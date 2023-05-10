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
    generator = generator(type)

    fn ->
      [data] = Enum.take(generator, 1)
      {:ok, code, data}
    end
  end

  @spec generator(Operation.type() | :id) :: StreamData.t(any)
  defp generator(:binary), do: StreamData.binary()
  defp generator(:boolean), do: StreamData.boolean()

  defp generator(:id),
    do: %StreamData{
      generator: fn _, _ -> %StreamData.LazyTree{root: System.unique_integer([:positive])} end
    }

  defp generator(:integer), do: StreamData.positive_integer()
  defp generator(:map), do: StreamData.constant(%{})
  defp generator(:number), do: StreamData.one_of([StreamData.integer(), StreamData.float()])
  defp generator(:string), do: StreamData.string(:alphanumeric, min_length: 5)
  defp generator(:null), do: StreamData.constant(nil)
  defp generator(:unknown), do: StreamData.constant(nil)
  defp generator({:array, type}), do: StreamData.list_of(generator(type))

  defp generator({:union, types}) do
    Enum.map(types, &generator/1)
    |> StreamData.one_of()
  end

  defp generator({:nullable, type}) do
    [generator(type), StreamData.constant(nil)]
    |> StreamData.one_of()
  end

  defp generator({module, type}) do
    apply(module, :__fields__, [type])
    |> Enum.map(fn
      {:id, :integer} -> {:id, generator(:id)}
      {key, type} -> {key, generator(type)}
    end)
    |> StreamData.fixed_map()
    |> StreamData.map(&struct(module, &1))
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

"""
Create a nice method of supplying a specification to the test client. Can match on URL, method, body,
etc. Supply exact match or Regex for strings. Maybe make it a macro and store the AST of the items
to match on. Would be nice to be able to match on MFA of the operation too.

Tiers of matching mocks:

1. Exact matches
2. General matches (push a repo to be returned by anything that returns a repo)
3. Check config: default to returning an error OR default to returning stream data of the right type

Not sure how to accomplish (2) while also giving distinct responses for different inputs. Maybe that
is out of scope here. Could restrict general type matches to a single record per type.

Record all calls. Use similar matcher system for asserting calls.
"""
