defmodule PentoWeb.ProductLive.FormComponent do
  use PentoWeb, :live_component

  alias Pento.Catalog

  # @impl true
  # def update1(%{product: product} = assigns, socket) do
  #   changeset = Catalog.change_product(product)

  #   {:ok,
  #    socket
  #    |> assign(assigns)
  #    |> assign(:changeset, changeset)
  #    |> allow_upload(:image,
  #    accept: ~w(.jpg .jpeg .png),
  #    max_entries: 1,
  #     auto_upload: true)
  # }
  # end

  @impl true
  def update(%{product: product} = assigns, socket) do
    changeset = Catalog.change_product(product)

    socket =
      socket
      |> assign(assigns)
      |> assign(:changeset, changeset)

    {:ok, allow_upload(socket, :image, accept: ~w(.jpg .jpeg .png), max_entries: 1, auto_upload: true, progress: &handle_progress/3)}
  end

  defp handle_progress(:avatar, entry, socket) do
    if entry.done? do
      uploaded_file = entry
      # uploaded_file =
      #   consume_uploaded_entry(socket, entry, fn %{} = meta ->
      #     ...
      #   end)

      {:noreply, put_flash(socket, :info, "file #{uploaded_file.name} uploaded")}
    else
      {:noreply, socket}
    end
  end

  @impl true
  def handle_event("validate", %{"product" => product_params}, socket) do
    changeset =
      socket.assigns.product
      |> Catalog.change_product(product_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"product" => product_params}, socket) do
    save_product(socket, socket.assigns.action, product_params)
  end

  defp save_product(socket, :edit, product_params) do
    case Catalog.update_product(socket.assigns.product, product_params) do
      {:ok, _product} ->
        {:noreply,
         socket
         |> put_flash(:info, "Product updated successfully!")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_product(socket, :new, product_params) do
    case Catalog.create_product(product_params) do
      {:ok, _product} ->
        {:noreply,
         socket
         |> put_flash(:info, "Product created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
