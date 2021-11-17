defmodule Pento2Web.PageController do
  use Pento2Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
