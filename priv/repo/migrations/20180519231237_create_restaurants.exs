defmodule Foodpicker.Repo.Migrations.CreateRestaurants do
  use Ecto.Migration

  def change do
    create table(:restaurants) do
      add(:name, :string, null: false, size: 30)
      add(:price_range, :integer, null: false, default: 0)

      timestamps()
    end

    create(unique_index(:restaurants, [:name]))
  end
end
