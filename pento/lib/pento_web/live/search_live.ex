defmodule PentoWeb.SearchLive do
  use PentoWeb, :live_view
  alias Pento.Catalog
  alias Pento.Catalog.Product

  @impl true
  def mount(_params, _session, socket) do
    socket
    |> assign(:changeset, Product.changeset(%Product{}, %{}))

    IO.inspect(socket)

    {:ok, socket}
  end

  @impl true
  def handle_event(%{"sku" => sku}, "search", socket) do

   product = Catalog.get_product!(100)


   {:noreply, assign(socket, :product, product)}

  end

end
