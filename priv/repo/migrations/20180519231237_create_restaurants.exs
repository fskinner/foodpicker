defmodule Foodpicker.Repo.Migrations.CreateRestaurants do
  use Ecto.Migration

  def change do
    create table(:restaurants) do
      add(:name, :string)
      add(:price_range, :integer)

      timestamps()
    end
  end
end
