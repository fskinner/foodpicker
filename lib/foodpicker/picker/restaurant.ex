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
    |> unique_constraint(:name)
    |> put_assoc(:categories, parse_categories(params))
  end

  defp parse_categories(params) do
    (params["categories"] || "")
    |> String.split(",")
    |> Enum.map(&String.trim/1)
    |> Enum.filter(&(&1 == ""))
    |> Enum.map(&get_or_insert_category/1)
  end

  defp get_or_insert_category(name) do
    Repo.get_by(Category, name: name) || try_insert_category(name)
  end

  defp try_insert_category(name) do
    %Tag{}
    |> Ecto.Changeset.change(name: name)
    |> Ecto.Changeset.unique_constraint(:name)
    |> Repo.insert()
    |> case do
      {:ok, tag} -> tag
      {:error, _} -> Repo.get_by!(Category, name: name)
    end
  end
end
