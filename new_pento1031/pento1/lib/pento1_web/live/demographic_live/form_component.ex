defmodule Pento1Web.DemographicLive.FormComponent do
  use Pento1Web, :live_component
  alias Pento1.Survey
  alias Pento1.Survey.Demographic

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
end
