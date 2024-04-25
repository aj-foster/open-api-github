defmodule GitHub.Testing.Store.ETS do
  @moduledoc false
  use GenServer

  alias GitHub.Testing.Call
  alias GitHub.Testing.Mock

  @behaviour GitHub.Testing.Store

  #
  # Calls
  #

  @ets_call_table :oapi_github_test_call

  @impl GitHub.Testing.Store
  def clear_calls() do
    ensure_started()
    GenServer.call(__MODULE__, :clear_calls)
  end

  @impl GitHub.Testing.Store
  def clear_calls(module, function) do
    ensure_started()
    GenServer.call(__MODULE__, {:clear_calls, module, function})
  end

  @impl GitHub.Testing.Store
  def get_calls(module, function) do
    ensure_started()

    case :ets.lookup(@ets_call_table, key(module, function)) do
      [{_key, calls}] -> calls
      [] -> []
    end
  end

  @impl GitHub.Testing.Store
  def put_call(call) do
    ensure_started()
    GenServer.call(__MODULE__, {:put_call, call})
  end

  #
  # Mocks
  #

  @ets_mock_table :oapi_github_test_mock

  @impl GitHub.Testing.Store
  def clear_mocks() do
    ensure_started()
    GenServer.call(__MODULE__, :clear_mocks)
  end

  @impl GitHub.Testing.Store
  def clear_mocks(module, function) do
    ensure_started()
    GenServer.call(__MODULE__, {:clear_mocks, module, function})
  end

  @impl GitHub.Testing.Store
  def get_mocks(module, function) do
    ensure_started()

    case :ets.lookup(@ets_mock_table, key(module, function)) do
      [{_key, mocks}] -> mocks
      [] -> []
    end
  end

  @impl GitHub.Testing.Store
  def put_mock(mock) do
    ensure_started()
    GenServer.call(__MODULE__, {:put_mock, mock})
  end

  #
  # Server
  #

  @spec ensure_started :: GenServer.on_start() | nil
  defp ensure_started do
    unless GenServer.whereis(__MODULE__) do
      GenServer.start_link(__MODULE__, nil, name: __MODULE__)
    end
  end

  @impl GenServer
  def init(_opts) do
    :ets.new(@ets_call_table, [:set, :protected, :named_table])
    :ets.new(@ets_mock_table, [:set, :protected, :named_table])
    {:ok, nil}
  end

  @impl GenServer
  def handle_call(message, from, state)

  def handle_call(:clear_calls, _from, state) do
    :ets.delete_all_objects(@ets_call_table)
    {:reply, :ok, state}
  end

  def handle_call({:clear_calls, module, function}, _from, state) do
    :ets.delete(@ets_call_table, key(module, function))
    {:reply, :ok, state}
  end

  def handle_call({:put_call, call}, _from, state) do
    %Call{function: function, module: module} = call

    key = key(module, function)
    calls = [call | get_calls(module, function)]
    :ets.insert(@ets_call_table, {key, calls})
    {:reply, :ok, state}
  end

  def handle_call(:clear_mocks, _from, state) do
    :ets.delete_all_objects(@ets_mock_table)
    {:reply, :ok, state}
  end

  def handle_call({:clear_mocks, module, function}, _from, state) do
    :ets.delete(@ets_mock_table, key(module, function))
    {:reply, :ok, state}
  end

  def handle_call({:put_mock, mock}, _from, state) do
    %Mock{function: function, module: module} = mock

    key = key(module, function)
    mocks = [mock | get_mocks(module, function)]
    :ets.insert(@ets_mock_table, {key, mocks})
    {:reply, :ok, state}
  end

  #
  # Helpers
  #

  @spec key(module, atom) :: tuple
  defp key(module, function) do
    {module, function}
  end
end
