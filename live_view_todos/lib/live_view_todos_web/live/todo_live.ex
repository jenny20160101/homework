defmodule LiveViewTodosWeb.TodoLive do
  use LiveViewTodosWeb, :live_view

  alias LiveViewTodos.Todos

  #https://dennisbeatty.com/how-to-create-a-todo-list-with-phoenix-liveview.html

  def mount(_params, _session, socket) do
    {:ok, assign(socket, todos: Todos.list_todos())}
  end

  def handle_event("add", %{"todo" => todo}, socket) do
    Todos.create_todo(todo)

    {:noreply, fetch(socket)}
  end

  defp fetch(socket) do
    assign(socket, todos: Todos.list_todos())
  end

#  def render(assigns) do
#    ~L"Rendering LiveView12"
#  end

end