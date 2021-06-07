defmodule PentoWeb.SearchLive do
  use PentoWeb, :live_view
  alias Pento.Catalog
  alias Pento.Catalog.Product

  @impl true
  def mount(_params, _session, socket) do
    changeset =
      %Product{}
      |> Product.changeset_search(%{})

    socket =
      socket
      |> assign(:changeset, changeset)

    # IO.inspect(socket)

    {:ok, socket}
  end

  @impl true
  def handle_event("validate", %{"product" => product} = _product_params, socket) do
    IO.inspect("validate----------")
    # IO.inspect(product_params)
    IO.inspect(product)

    changeset =
      Catalog.change_product_search(%Product{}, product)
      |> Map.put(:action, :validate)

    IO.inspect(changeset)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  @impl true
  def handle_event("search", _, socket) do
    IO.inspect("search============")

    product = Catalog.get_product!(1)

    {:noreply, assign(socket, :product, product)}
  end
end
