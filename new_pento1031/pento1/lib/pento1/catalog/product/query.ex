defmodule Pento1.Catalog.Product.Query do
  import Ecto.Query
  alias Pento1.Catalog.Product
  alias Pento1.Survey.Rating

  def base, do: Product

  def with_user_ratings(query \\ base(), user) do
    ratings_query = Rating.Query.preload_user(user)

    query
    |> preload(ratings: ^ratings_query)
  end
end
