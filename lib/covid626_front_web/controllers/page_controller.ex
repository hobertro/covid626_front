defmodule Covid626FrontWeb.PageController do
  use Covid626FrontWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def cities(conn, _params) do
    %{city_count: cities, total_count: total_count} = :sys.get_state(:count_cache_server)
    render(conn, "cities.html", cities: cities, total_count: total_count)
  end
end
