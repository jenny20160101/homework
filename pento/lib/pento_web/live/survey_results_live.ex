defmodule PentoWeb.SurveyResultsLive do
  use PentoWeb, :live_component
  alias Pento.Catalog
  alias Contex
  alias Contex.Plot

  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> asign_age_group_filter()
     |> assign_products_with_average_ratings()
     |> assign_dataset()
     |> assign_chart()
     |> assign_chart_svg()
    }
  end

  # defp test(socket) do
  #   socket |> assign(:age_group_filter, "all")
  # end

  defp asign_age_group_filter(socket) do
    socket |> assign(:age_group_filter, "all")
  end

  defp assign_products_with_average_ratings(
         %{assigns: %{age_group_filter: age_group_filter}} = socket
       ) do
    socket
    |> assign(
      :products_with_average_ratings,
      get_products_with_average_ratings(%{age_group_filter: age_group_filter})
    )
  end

  defp get_products_with_average_ratings(filter) do
    case Catalog.products_with_average_ratings(filter) do
      [] -> Catalog.product_with_zero_ratings()
      products -> products
    end
  end

  def assign_dataset(
        %{
          assigns: %{products_with_average_ratings: products_with_average_ratingspr}
        } = socket
      ) do
    socket |> assign(:dataset, make_bar_chart_dataset(products_with_average_ratingspr))
  end

  defp make_bar_chart_dataset(data) do
    Contex.Dataset.new(data) |> IO.inspect(label: "make_bar_chart_dataset:--------------------------------------")
  end

  def assign_chart(%{assigns: %{dataset: dataset}} = socket) do
    socket |> assign(:chart, make_bar_chart(dataset))
  end

  def make_bar_chart(dataset) do
    Contex.BarChart.new(dataset)
    #|> IO.inspect(label: "make_bar_chart:--------------------------------------")
  end

  def assign_chart_svg(%{assigns: %{chart: chart}} = socket) do
    socket |> assign(:chart_svg, render_bar_chart(chart))
  end

  def render_bar_chart(chart) do
    Plot.new(500, 400, chart)
    |> Plot.titles(title(), subtitle())
    |> Plot.axis_labels(x_axis(), y_axis())
   # |> IO.inspect(label: "Plot.axis_labels:--------------------------------------")
    |> Plot.to_svg()
  end

  def title do
    "Product Ratings"
  end

  def subtitle do
    "average star ratings per product"
  end

  defp x_axis do
    "products"
  end

  defp y_axis do
    "stars"
  end

  def handle_event("age_group_filter", %{"age_group_filter" => age_group_filter}, socket) do
    {:noreply,
     socket
     |> assign_age_group_filter(age_group_filter)
     |> assign_products_with_average_ratings()
     |> assign_dataset()
     |> assign_chart()
     |> assign_chart_svg()}
  end

  def assign_age_group_filter(socket, age_group_filter) do
    assign(socket, :age_group_filter, age_group_filter)
  end
end
