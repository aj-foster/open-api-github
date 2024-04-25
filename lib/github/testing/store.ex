defmodule GitHub.Testing.Store do
  @moduledoc false
  alias GitHub.Testing.Call
  alias GitHub.Testing.Mock

  #
  # Calls
  #

  @doc """
  Clear all recorded calls
  """
  @callback clear_calls :: :ok

  @spec clear_calls() :: :ok
  @spec clear_calls(keyword) :: :ok
  def clear_calls(opts \\ []) do
    choose(opts).clear_calls()
  end

  @doc """
  Clear all recorded calls for the given module and function
  """
  @callback clear_calls(module :: module, function :: atom) :: :ok

  @spec clear_calls(module, atom) :: :ok
  @spec clear_calls(module, atom, keyword) :: :ok
  def clear_calls(module, function, opts \\ []) do
    choose(opts).clear_calls(module, function)
  end

  @doc """
  Get all calls recorded for the given module and function
  """
  @callback get_calls(module :: module, function :: atom) :: [Call.t()]

  @spec get_calls(module, atom) :: [Call.t()]
  @spec get_calls(module, atom, keyword) :: [Call.t()]
  def get_calls(module, function, opts \\ []) do
    choose(opts).get_calls(module, function)
  end

  @doc """
  Register a single call for its corresponding module and function
  """
  @callback put_call(call :: Call.t()) :: :ok

  @spec put_call(Call.t()) :: :ok
  @spec put_call(Call.t(), keyword) :: :ok
  def put_call(call, opts \\ []) do
    choose(opts).put_call(call)
  end

  #
  # Mocks
  #

  @doc """
  Clear all registered mocks
  """
  @callback clear_mocks :: :ok

  @spec clear_mocks() :: :ok
  @spec clear_mocks(keyword) :: :ok
  def clear_mocks(opts \\ []) do
    choose(opts).clear_mocks()
  end

  @doc """
  Clear all registered mocks for the given module and function
  """
  @callback clear_mocks(module :: module, function :: atom) :: :ok

  @spec clear_mocks(module, atom) :: :ok
  @spec clear_mocks(module, atom, keyword) :: :ok
  def clear_mocks(module, function, opts \\ []) do
    choose(opts).clear_mocks(module, function)
  end

  @doc """
  Get all mocks registered for the given module and function
  """
  @callback get_mocks(module :: module, function :: atom) :: [Mock.t()]

  @spec get_mocks(module, atom) :: [Mock.t()]
  @spec get_mocks(module, atom, keyword) :: [Mock.t()]
  def get_mocks(module, function, opts \\ []) do
    choose(opts).get_mocks(module, function)
  end

  @doc """
  Register a single mock for its corresponding module and function
  """
  @callback put_mock(mock :: Mock.t()) :: :ok

  @spec put_mock(Mock.t()) :: :ok
  @spec put_mock(Mock.t(), keyword) :: :ok
  def put_mock(mock, opts \\ []) do
    choose(opts).put_mock(mock)
  end

  #
  # Helpers
  #

  @pd_store_key :oapi_github_test_store

  @spec choose(keyword) :: module
  def choose(opts) do
    cond do
      opts[:shared] == true -> GitHub.Testing.Store.ETS
      opts[:shared] == false -> GitHub.Testing.Store.Process
      store = Process.get(@pd_store_key) -> store
      # Default to shared storage for non-test processes
      :else -> GitHub.Testing.Store.ETS
    end
  end

  @spec set(module) :: :ok
  def set(module) do
    Process.put(@pd_store_key, module)
    :ok
  end
end
