defmodule Pento1.Survey.Rating do
  use Ecto.Schema
  import Ecto.Changeset

  schema "ratings" do
    field :stars, :integer
    field :user_id, :id
    field :product_id, :id

    timestamps()
  end

  @doc false
  def changeset(rating, attrs) do
    rating
    |> cast(attrs, [:stars, :product_id, :user_id])
    |> validate_required([:stars, :product_id, :user_id])
    |> validate_inclusion(:stars, 1..5)
    |> unique_constraint(:prduct_id, name: :index_ratings_on_user_product)
  end
end
