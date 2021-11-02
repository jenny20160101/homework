defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view

  @impl true
  def mount(_params, session, socket) do
    # {:ok, assign(socket, query: "abcd", results: %{"key1" => "name1"})}
    IO.inspect(session)

    {:ok,
     assign(socket,
       score: 0,
       message: "Guess a number",
       user: Pento.Accounts.get_user_by_session_token(session["user_token"]),
       session_id: session["live_socket_id"]
     )}
  end

  @impl true
  def render(assigns) do
    ~L"""
    <h1>Your score: <%= @score %></h1>​<h2>​<%= @message %>It's <%= time() %>​</h2>​
    ​ 	​  <h2>​
    ​ 	​    <%= for n <- 1..10 do %>​
    ​ 	​      <a href="#" phx-click="guess" phx-value-number="<%= n %>"><%= n %></a>​
    ​ 	​    <% end %>​</h2>​
      <%= @user.email %></br>
      <%= @session_id %></br>
    """
  end

  def time do
    DateTime.utc_now() |> to_string
  end

  @impl true
  def handle_event("guess", %{"number" => guess} = data, socket) do
    IO.inspect(data)
    message = "your guess : #{guess}. Wrong ,guess again."
    score = socket.assigns.score - 1
    {:noreply, assign(socket, score: score, message: message)}
  end
end
