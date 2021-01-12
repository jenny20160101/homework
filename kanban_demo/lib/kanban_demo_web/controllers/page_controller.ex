defmodule KanbanDemoWeb.PageController do
  use KanbanDemoWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
