defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    # {:ok, assign(socket, query: "abcd", results: %{"key1" => "name1"})}

    {:ok, assign(socket, score: 0, message: "Guess a number")}
  end

  @impl true
  def render(assigns) do
    ~L"""
    <h1>Your score: <%= @score %></h1>​<h2>​<%= @message %>It's <%= time() %>​</h2>​
    ​ 	​  <h2>​
    ​ 	​    <%= for n <- 1..10 do %>​
    ​ 	​      <a href="#" phx-click="guess" phx-value-number="<%= n %>"><%= n %></a>​
    ​ 	​    <% end %>​</h2>​
    """
  end

  def time do
    DateTime.utc_now |> to_string
  end

  @impl true
  def handle_event("guess", %{"number" => guess} = data, socket) do
    IO.inspect(data)
    message = "your guess : #{guess}. Wrong ,guess again."
    score = socket.assigns.score - 1
    {:noreply, assign(socket, score: score, message: message)}
  end
end
