defmodule ClothingDashboard1.Catalog.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :title, :string
    field :description, :string
    field :category, :string
    field :price, :decimal
    field :stock, :integer
    field :photo, :string
    field :sold_count, :integer, default: 0
    field :transaction_dates, {:array, :utc_datetime}, default: []
    field :tags, {:array, :string}, default: []

    # has_many :transactions, ClothingDashboard1.Transaction
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [
      :title,
      :description,
      :category,
      :price,
      :stock,
      :photo,
      :sold_count,
      :transaction_dates,
      :tags
    ])
    |> validate_required([:title, :description, :category, :price, :stock])
  end
end
