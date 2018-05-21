defmodule Foodpicker.Picker.Category do
  use Ecto.Schema
  import Ecto.Changeset

  alias Foodpicker.Picker.Restaurant

  schema "categories" do
    field(:name, :string)

    many_to_many(:restaurants, Restaurant, join_through: "restaurants_categories")

    timestamps()
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
