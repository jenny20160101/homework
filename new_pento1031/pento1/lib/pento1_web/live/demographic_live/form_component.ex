defmodule Pento1Web.DemographicLive.FormComponent do
  use Pento1Web, :live_component
  alias Pento1.Survey
  alias Pento1.Survey.Demographic

  @impl true
  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_demographic()
     |> assign_changeset()}
  end

  def assign_demographic(%{assigns: %{user: user}} = socket) do
    assign(socket, :demographic, %Demographic{user_id: user.id})
  end

  def assign_changeset(%{assigns: %{demographic: demographic}} = socket) do
    assign(socket, :changeset, Survey.change_demographic(demographic))
  end

  @impl true
  def handle_event("save", %{"demographic" => demographic_params}, socket) do
    IO.puts("Handling save event and saving demographic record...............")
    IO.inspect(demographic_params)
    {:noreply, save_demographic(socket, demographic_params)}
  end

  def save_demographic(socket, demographic_params) do
    case Survey.create_demographic(demographic_params) do
      {:ok, demographic} ->
        send(self(), {:created_demographic, demographic})

      {:error, %Ecto.Changeset{} = changeset} ->
        assign(socket, changeset: changeset)
    end
  end
end
