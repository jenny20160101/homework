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

  def with_average_ratings(query \\ base()) do
    query |> join_ratings |> average_ratings
  end

  def join_ratings(query) do
    query |> join(:inner, [p], r in Rating, on: r.product_id == p.id)
  end

  def average_ratings(query) do
    query
    |> group_by([p], p.id)
    |> select([p, r], {p.name, fragment("?::float", avg(r.stars))})
  end
end
