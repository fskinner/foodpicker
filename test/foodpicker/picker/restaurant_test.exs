defmodule Foodpicker.RestaurantTest do
  use Foodpicker.DataCase

  alias Foodpicker.Picker.Restaurant

  @valid_attrs %{name: "Some Restaurant"}

  test "changeset with valid attributes" do
    changeset = Restaurant.changeset(%Restaurant{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset, name empty" do
    changeset =
      Restaurant.changeset(
        %Restaurant{},
        Map.put(@valid_attrs, :name, "")
      )

    refute changeset.valid?
  end

  test "changeset, name nil" do
    changeset =
      Restaurant.changeset(
        %Restaurant{},
        Map.put(@valid_attrs, :name, nil)
      )

    refute changeset.valid?
  end

  test "changeset, name too short" do
    changeset =
      Restaurant.changeset(
        %Restaurant{},
        Map.put(@valid_attrs, :name, "a")
      )

    refute changeset.valid?
  end

  test "changeset, name too long" do
    changeset =
      Restaurant.changeset(
        %Restaurant{},
        Map.put(
          @valid_attrs,
          :name,
          "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
        )
      )

    refute changeset.valid?
  end

  test "changeset, price_range too small" do
    changeset =
      Restaurant.changeset(
        %Restaurant{},
        Map.put(
          @valid_attrs,
          :price_range,
          0
        )
      )

    refute changeset.valid?
  end

  test "changeset, price_range too big" do
    changeset =
      Restaurant.changeset(
        %Restaurant{},
        Map.put(
          @valid_attrs,
          :price_range,
          11
        )
      )

    refute changeset.valid?
  end
end
