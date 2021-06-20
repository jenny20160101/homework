defmodule PentoWeb.AdminDashboardLive do
  use PentoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket |> assign(:survey_result_component_id, "survey-results")}
  end
end
