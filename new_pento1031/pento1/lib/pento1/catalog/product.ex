defmodule Pento1.Catalog.Product do
  use Ecto.Schema
  import Ecto.Changeset

  alias Pento1.Survey.Rating

  schema "products" do
    field :description, :string
    field :name, :string
    field :sku, :integer
    field :unit_price, :float
    field :image_upload, :string

    timestamps()

    has_many :ratings, Rating
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :description, :unit_price, :sku, :image_upload])
    |> validate_required([:name, :description, :unit_price, :sku])
    |> unique_constraint(:sku)
  end
end
