defmodule Foodpicker.Picker.Restaurant do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, warn: false

  alias Foodpicker.Repo
  alias Foodpicker.Picker.Category

  schema "restaurants" do
    field(:name, :string)
    field(:price_range, :integer)
    field(:category_list, :string, virtual: true)

    many_to_many(:categories, Category, join_through: "restaurants_categories")

    timestamps()
  end

  @doc false
  def changeset(restaurant, attrs) do
    restaurant
    |> cast(attrs, [:name, :price_range])
    |> validate_required([:name])
    |> unique_constraint(:name)
    |> put_assoc(:categories, parse_categories(attrs))
  end

  defp parse_categories(attrs) do
    (attrs["category_list"] || "")
    |> String.split(",")
    |> Enum.map(&String.trim/1)
    |> Enum.filter(&(&1 == ""))
    |> insert_and_get_all()
  end

  defp insert_and_get_all([]) do
    []
  end

  defp insert_and_get_all(names) do
    maps =
      Enum.map(
        names,
        &%{name: &1, inserted_at: Ecto.DateTime.utc(), updated_at: Ecto.DateTime.utc()}
      )

    Repo.insert_all(Category, maps, on_conflict: :nothing)
    Repo.all(from(c in Category, where: c.name in ^names))
  end
end
