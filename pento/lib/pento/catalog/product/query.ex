defmodule Pento.Catalog.Product.Query do
  import Ecto.Query
  alias Pento.Catalog.Product
  alias Pento.Survey.Rating

  def base, do: Product

  def with_user_ratings(query \\ base(), user) do
    ratings_query = Rating.Query.preload_user(user)
    IO.inspect(ratings_query, label: "ratings_query", pretty: true)

    query |> preload(ratings: ^ratings_query)
  end
end
