defmodule GitHub.Testing do
  @moduledoc """
  Support for interacting with the client in a test environment

  > #### Note {:.info}
  >
  > The current method of tracking and mocking API calls uses the process dictionary for storage.
  > This means that tests can be run async (calls from one process will not affect calls from
  > another). However, it also means that calls from an async task will not be tracked by the test
  > process. If this affects you, please open an issue to discuss possible solutions.

  ## Usage

  The testing facility provided by this library has two parts: this module, which provides helpful
  functions for generating data and asserting that API calls are made, and
  `GitHub.Plugin.TestClient`, which provides a basic mock and support for the test assertions.

  In your test environment, you likely want to use the test client plugin as the only item in the
  client stack:

      # config/test.exs
      config :oapi_github, stack: [{GitHub.Plugin.TestClient, :request, []}]

  The stack can also be configured at runtime by passing the `:stack` option to any operation.

  > #### Warning {:.warning}
  >
  > Stack entries without options, like `{GitHub.Plugin.TestClient, :request}`, look like keyword
  > list items. If you have stacks configured in multiple Mix environments that all use this
  > 2-tuple format, Elixir will try to merge them as keyword lists. Adding an empty options
  > element to any stack item will prevent this behaviour.

  Then, in your test file, `use` this module and make use of the available assertions:

      defmodule MyApp.MyTest do
        use ExUnit.Case
        use GitHub.Testing

        test "something" do
          my_function()
          assert_gh_called &GitHub.Repos.get/2
        end
      end

  """
  require ExUnit.Assertions

  alias GitHub.Operation
  alias GitHub.Testing.Mock

  @doc false
  defmacro __using__(_) do
    quote do
      import GitHub.Testing,
        only: [
          assert_gh_called: 1,
          assert_gh_called: 2,
          mock_gh: 2,
          mock_gh: 3
        ]
    end
  end

  #
  # Data Generation
  #

  @doc """
  Generate random data for use in a test response

  This function uses randomness to help avoid collisions in tests. It also supports special cases
  based on the context of the generated data (the schema and/or key). Examples can be found in the
  **Special Cases** section below.

  ## Special Cases

  * `:id` fields with type `:integer` will have unique positive integers rather than the limited
    range of integers returned by a typical `:integer` field.

  * `:string` fields with keys that end with `_at` will have ISO 8601 datetime strings from a
    random time within the past day.

  * `:string` fields with keys named `:url` or that end with `_url` will have random URL strings.

  Additional special cases can be added to make the generated data more typical of real responses.
  For example, returning a name-like string for user names, and limiting the allowed characters
  for usernames.

  > #### Note {:.info}
  >
  > If you see an opportunity to improve the generated data for a particular field, please include
  > the description of the field from
  > [GitHub's OpenAPI specification](https://github.com/github/rest-api-description)
  > in your pull request.

  ## Examples

      iex> GitHub.Testing.generate(nil, nil, {GitHub.Repository, :full})
      %GitHub.Repository{...}

      iex> GitHub.Testing.generate(GitHub.Repository, :id, :integer)
      226194162

  """
  @spec generate(module, atom, Operation.type()) :: any
  def generate(schema, key, type)

  # Special cases
  def generate(_schema, :email, :string), do: Faker.Internet.email()
  def generate(_schema, :id, :integer), do: System.unique_integer([:positive])
  def generate(_schema, :login, :string), do: Faker.Internet.user_name()
  def generate(_schema, :url, :string), do: Faker.Internet.url()

  def generate(GitHub.User, :name, :string), do: Faker.Person.name()

  # Primitive types
  def generate(_schema, _key, :binary), do: Faker.String.base64()
  def generate(_schema, _key, :boolean), do: Enum.random([true, false])
  def generate(_schema, _key, :integer), do: Enum.random(1..10)
  def generate(_schema, _key, :map), do: %{}

  def generate(_schema, _key, :number) do
    Enum.random([
      fn -> Enum.random(1..10) end,
      fn -> Faker.random_uniform() * 10 end
    ]).()
  end

  def generate(_schema, key, :string) do
    string_key = Atom.to_string(key)

    cond do
      String.ends_with?(string_key, "_at") ->
        now = DateTime.utc_now()
        yesterday = DateTime.add(now, -1, :day)

        Faker.DateTime.between(yesterday, now)
        |> DateTime.to_iso8601()

      String.ends_with?(string_key, "_url") ->
        Faker.Internet.url()

      :else ->
        Faker.Lorem.characters(15..30) |> to_string()
    end
  end

  def generate(_schema, _key, :null), do: nil
  def generate(_schema, _key, :unknown), do: nil

  # Compound types
  def generate(schema, key, {:array, type}), do: generate(schema, key, type)

  def generate(schema, key, {:union, types}) do
    Enum.map(types, fn type ->
      fn -> generate(schema, key, type) end
    end)
    |> Enum.random()
    |> apply([])
  end

  def generate(schema, key, {:nullable, type}) do
    Enum.random([
      fn -> nil end,
      fn -> generate(schema, key, type) end
    ]).()
  end

  def generate(_schema, _key, {module, struct_type}) do
    apply(module, :__fields__, [struct_type])
    |> Enum.map(fn {key, field_type} -> {key, generate(module, key, field_type)} end)
    |> then(fn fields -> struct!(module, fields) end)
  end

  #
  # Mocks
  #

  @pd_mock_key :oapi_github_test_mock

  @doc """
  Mock a response for an API endpoint

  The API endpoint can be passed as a function call or using function capture syntax. If passed
  as a function call, the arguments must match exactly or use the special value `:_` to match any
  value. If passed using function capture syntax, only the arity will be matched. The options
  argument is not considered during these checks.

  As a return function for a mock, you can use a zero-arity function that returns a tagged tuple
  `{:ok, code, data}` with the HTTP status code and response body. This response body can be
  an Elixir term (as if it already passed through JSON decoding and related steps), an untyped
  map, or a plain string depending on your client stack. It is recommended to use a stack that
  contains only the `GitHub.Plugin.TestClient` plugin, in which case the return values should
  contain structs from this library.

  ## Examples

      mock_gh GitHub.Repos.get("owner", :_), fn ->
        {:ok, 200, %GitHub.Repository{id: 12345}}
      end

      mock_gh &GitHub.Repos.get/2, fn ->
        {:ok, 200, %GitHub.Repository{id: 67890}}
      end

  """
  defmacro mock_gh(call, return_fn, opts \\ [])

  defmacro mock_gh({{:., _, [module, function]}, _, args}, return_fn, opts) do
    module = Macro.expand(module, __CALLER__)

    quote do
      GitHub.Testing.put_mock(
        unquote(module),
        unquote(function),
        unquote(args),
        unquote(return_fn),
        unquote(opts)
      )
    end
  end

  defmacro mock_gh(
             {:&, _, [{:/, _, [{{:., _, [module, function]}, _, _}, arity]}]},
             return_fn,
             opts
           ) do
    module = Macro.expand(module, __CALLER__)

    quote do
      GitHub.Testing.put_mock(
        unquote(module),
        unquote(function),
        unquote(arity),
        unquote(return_fn),
        unquote(opts)
      )
    end
  end

  # Not ready for public use

  @doc false
  @spec get_mock(Operation.t()) :: Mock.return()
  def get_mock(operation) do
    {module, function, args} = Operation.get_caller(operation)

    Process.get(@pd_mock_key, %{})
    |> Map.get({module, function})
    |> Mock.choose(args)
    |> case do
      %{args: ^args, return: mock} ->
        mock

      %{return: mock} ->
        put_mock(module, function, args, mock.(), implicit: true)

      nil ->
        mock_return_fn = default_response_fn(operation)
        put_mock(module, function, length(args), mock_return_fn, implicit: true)
        put_mock(module, function, args, mock_return_fn.(), implicit: true)
    end
  end

  @spec default_response_fn(Operation.t()) :: Mock.return()
  defp default_response_fn(%Operation{response_types: [{code, type} | _]}) do
    fn -> {:ok, code, GitHub.Testing.generate(nil, nil, type)} end
  end

  @doc false
  @spec put_mock(module, atom, Mock.args(), Mock.return(), keyword) :: Mock.t()
  def put_mock(module, function, args, return, opts \\ []) do
    implicit = opts[:implicit] == true
    limit = opts[:limit] || :infinity

    all_mocks = Process.get(@pd_mock_key, %{})
    new_mock = %Mock{args: args, implicit: implicit, limit: limit, return: return}
    new_mocks = [new_mock | Map.get(all_mocks, {module, function}, [])]
    updated_mocks = Map.put(all_mocks, {module, function}, new_mocks)

    Process.put(@pd_mock_key, updated_mocks)
    return
  end

  #
  # Calls
  #

  @pd_call_key :oapi_github_test_call

  @typep call :: {module :: module, function :: atom, args :: [any]}

  @doc """
  Assert the number of times an API endpoint was called

  The API endpoint can be passed as a function call or using function capture syntax. If passed
  as a function call, the arguments must match exactly or use the special value `:_` to match any
  value. If passed using function capture syntax, only the arity will be matched. The options
  argument is not considered during these checks.

  ## Examples

      assert_gh_called GitHub.Repos.get("owner", "repo")
      assert_gh_called GitHub.Repos.get("owner", :_), times: 2
      assert_gh_called GitHub.Repos.get(owner, "repo"), min: 2, max: 3
      assert_gh_called &GitHub.Repos.get/2, times: 0

  ## Options

    * `max`: Non-negative integer representing the maximum number of times a matching call should
      have occurred. If unspecified, there is no upper limit on the acceptable number of calls.
      If none of `times`, `min`, or `max` are specified, the default is to assert at least
      one matching call.

    * `min`: Non-negative integer representing the minimum number of times a matching call should
      have occurred. If unspecified, there is no lower limit on the acceptable number of calls.
      If none of `times`, `min`, or `max` are specified, the default is to assert at least
      one matching call.

    * `times`: Non-negative integer number of times a matching call should have occurred. Passing
      zero will assert the endpoint has not been called. This option has precedence over `min` and
      `max`. If none of `times`, `min`, or `max` are specified, the default is to assert at least
      one matching call.

  """
  defmacro assert_gh_called(call, opts \\ [])

  defmacro assert_gh_called({{:., _, [module, function]}, _, args}, opts) do
    module = Macro.expand(module, __CALLER__)

    quote do
      GitHub.Testing.assert_call_count(
        unquote(module),
        unquote(function),
        unquote(args),
        unquote(opts)
      )
    end
  end

  defmacro assert_gh_called(
             {:&, _, [{:/, _, [{{:., _, [module, function]}, _, _}, arity]}]},
             opts
           ) do
    module = Macro.expand(module, __CALLER__)

    quote do
      GitHub.Testing.assert_call_count(
        unquote(module),
        unquote(function),
        unquote(arity),
        unquote(opts)
      )
    end
  end

  defmacro assert_gh_called(_call, _opts) do
    raise ArgumentError, "Unknown form passed to `assert_gh_called`"
  end

  @spec count_restriction(keyword) :: {:== | :<= | :>=, integer} | {:.., integer, integer}
  defp count_restriction(%{times: times}) when is_integer(times) and times >= 0, do: {:==, times}

  defp count_restriction(%{times: times}) when is_integer(times) and times < 0 do
    raise ArgumentError, "Option `:times` must be a non-negative integer"
  end

  defp count_restriction(%{min: min, max: max}) when is_integer(min) and is_integer(max) do
    cond do
      min < 0 or max < 0 ->
        raise ArgumentError, "Options `:min` and `:max` must be non-negative integers"

      min > max ->
        raise ArgumentError, "Option `:min` must be less than or equal to `:max`"

      :else ->
        {:.., min, max}
    end
  end

  defp count_restriction(%{min: min}) when is_integer(min) and min >= 0, do: {:>=, min}
  defp count_restriction(%{max: max}) when is_integer(max) and max >= 0, do: {:<=, max}

  defp count_restriction(%{min: min}) when is_integer(min) do
    raise ArgumentError, "Option `:min` must be a non-negative integer"
  end

  defp count_restriction(%{max: max}) when is_integer(max) do
    raise ArgumentError, "Option `:max` must be a non-negative integer"
  end

  defp count_restriction(_opts), do: {:>=, 1}

  @spec args_match?(Mock.args(), [any]) :: boolean
  defp args_match?(arity, call_args) when is_integer(arity), do: length(call_args) == arity
  defp args_match?(args, call_args) when length(args) != length(call_args), do: false

  defp args_match?(args, call_args) do
    Enum.zip(args, call_args)
    |> Enum.all?(fn
      {:_, _} -> true
      {same_value, same_value} -> true
      _else -> false
    end)
  end

  # Not ready for public use

  @doc false
  @spec get_calls :: [call]
  def get_calls do
    Process.get(@pd_call_key, [])
  end

  @doc false
  @spec put_call(Operation.t()) :: :ok
  def put_call(operation) do
    new_call = Operation.get_caller(operation)

    all_calls = Process.get(@pd_call_key, [])
    updated_calls = [new_call | all_calls]

    Process.put(@pd_call_key, updated_calls)
    :ok
  end

  @doc false
  @spec assert_call_count(module, atom, Mock.args(), keyword) :: any
  def assert_call_count(module, function, args, opts \\ []) do
    call_count =
      get_calls()
      |> Enum.count(fn {m, f, a} ->
        module == m and function == f and args_match?(args, a)
      end)

    Keyword.take(opts, [:times, :min, :max])
    |> Enum.into(%{})
    |> count_restriction()
    |> case do
      {:==, times} -> ExUnit.Assertions.assert(call_count == times)
      {:>=, min} -> ExUnit.Assertions.assert(call_count >= min)
      {:<=, max} -> ExUnit.Assertions.assert(call_count <= max)
      {:.., min, max} -> ExUnit.Assertions.assert(call_count in min..max)
    end
  end
end
