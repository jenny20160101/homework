defmodule KanbanDemo.Repo do
  use Ecto.Repo,
    otp_app: :kanban_demo,
    adapter: Ecto.Adapters.Postgres
end
