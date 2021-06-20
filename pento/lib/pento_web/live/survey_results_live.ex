defmodule PentoWeb.SurveyResultsLive do
  use PentoWeb, :live_component
  alias Pento.Catalog

  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> products_with_average_ratings()
     |> assign_dataset}
  end

  defp products_with_average_ratings(socket) do
    socket
    |> assign(
      :products_with_average_ratings,
      Catalog.products_with_average_ratings()
    )
  end

  def assign_dataset(
        %{
          assigns: %{products_with_average_ratings: products_with_average_ratingspr}
        } = socket
      ) do
    socket |> assign(:dataset, make_bar_chart_dataset(products_with_average_ratingspr))
  end

  defp make_bar_chart_dataset(data) do
    Contex.Dataset.new(data)
  end
end
