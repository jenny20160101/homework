defmodule Pento1Web.SurveyLive do
  use Pento1Web, :live_view
  alias Pento1.{Catalog, Accounts, Survey}

  @impl true
  def mount(_params, %{"user_token" => token} = _session, socket) do
    {:ok, socket |> assign_user(token)}
  end

  def assign_user(socket, token) do
    IO.puts("Assign User with socket.private:")
    IO.inspect(socket.private)

    assign_new(socket, :current_user, fn ->
      Accounts.get_user_by_session_token(token)
    end)
  end
end
