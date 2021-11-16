defmodule Pento1Web.RatingLive.IndexComponent do
  use Pento1Web, :live_component

  def ratings_complete?(products) do
    Enum.all?(products, fn product ->
      length(product.ratings) == 1
    end)
  end

  def handle_info({:created_rating, updated_product, product_index}, socket) do
    {:noreply, handle_rating_created(socket, updated_product, product_index)}
  end

  def handle_rating_created(%{assigns: %{products: products}} = socket, updated_product, product_index) do
    socket
    |> put_flash(:info, "Rating submitted successfully")
    |> assign(:products, List.replace_at(products, product_index, updated_product))
  end
end
