defmodule Foodpicker.Repo.Migrations.CreateRestaurantsCategories do
  use Ecto.Migration

  def change do
    create table(:restaurants_categories) do
      add(:restaurant_id, references(:restaurants))
      add(:category_id, references(:categories))
    end

    create(unique_index(:restaurants_categories, [:category_id, :restaurant_id]))
  end
end
