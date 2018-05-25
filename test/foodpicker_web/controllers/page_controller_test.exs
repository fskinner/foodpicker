defmodule FoodpickerWeb.PageControllerTest do
  use FoodpickerWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to Foodpicker!"
  end
end
