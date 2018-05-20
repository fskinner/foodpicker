defmodule Foodpicker.Picker.Restaurant do
  use Ecto.Schema
  import Ecto.Changeset

  alias Foodpicker.Picker.Category

  schema "restaurants" do
    field(:name, :string)
    field(:price_range, :integer)

    many_to_many(:categories, Category, join_through: "restaurants_categories")

    timestamps()
  end

  @doc false
  def changeset(restaurant, attrs) do
    restaurant
    |> cast(attrs, [:name, :price_range])
    |> validate_required([:name, :price_range])
  end
end
