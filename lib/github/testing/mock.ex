defmodule GitHub.Testing.Mock do
  @moduledoc """
  Internal representation of a mocked API call
  """

  @typedoc """
  Specification of arguments

  Each set of arguments can be given as a list of elements to match or a total arity. When given
  as a list, each element can be any Erlang term or the special value `:_` to match any value.
  Specifications given as a list will have higher precedence depending on the number of arguments
  that match exactly.
  """
  @type args :: [any] | non_neg_integer

  @typedoc """
  Limit to the number of times a mock can be used

  The special value `:infinity` can be used to place no limit.
  """
  @type limit :: pos_integer | :infinity

  @typedoc """
  Return value from a mocked API call

  This may be a constant (value) or a zero-arity function returning a constant (generator). In
  each case, the constant is a tagged tuple containing the status code and response.
  """
  @type return ::
          {:ok, integer, any}
          | {:error, any}
          | (() -> {:ok, integer, any} | {:error, any})

  @typedoc """
  Mocked API call
  """
  @type t :: %__MODULE__{
          args: args,
          implicit: boolean,
          limit: limit,
          return: return
        }

  defstruct [:args, :implicit, :limit, :return]

  #
  # Matching
  #

  @doc false
  @spec choose([t], [any]) :: t | nil
  def choose(mocks, args)
  def choose(nil, _args), do: nil

  def choose(mocks, args) do
    mocks
    |> filter_by_arity(args)
    |> filter_by_argument(args)
    |> Enum.sort_by(ranking_fn(args))
    |> List.first()
  end

  @spec filter_by_arity([t], [any]) :: [t]
  defp filter_by_arity(mocks, args) do
    Enum.filter(mocks, fn
      %{args: arity} when is_integer(arity) -> arity == length(args)
      %{args: mock_args} when is_list(mock_args) -> length(mock_args) == length(args)
    end)
  end

  @spec filter_by_argument([t], [any]) :: [t]
  defp filter_by_argument(mocks, args) do
    Enum.filter(mocks, fn
      %{args: arity} when is_integer(arity) ->
        true

      %{args: mock_args} ->
        Enum.zip(mock_args, args)
        |> Enum.all?(fn
          {:_, _} -> true
          {same_value, same_value} -> true
          _else -> false
        end)
    end)
  end

  @spec ranking_fn([any]) :: ([t] -> integer)
  defp ranking_fn(args) do
    args_length = length(args)

    fn
      %{args: ^args, implicit: false} -> 1
      %{args: ^args, implicit: true} -> 2
      %{args: ^args_length, implicit: false} -> 100
      %{args: ^args_length, implicit: true} -> 200
      %{args: mock_args, implicit: false} -> 100 - count_matching_args(mock_args, args)
      %{args: mock_args, implicit: true} -> 200 - count_matching_args(mock_args, args)
      _else -> 999
    end
  end

  @spec count_matching_args([any], [any], non_neg_integer) :: non_neg_integer
  defp count_matching_args(mock_args, actual_args, counter \\ 0)

  defp count_matching_args([same | rest_mock], [same | rest_real], counter) do
    count_matching_args(rest_mock, rest_real, counter + 1)
  end

  defp count_matching_args([_a | rest_mock], [_b | rest_real], counter) do
    count_matching_args(rest_mock, rest_real, counter)
  end

  defp count_matching_args([], [], counter), do: counter
end
