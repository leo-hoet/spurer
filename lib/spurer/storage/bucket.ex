defmodule Spurer.Storage.Bucket do
  use GenServer

  @impl true
  def init(:ok) do
    {:ok, %{}}
  end

  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def start(name) do
    name = {:via, Registry, {Spurer.BucketRegistry, name}}
    {:ok, _pid} = DynamicSupervisor.start_child(Spurer.BucketSupervisor, {__MODULE__, name: name})
  end

  @impl true
  def handle_call({:get, key}, _from, state) do
    {:reply, Map.get(state, key), state}
  end

  @impl true
  def handle_call({:put, key, value}, _from, state) do
    state = Map.put(state, key, value)
    {:reply, :ok, state}
  end

  def get_value(server, key) do
    GenServer.call(server, {:get, key})
  end

  def put_value(server, key, value) do
    GenServer.call(server, {:put, key, value})
  end
end
