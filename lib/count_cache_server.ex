defmodule CountCacheServer do

  @name :count_cache_server

  use GenServer

  def start do
    IO.puts "Starting the cache server"
    GenServer.start(__MODULE__, %{city_count: [], total_count: "0"}, name: @name)
  end

  def handle_call(:update_count, _from, state) do
    {:ok, city_count, total_count} = DataScraper.get_data
    new_state =  %{ city_count: city_count, total_count: total_count}
    {:reply, new_state, new_state}
  end

  def handle_call(:recent_data, _from, state) do
    {:reply, state.city_count, state}
  end

  def handle_call(:total_count, _from, state) do
    total = state.total_count
    {:reply, total, state}
  end
end