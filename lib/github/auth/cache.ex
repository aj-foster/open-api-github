defmodule GitHub.Auth.Cache do
  @moduledoc """
  Optional caching process for GitHub App and Installation tokens

  This cache uses a local ETS table to store tokens, so they are not shared across a cluster.
  However, this is generally okay, as multiple tokens can be used for the same GitHub App or
  Installation at the same time.

  Assuming the expiration time given to this cache is correct, it will automatically handle
  invalidating tokens both periodically and on-demand.

  ## Usage

  To enable caching, include this module in your application's top-level supervisor:

      # application.ex
      defmodule MyApp.Application do
        use Application

        def start(_type, _args) do
          children = [
            # ...
            GitHub.Auth.Cache
          ]

          opts = [strategy: :one_for_one, name: MyApp.Supervisor]
          Supervisor.start_link(children, opts)
        end
      end
  """
  use GenServer
  require Logger

  @ets_table __MODULE__
  @remove_expired_cycle_msec 60_000

  #
  # Public API
  #

  @doc false
  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  @doc """
  Get a previously stored value if unexpired

  Here the key is presumed to be `{:app, app_id}` or `{:installation, installation_id}`, though
  any key will work. Returns `:error` if the key is not found or if the stored value has expired.
  """
  @spec get(term) :: {:ok, term} | :error
  def get(key) do
    case :ets.whereis(@ets_table) do
      :undefined -> :error
      _else -> get_token(key)
    end
  end

  @doc """
  Set a value in the cache

  Here the key is presumed to be `{:app, app_id}` or `{:installation, installation_id}`, though
  any key will work. The expiration must be a Unix timestamp (seconds since Jan 1, 1970).
  """
  @spec put(term, integer, term) :: :ok
  def put(key, expiration, value) do
    GenServer.call(__MODULE__, {:put, key, expiration, value})
  end

  #
  # Private API
  #

  @doc false
  @impl GenServer
  def init(nil) do
    @ets_table = :ets.new(@ets_table, [{:read_concurrency, true}, :protected, :named_table])
    Process.send_after(self(), :remove_expired, @remove_expired_cycle_msec)
    {:ok, nil}
  end

  @impl GenServer
  def handle_call({:put, key, expiration, value}, _from, _state) do
    put_token(key, expiration, value)
    {:reply, :ok, nil}
  end

  @impl GenServer
  def handle_info(:remove_expired, _state) do
    remove_expired()
    Process.send_after(self(), :remove_expired, @remove_expired_cycle_msec)
    {:noreply, nil}
  end

  #
  # Helpers
  #

  defp get_token(key) do
    case :ets.lookup(@ets_table, key) do
      [{^key, expiration, value}] ->
        if expiration > now() do
          {:ok, value}
        else
          :error
        end

      [] ->
        :error
    end
  end

  defp put_token(key, expiration, value) do
    :ets.insert(@ets_table, {key, expiration, value})
  end

  defp remove_expired do
    :ets.match_delete(@ets_table, {{:_, :"$1", :_}, [{:<, :"$1", now()}], []})
  end

  defp now, do: DateTime.utc_now() |> DateTime.to_unix(:second)
end
