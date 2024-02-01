defmodule Spurer.Replica.Location do
  use GenServer

  @impl true
  def init(:ok) do
    {:ok, %{wal: [], data: []}}
  end

  @impl true
  def handle_call({:add_value, new_value}, _from, state) do
    %{wal: wal, data: data} = state
    {:reply, :ok, %{wal: wal, data: [new_value | data]}}
  end

  @impl true
  def handle_call({:get}, _from, state) do
    %{wal: _wal, data: data} = state
    {:reply, data, state}
  end

  ### CLIENT API
  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def add(server, new_value) do
    GenServer.call(server, {:add_value, new_value})
  end

  def get_all(server) do
    GenServer.call(server, {:get})
  end
end
