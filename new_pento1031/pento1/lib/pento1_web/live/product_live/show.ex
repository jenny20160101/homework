defmodule Pento1Web.ProductLive.Show do
  use Pento1Web, :live_view

  alias Pento1.Catalog

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:product, Catalog.get_product!(id))}
    |> IO.inspect(label: "show handle_params:----------")
  end

  defp page_title(:show), do: "Show Product"
  defp page_title(:edit), do: "Edit Product"
end
