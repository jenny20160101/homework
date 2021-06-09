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
      |> assign(:products, [])

    # IO.inspect(socket)

    {:ok, socket}
  end

  @impl true
  def handle_event("validate", %{"product" => product} = _product_params, socket) do
    # IO.inspect("validate----------")
    # IO.inspect(product_params)
    # IO.inspect(product)

    changeset =
      Catalog.change_product_search(%Product{}, product)
      |> Map.put(:action, :validate)

    # IO.inspect(changeset)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  @impl true
  def handle_event("search", %{"product" => %{"sku" => sku}} = _product_params, socket) do
    # IO.inspect("search============")
    # IO.inspect(product_params)
    # IO.inspect(sku)

    products = Catalog.get_product_by_sku(sku)
    # IO.inspect(products)

    {:noreply, assign(socket, :products, products)}
  end
end
