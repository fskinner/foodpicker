defmodule Foodpicker.PickerTest do
  use Foodpicker.DataCase

  alias Foodpicker.Picker

  describe "categories" do
    alias Foodpicker.Picker.Category

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def category_fixture(attrs \\ %{}) do
      {:ok, category} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Picker.create_category()

      category
    end

    test "list_categories/0 returns all categories" do
      category = category_fixture()

      assert Picker.list_categories() |> Enum.map(&Map.delete(&1, :restaurants)) ==
               [category] |> Enum.map(&Map.delete(&1, :restaurants))
    end

    test "list_categories/0 returns all categories with preloaded restaurants" do
      _ = category_fixture()

      assert Picker.list_categories()
             |> Enum.all?(&Ecto.assoc_loaded?(Picker.get_category!(&1.id).restaurants))
    end

    test "get_category!/1 returns the category with given id" do
      category = category_fixture()

      assert Picker.get_category!(category.id) |> Map.delete(:restaurants) ==
               category |> Map.delete(:restaurants)
    end

    test "get_category!/1 returns the category with preloaded restaurants" do
      category = category_fixture()

      assert Ecto.assoc_loaded?(Picker.get_category!(category.id).restaurants)
    end

    test "create_category/1 with valid data creates a category" do
      assert {:ok, %Category{} = category} = Picker.create_category(@valid_attrs)
      assert category.name == "some name"
    end

    test "create_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Picker.create_category(@invalid_attrs)
    end

    test "update_category/2 with valid data updates the category" do
      category = category_fixture()
      assert {:ok, category} = Picker.update_category(category, @update_attrs)
      assert %Category{} = category
      assert category.name == "some updated name"
    end

    test "update_category/2 with invalid data returns error changeset" do
      category = category_fixture()
      assert {:error, %Ecto.Changeset{}} = Picker.update_category(category, @invalid_attrs)

      assert category |> Map.delete(:restaurants) ==
               Picker.get_category!(category.id) |> Map.delete(:restaurants)
    end

    test "delete_category/1 deletes the category" do
      category = category_fixture()
      assert {:ok, %Category{}} = Picker.delete_category(category)
      assert_raise Ecto.NoResultsError, fn -> Picker.get_category!(category.id) end
    end

    test "change_category/1 returns a category changeset" do
      category = category_fixture()
      assert %Ecto.Changeset{} = Picker.change_category(category)
    end
  end

  describe "restaurants" do
    alias Foodpicker.Picker.Restaurant

    @valid_attrs %{name: "some name", price_range: 1}
    @update_attrs %{name: "some updated name", price_range: 2}
    @invalid_attrs %{name: nil, price_range: nil}

    def restaurant_fixture(attrs \\ %{}) do
      {:ok, restaurant} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Picker.create_restaurant()

      restaurant
    end

    test "list_restaurants/0 returns all restaurants" do
      restaurant = restaurant_fixture()
      assert Picker.list_restaurants() == [restaurant]
    end

    test "list_restaurants/0 returns all restaurants with preloaded categories" do
      _ = restaurant_fixture()

      assert Picker.list_restaurants()
             |> Enum.all?(&Ecto.assoc_loaded?(Picker.get_restaurant!(&1.id).categories))
    end

    test "match_restaurants/0 returns empty given restaurants with no category" do
      _ = restaurant_fixture()
      assert Picker.match_restaurants([], "") == []
    end

    test "match_restaurants/0 returns all restaurants matching category name" do
      restaurant = restaurant_fixture(%{category_list: "Cat1, Cat2"})
      _ = restaurant_fixture(%{name: "another name", category_list: "Secret"})

      assert Picker.match_restaurants(["Cat2"], "") == [restaurant]
    end

    test "match_restaurants/0 returns all restaurants matching lesser price range" do
      _ = restaurant_fixture(%{category_list: "Cat1, Cat2", price_range: 3})

      restaurant2 =
        restaurant_fixture(%{name: "another name", category_list: "Cat1, Cat2", price_range: 1})

      assert Picker.match_restaurants([], 2) == [restaurant2]
    end

    test "get_restaurant!/1 returns the restaurant with given id" do
      restaurant = restaurant_fixture()
      assert Picker.get_restaurant!(restaurant.id) == restaurant
    end

    test "get_restaurant!/1 returns the restaurant with preloaded categories" do
      restaurant = restaurant_fixture()
      assert Ecto.assoc_loaded?(Picker.get_restaurant!(restaurant.id).categories)
    end

    test "create_restaurant/1 with valid data creates a restaurant" do
      assert {:ok, %Restaurant{} = restaurant} = Picker.create_restaurant(@valid_attrs)
      assert restaurant.name == "some name"
      assert restaurant.price_range == 1
    end

    test "create_restaurant/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Picker.create_restaurant(@invalid_attrs)
    end

    test "update_restaurant/2 with valid data updates the restaurant" do
      restaurant = restaurant_fixture()
      assert {:ok, restaurant} = Picker.update_restaurant(restaurant, @update_attrs)
      assert %Restaurant{} = restaurant
      assert restaurant.name == "some updated name"
      assert restaurant.price_range == 2
    end

    test "update_restaurant/2 with invalid data returns error changeset" do
      restaurant = restaurant_fixture()
      assert {:error, %Ecto.Changeset{}} = Picker.update_restaurant(restaurant, @invalid_attrs)
      assert restaurant == Picker.get_restaurant!(restaurant.id)
    end

    test "delete_restaurant/1 deletes the restaurant" do
      restaurant = restaurant_fixture()
      assert {:ok, %Restaurant{}} = Picker.delete_restaurant(restaurant)
      assert_raise Ecto.NoResultsError, fn -> Picker.get_restaurant!(restaurant.id) end
    end

    test "change_restaurant/1 returns a restaurant changeset" do
      restaurant = restaurant_fixture()
      assert %Ecto.Changeset{} = Picker.change_restaurant(restaurant)
    end
  end
end
