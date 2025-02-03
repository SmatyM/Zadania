defmodule ClothingDashboard1.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :title, :string
      add :description, :text
      add :category, :string
      add :price, :decimal
      add :stock, :integer
      add :photo, :string
      add :sold_count, :integer, default: 0
      add :transaction_dates, {:array, :utc_datetime}, default: []
      add :tags, {:array, :string}, default: []

      timestamps(type: :utc_datetime)
    end
  end
end
