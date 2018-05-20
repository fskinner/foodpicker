defmodule FoodpickerWeb.PageController do
  use FoodpickerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
