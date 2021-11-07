defmodule Pento1Web.PageController do
  use Pento1Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
