defmodule GitHub.Testing do
  @moduledoc """
  Support for interacting with the client in a test environment

  > #### Note {:.info}
  >
  > The default method of tracking and mocking API calls uses the process dictionary for storage.
  > This means that tests can be run async (calls from one process will not affect calls from
  > another). However, it also means that calls from an async task will not be tracked by the test
  > process. If mocks and calls need to extend past the test process boundary, use `shared: true`
  > on the call to `use GitHub.Testing` or in individual calls to `mock_gh` and `assert_gh_called`.
  > See **Async and Sharing** for more information.

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

  The `use` macro also imports `mock_gh/3` and `generate_gh/2` for use in tests.

  ## Async and Sharing

  By default, this library supports async tests with mocks and call tracking within a single
  process. If a test causes or observes other processes to call client functions, then additional
  configuration is necessary.

  First, multi-process mocking and call tracking is not supported with async tests. Ensure that
  `async: true` is **not** present in the call to `use ExUnit.Case` or similar `use` calls (such
  as `use MyApp.DataCase`). To enable shared storage of mocks and calls, add `shared: true` to
  the call to `use GitHub.Testing` or individual calls to `mock_gh` and `assert_gh_called`:

      defmodule MyApp.MyTest do
        use ExUnit.Case
        use GitHub.Testing, shared: true

        # or...

        test "something" do
          my_async_function()
          assert_gh_called &GitHub.Repos.get/2, shared: true
        end
      end

  Mocks and calls will automatically be cleared from the shared storage after each test.

  Shared storage uses an ETS table owned by an unsupervised GenServer. To ensure proper management
  of this process, you may optionally add `GitHub.Testing.Store.ETS` to your application's
  supervisor in test environments.
  """
  require ExUnit.Assertions

  alias GitHub.Operation
  alias GitHub.Testing.Call
  alias GitHub.Testing.Mock
  alias GitHub.Testing.Store

  @doc false
  defmacro __using__(opts) do
    quote do
      import GitHub.Testing,
        only: [
          assert_gh_called: 1,
          assert_gh_called: 2,
          generate_gh: 1,
          generate_gh: 2,
          generate_gh: 3,
          mock_gh: 2,
          mock_gh: 3,
          to_gh_params: 1
        ]

      setup do
        if unquote(opts)[:shared] do
          GitHub.Testing.Store.set(GitHub.Testing.Store.ETS)

          ExUnit.Callbacks.on_exit(fn ->
            GitHub.Testing.Store.clear_calls(shared: true)
            GitHub.Testing.Store.clear_mocks(shared: true)
          end)
        else
          GitHub.Testing.Store.set(GitHub.Testing.Store.Process)
        end
      end
    end
  end

  # Convenience guard for generate_gh/3
  defguardp is_enum(value) when is_map(value) or is_list(value)

  #
  # Data Generation
  #

  @doc """
  Generate a struct for use in a test response

  The first argument is the module / schema you would like to generate. If there are multiple
  types available in the module, then the second argument can distinguish which to use (for
  example, `:full` for the type `GitHub.PullRequest.full()`). It is also possible to override
  the generated fields with custom data.

  This function uses randomness to help avoid collisions in tests. For more information, see
  `generate/3`.

  ## Examples

      iex> GitHub.Testing.generate_gh(GitHub.PullRequest)
      %GitHub.PullRequest{}

      iex> GitHub.Testing.generate_gh(GitHub.User, :private)
      %GitHub.User{}

      iex> GitHub.Testing.generate_gh(GitHub.User, bio: "This is a custom bio")
      %GitHub.User{bio: "This is a custom bio"}

      iex> GitHub.Testing.generate_gh(GitHub.User, :private, bio: "This is a custom bio")
      %GitHub.User{bio: "This is a custom bio"}

  """
  @spec generate_gh(module, atom, map | keyword) :: any
  def generate_gh(schema, type \\ :t, overrides \\ %{})

  def generate_gh(schema, overrides, _overrides) when is_enum(overrides) do
    overrides = if is_map(overrides), do: overrides, else: Enum.into(overrides, %{})

    generate(nil, nil, {schema, :t})
    |> override_fields(overrides)
  end

  def generate_gh(schema, type, overrides) when is_atom(type) and is_enum(overrides) do
    overrides = if is_map(overrides), do: overrides, else: Enum.into(overrides, %{})

    generate(nil, nil, {schema, type})
    |> override_fields(overrides)
  end

  def generate_gh(_schema, _type, _overrides) do
    raise ArgumentError, """
    Expected one of the following forms when calling generate_gh(...):

        generate_gh(SchemaModule)
        generate_gh(SchemaModule, :type)
        generate_gh(SchemaModule, :type, overrides)
        generate_gh(SchemaModule, overrides)

    Where overrides is an atom-keyed map or keyword list of fields to change in the result.
    """
  end

  @spec override_fields(struct | map, map) :: struct | map | no_return
  defp override_fields(%_{} = record, attrs), do: struct!(record, attrs)
  defp override_fields(%{} = record, attrs), do: Map.merge(record, attrs)

  @doc """
  Generate random data for use in a test response

  Data generated by this function will appear as if it were decoded by a plugin (for example
  `GitHub.Plugin.TypedDecoder`). Including such a decoder in the stack is not necessary when the
  client uses this data.

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
  def generate(_schema, :id, :integer), do: System.unique_integer([:positive])
  def generate(_schema, :login, {:string, :generic}), do: Faker.Internet.user_name()
  def generate(GitHub.Repository.Permissions, :pull, :boolean), do: true

  def generate(GitHub.Repository, :created_at, {:union, [{:string, :date_time}, :null]}),
    do: generate(GitHub.Repository, :created_at, {:string, :date_time})

  def generate(GitHub.Repository, :fork, :boolean), do: false
  def generate(GitHub.Repository, :parent, _), do: nil
  def generate(GitHub.Repository, :source, _), do: nil
  def generate(GitHub.Repository, :template_repository, _), do: nil

  def generate(GitHub.User, :name, {:union, [{:string, :generic}, :null]}),
    do: Faker.Person.name()

  def generate(GitHub.User, :type, {:string, :generic}),
    do: Enum.random(["User", "Bot", "Organization"])

  # Primitive types
  def generate(_schema, _key, :boolean), do: Enum.random([true, false])
  def generate(_schema, _key, :integer), do: Enum.random(1..10)

  def generate(_schema, _key, :number) do
    Enum.random([
      fn -> Enum.random(1..10) end,
      fn -> Faker.random_uniform() * 10 end
    ]).()
  end

  def generate(_schema, _key, {:string, :binary}), do: Faker.String.base64()

  def generate(_schema, _key, {:string, :date}) do
    today = Date.utc_today()
    last_week = Date.add(today, -7)

    Faker.Date.between(last_week, today)
  end

  def generate(_schema, _key, {:string, :date_time}) do
    now = DateTime.utc_now()
    yesterday = DateTime.add(now, -1 * 24 * 60 * 60, :second)

    Faker.DateTime.between(yesterday, now)
  end

  def generate(_schema, _key, {:string, :email}), do: Faker.Internet.email()
  def generate(_schema, _key, {:string, :hostname}), do: Faker.Internet.domain_name()
  def generate(_schema, _key, {:string, :ipv4}), do: Faker.Internet.ip_v4_address()
  def generate(_schema, _key, {:string, :ipv6}), do: Faker.Internet.ip_v6_address()

  def generate(schema, key, {:string, :generic}) do
    string_key = Atom.to_string(key)

    cond do
      String.ends_with?(string_key, "_at") ->
        generate(schema, key, {:string, :date_time}) |> DateTime.to_iso8601()

      String.ends_with?(string_key, "_email") or string_key == "email" ->
        generate(schema, key, {:string, :email})

      String.ends_with?(string_key, "_ref") or string_key == "ref" ->
        Faker.Internet.slug()

      String.ends_with?(string_key, "_sha") or string_key == "sha" ->
        Faker.random_bytes(20) |> Base.encode16(case: :lower)

      String.ends_with?(string_key, "_url") or string_key == "url" ->
        generate(schema, key, {:string, :uri})

      :else ->
        Faker.Lorem.characters(15..30) |> to_string()
    end
  end

  def generate(_schema, _key, {:string, :time}) do
    Time.utc_now()
    |> Time.add(:rand.uniform(60 * 60 * 24), :second)
  end

  def generate(_schema, _key, {:string, :uri}), do: Faker.Internet.url()
  def generate(_schema, _key, {:string, :uuid}), do: Faker.UUID.v4()
  def generate(_schema, _key, :null), do: nil

  # Unnatural types
  def generate(_schema, _key, :any), do: nil
  def generate(_schema, _key, :map), do: %{}

  # Compound types
  def generate(schema, key, [type]), do: [generate(schema, key, type)]
  def generate(_schema, _key, {:const, literal}), do: literal
  def generate(_schema, _key, {:enum, literals}), do: Enum.random(literals)

  def generate(schema, key, {:union, types}) do
    Enum.map(types, fn type ->
      fn -> generate(schema, key, type) end
    end)
    |> Enum.random()
    |> apply([])
  end

  def generate(_schema, _key, {module, struct_type}) do
    apply(module, :__fields__, [struct_type])
    |> Enum.map(fn {key, field_type} -> {key, generate(module, key, field_type)} end)
    |> then(fn fields -> struct!(module, fields) end)
    |> Map.put(:__info__, %{generated: true})
  end

  @doc """
  Transform a library struct into its string-keyed data equivalent

  This is useful for testing scenarios when a piece of generated data has not been decoded.
  """
  @spec to_gh_params(map) :: map
  @spec to_gh_params([map]) :: [map]
  def to_gh_params(value)
  def to_gh_params(values) when is_list(values), do: Enum.map(values, &to_gh_params/1)
  def to_gh_params(%Date{} = dt), do: Date.to_iso8601(dt)
  def to_gh_params(%DateTime{} = dt), do: DateTime.to_iso8601(dt)
  def to_gh_params(%Time{} = dt), do: Time.to_iso8601(dt)
  def to_gh_params(%_{} = value), do: Map.from_struct(value) |> to_gh_params()

  def to_gh_params(%{} = value),
    do: Map.new(value, fn {key, value} -> {to_string(key), to_gh_params(value)} end)

  def to_gh_params(value), do: value

  #
  # Mocks
  #

  @doc """
  Mock a response for an API endpoint

  ## API Endpoint

  The API endpoint can be passed as a function call or using function capture syntax. If passed
  as a function call, the arguments must match exactly or use the special value `:_` to match any
  value. If passed using function capture syntax, only the arity will be matched. The options
  argument is not considered during these checks.

  ## Return Value

  As a return value for a mock, you can set a plain value or pass one of several function forms:

  * A zero-arity function will be evaluated a call time. Use this to perform lazy evaluation of
    the mock or encapsulate a generator.

  * A function with the same number of arguments as the original client operation (**not**
    including the final `opts` argument) will be called with the same arguments. Use this to
    perform assertions on the arguments or return a different value depending on the call.

  * A function with the same number of arguments as the original client operation (including the
    final `opts` argument) will be called with the same arguments and options. Use this to perform
    assertions on the arguments and options or return a different value depending on the call.

  In each case, the plain value — or the value returned from the function — should have one of the
  following forms:

      {:ok, data}
      {:ok, data, opts}
      {:error, error}
      {:error, error, opts}

  Where `data` is the response body and `error` is the error to return, and `opts` modifies the
  response. The available options are:

  * `code` (integer): Status code to include with the response.

  In addition, the following pre-defined error responses are available:

  * `{:error, :not_found}` will return an error matching GitHub's standard "Not Found" response.
  * `{:error, :rate_limited}` with return an error matching a GitHub API rate limited response.
  * `{:error, :unauthorized}` will return an error matching GitHub's unauthorized response.

  ## Options

    * `cache`: For return values expressed as a function, whether the mock's result should be
      cached for future calls with the same arguments. Set to `false` if you want to guarantee
      that the mock function always runs (for example, if it contains assertions). Defaults to
      `true`.

  ## Examples

      mock_gh GitHub.Repos.get("owner", "repo"), {:ok, %GitHub.Repository{}}
      mock_gh GitHub.Repos.get("owner", "repo-2"), {:ok, %GitHub.Repository{}, code: 201}
      mock_gh GitHub.Repos.get("friend", "repo"), {:error, :not_found}
      mock_gh GitHub.Repos.get("friend", "repo-2"), {:error, %GitHub.Error{}, code: 403}

      mock_gh &GitHub.Repos.get/2, fn -> {:ok, %GitHub.Repository{}} end

      mock_gh &GitHub.Repos.get/2, fn owner, name ->
        assert String.starts_with?(name, "oapi_")
        {:ok, %GitHub.Repository{owner: owner, name: name}}
      end

      mock_gh &GitHub.Repos.get/2, fn owner, name, opts ->
        assert opts[:auth] == "gho_token"
        {:ok, %GitHub.Repository{owner: owner, name: name}}
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
  @spec get_mock_result(Operation.t()) :: Mock.return()
  def get_mock_result(operation) do
    {module, function, args} = Operation.get_caller(operation)
    options = Operation.get_options(operation)

    Store.get_mocks(module, function, options)
    |> Mock.choose(args)
    |> case do
      %{args: ^args, return: mock_return} ->
        evaluate_mock(mock_return, args, options)

      %{return: mock_return, cache: false} ->
        evaluate_mock(mock_return, args, options)

      %{return: mock_return, cache: true} ->
        return_value = evaluate_mock(mock_return, args, options)
        put_mock(module, function, args, return_value, implicit: true)

      nil ->
        mock_return_fn = default_response_fn(operation)
        put_mock(module, function, length(args), mock_return_fn, implicit: true)
        put_mock(module, function, args, mock_return_fn.(), implicit: true)
    end
  end

  @spec evaluate_mock(Mock.return_fun(), [any], keyword) :: Mock.return()
  defp evaluate_mock(fun, _args, _opts) when is_function(fun, 0), do: fun.()
  defp evaluate_mock(fun, args, _opts) when is_function(fun, length(args)), do: apply(fun, args)

  defp evaluate_mock(fun, args, opts) when is_function(fun, length(args) + 1),
    do: apply(fun, args ++ [opts])

  defp evaluate_mock(return, _args, _opts), do: return

  @spec default_response_fn(Operation.t()) :: Mock.return_fun()
  defp default_response_fn(%Operation{response_types: [{code, type} | _]}) do
    fn -> {:ok, GitHub.Testing.generate(nil, nil, type), code: code} end
  end

  @doc false
  @spec put_mock(module, atom, Mock.args(), Mock.return_fun(), keyword) :: Mock.return()
  def put_mock(module, function, args, return, opts \\ []) do
    cache = opts[:cache] != false
    implicit = opts[:implicit] == true

    # Not yet supported
    limit = opts[:limit] || :infinity

    new_mock = %Mock{
      args: args,
      cache: cache,
      function: function,
      implicit: implicit,
      limit: limit,
      module: module,
      return: return
    }

    Store.put_mock(new_mock, opts)
    return
  end

  #
  # Calls
  #

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
  @spec put_call(Operation.t()) :: :ok
  def put_call(operation) do
    {module, function, args} = Operation.get_caller(operation)
    opts = Operation.get_options(operation)

    Store.put_call(%Call{args: args, function: function, module: module, opts: opts}, opts)
  end

  @doc false
  @spec assert_call_count(module, atom, Mock.args(), keyword) :: any
  def assert_call_count(module, function, args, opts \\ []) do
    call_count =
      Store.get_calls(module, function, opts)
      |> Enum.count(fn %Call{args: a} -> args_match?(args, a) end)

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
