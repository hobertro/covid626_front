defmodule CountCacheServer do

  @name :count_cache_server
  @refresh_interval :timer.seconds(5) # timer.minutes(60)

  use GenServer

  def init(_state) do
    {:ok, city_count, total_count} = DataScraper.get_data
    initial_state =  %{ city_count: city_count, total_count: total_count }
    schedule_refresh()
    {:ok, initial_state}
  end

  def start do
    IO.puts "Starting the cache server"
    GenServer.start(__MODULE__, %{city_count: [], total_count: "0"}, name: @name)
  end

  def handle_info(:refresh, _state) do
    IO.puts "refreshing the cache...."
    {:ok, city_count, total_count} = DataScraper.get_data
    new_state =  %{ city_count: city_count, total_count: total_count }
    schedule_refresh()
    {:noreply, new_state}
  end

  defp schedule_refresh do
    Process.send_after(self(), :refresh, @refresh_interval)
  end

  def handle_call(:update_count, _from, _state) do
    {:ok, city_count, total_count} = DataScraper.get_data
    new_state =  %{ city_count: city_count, total_count: total_count }
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