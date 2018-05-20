defmodule Foodpicker.Repo.Migrations.CreateRestaurants do
  use Ecto.Migration

  def change do
    create table(:restaurants) do
      add(:name, :string, null: false)
      add(:price_range, :integer)

      timestamps()
    end

    create(unique_index(:restaurants, [:name]))
  end
end
