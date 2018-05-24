defmodule Foodpicker.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add(:name, :string, null: false, size: 25)

      timestamps()
    end

    create(unique_index(:categories, [:name]))
  end
end
