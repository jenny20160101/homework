defmodule Pento.Survey.Rating do
  use Ecto.Schema
  import Ecto.Changeset
  alias Pento.Catalog.Product
  alias Pento.Accounts.User

  schema "ratings" do
    field :stars, :integer
    field :product_id, :integer
    belongs_to :user, User
    belongs_to :Product, Product

    timestamps()
  end

  @doc false
  def changeset(rating, attrs) do
    rating
    |> cast(attrs, [:stars, :user_id, :product_id])
    |> validate_required([:stars, :user_id, :product_id])
    |> validate_inclusion(:stars, 1..5)
    |> unique_constraint(:prudct_id, name: :index_ratings_on_user_product)
  end
end
