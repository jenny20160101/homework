defmodule Pento1Web.RatingLive.IndexComponent do
  use Pento1Web, :live_component

  def ratings_complete?(products) do
    Enum.all?(products, fn product ->
      length(product.ratings) == 1
    end)
  end
end
