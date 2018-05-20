defmodule Foodpicker.Picker.Restaurant do
  use Ecto.Schema
  import Ecto.Changeset


  schema "restaurants" do
    field :name, :string
    field :price_range, :string

    timestamps()
  end

  @doc false
  def changeset(restaurant, attrs) do
    restaurant
    |> cast(attrs, [:name, :price_range])
    |> validate_required([:name, :price_range])
  end
end
