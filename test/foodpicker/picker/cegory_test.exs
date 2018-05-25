defmodule Foodpicker.CategoryTest do
  use Foodpicker.DataCase

  alias Foodpicker.Picker.Category

  @valid_attrs %{name: "Some Category"}

  test "changeset with valid attributes" do
    changeset = Category.changeset(%Category{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset, name empty" do
    changeset =
      Category.changeset(
        %Category{},
        Map.put(@valid_attrs, :name, "")
      )

    refute changeset.valid?
  end

  test "changeset, name nil" do
    changeset =
      Category.changeset(
        %Category{},
        Map.put(@valid_attrs, :name, nil)
      )

    refute changeset.valid?
  end

  test "changeset, name too short" do
    changeset =
      Category.changeset(
        %Category{},
        Map.put(@valid_attrs, :name, "a")
      )

    refute changeset.valid?
  end

  test "changeset, name too long" do
    changeset =
      Category.changeset(
        %Category{},
        Map.put(
          @valid_attrs,
          :name,
          "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
        )
      )

    refute changeset.valid?
  end
end
