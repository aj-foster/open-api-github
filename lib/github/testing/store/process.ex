defmodule GitHub.Testing.Store.Process do
  @moduledoc false
  alias GitHub.Testing.Call
  alias GitHub.Testing.Mock

  @behaviour GitHub.Testing.Store

  #
  # Calls
  #

  @pd_call_key :oapi_github_test_call

  @impl true
  def clear_calls() do
    Process.get_keys()
    |> Enum.each(fn
      {@pd_call_key, module, function} -> clear_calls(module, function)
      _else -> :ok
    end)
  end

  @impl true
  def clear_calls(module, function) do
    call_key(module, function)
    |> Process.put([])

    :ok
  end

  @impl true
  def get_calls(module, function) do
    call_key(module, function)
    |> Process.get([])
  end

  @impl true
  def put_call(call) do
    %Call{function: function, module: module} = call

    key = call_key(module, function)
    calls = [call | Process.get(key, [])]
    Process.put(key, calls)
    :ok
  end

  #
  # Mocks
  #

  @pd_mock_key :oapi_github_test_mock

  @impl true
  def clear_mocks() do
    Process.get_keys()
    |> Enum.each(fn
      {@pd_mock_key, module, function} -> clear_mocks(module, function)
      _else -> :ok
    end)
  end

  @impl true
  def clear_mocks(module, function) do
    mock_key(module, function)
    |> Process.put([])

    :ok
  end

  @impl true
  def get_mocks(module, function) do
    mock_key(module, function)
    |> Process.get([])
  end

  @impl true
  def put_mock(mock) do
    %Mock{function: function, module: module} = mock

    key = mock_key(module, function)
    mocks = [mock | Process.get(key, [])]
    Process.put(key, mocks)
    :ok
  end

  #
  # Helpers
  #

  @spec call_key(module, atom) :: tuple
  defp call_key(module, function) do
    {@pd_call_key, module, function}
  end

  @spec mock_key(module, atom) :: tuple
  defp mock_key(module, function) do
    {@pd_mock_key, module, function}
  end
end
