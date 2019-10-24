defmodule FoodpickerWeb.RestaurantController do
  use FoodpickerWeb, :controller

  alias Foodpicker.Picker
  alias Foodpicker.Picker.Restaurant

  def index(conn, _params) do
    restaurants = Picker.list_restaurants()
    render(conn, "index.html", restaurants: restaurants)
  end

  def suggest(conn, %{"suggestion" => suggestion_params}) do
    suggestion =
      (suggestion_params["categories"] || "")
      |> split_categories()
      |> Picker.match_restaurants(suggestion_params["price"])
      |> get_sample()

    render(conn, "suggestion.html", suggestion: suggestion)
  end

  def new(conn, _params) do
    categories = Picker.list_categories()
    changeset = Picker.change_restaurant(%Restaurant{})

    render(conn, "new.html", changeset: changeset, categories: categories)
  end

  def create(conn, %{"restaurant" => restaurant_params}) do
    case Picker.create_restaurant(restaurant_params) do
      {:ok, restaurant} ->
        conn
        |> put_flash(:info, "Restaurant created successfully.")
        |> redirect(to: restaurant_path(conn, :show, restaurant))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    restaurant = Picker.get_restaurant!(id)
    render(conn, "show.html", restaurant: restaurant)
  end

  def edit(conn, %{"id" => id}) do
    restaurant = Picker.get_restaurant!(id)

    restaurant =
      restaurant
      |> Map.put(
        :category_list,
        Enum.map(restaurant.categories, fn x -> x.name end) |> Enum.join(", ")
      )

    changeset = Picker.change_restaurant(restaurant)
    render(conn, "edit.html", restaurant: restaurant, changeset: changeset)
  end

  def update(conn, %{"id" => id, "restaurant" => restaurant_params}) do
    restaurant = Picker.get_restaurant!(id)

    case Picker.update_restaurant(restaurant, restaurant_params) do
      {:ok, restaurant} ->
        conn
        |> put_flash(:info, "Restaurant updated successfully.")
        |> redirect(to: restaurant_path(conn, :show, restaurant))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", restaurant: restaurant, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    restaurant = Picker.get_restaurant!(id)
    {:ok, _restaurant} = Picker.delete_restaurant(restaurant)

    conn
    |> put_flash(:info, "Restaurant deleted successfully.")
    |> redirect(to: restaurant_path(conn, :index))
  end

  defp get_sample(list) when list == [],
    do: %Restaurant{id: 0}

  defp get_sample(list), do: Enum.random(list)

  defp split_categories(value) do
    value
    |> String.split(",")
    |> Enum.map(&String.trim/1)
    |> Enum.filter(&(&1 != ""))
  end
end
