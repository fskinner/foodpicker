defmodule FoodpickerWeb.RestaurantControllerTest do
  use FoodpickerWeb.ConnCase

  alias Foodpicker.Picker

  @create_attrs %{name: "some name", price_range: "some price_range"}
  @update_attrs %{name: "some updated name", price_range: "some updated price_range"}
  @invalid_attrs %{name: nil, price_range: nil}

  def fixture(:restaurant) do
    {:ok, restaurant} = Picker.create_restaurant(@create_attrs)
    restaurant
  end

  describe "index" do
    test "lists all restaurants", %{conn: conn} do
      conn = get conn, restaurant_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Restaurants"
    end
  end

  describe "new restaurant" do
    test "renders form", %{conn: conn} do
      conn = get conn, restaurant_path(conn, :new)
      assert html_response(conn, 200) =~ "New Restaurant"
    end
  end

  describe "create restaurant" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, restaurant_path(conn, :create), restaurant: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == restaurant_path(conn, :show, id)

      conn = get conn, restaurant_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Restaurant"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, restaurant_path(conn, :create), restaurant: @invalid_attrs
      assert html_response(conn, 200) =~ "New Restaurant"
    end
  end

  describe "edit restaurant" do
    setup [:create_restaurant]

    test "renders form for editing chosen restaurant", %{conn: conn, restaurant: restaurant} do
      conn = get conn, restaurant_path(conn, :edit, restaurant)
      assert html_response(conn, 200) =~ "Edit Restaurant"
    end
  end

  describe "update restaurant" do
    setup [:create_restaurant]

    test "redirects when data is valid", %{conn: conn, restaurant: restaurant} do
      conn = put conn, restaurant_path(conn, :update, restaurant), restaurant: @update_attrs
      assert redirected_to(conn) == restaurant_path(conn, :show, restaurant)

      conn = get conn, restaurant_path(conn, :show, restaurant)
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, restaurant: restaurant} do
      conn = put conn, restaurant_path(conn, :update, restaurant), restaurant: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Restaurant"
    end
  end

  describe "delete restaurant" do
    setup [:create_restaurant]

    test "deletes chosen restaurant", %{conn: conn, restaurant: restaurant} do
      conn = delete conn, restaurant_path(conn, :delete, restaurant)
      assert redirected_to(conn) == restaurant_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, restaurant_path(conn, :show, restaurant)
      end
    end
  end

  defp create_restaurant(_) do
    restaurant = fixture(:restaurant)
    {:ok, restaurant: restaurant}
  end
end
