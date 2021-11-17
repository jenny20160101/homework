defmodule Pento2.Repo do
  use Ecto.Repo,
    otp_app: :pento2,
    adapter: Ecto.Adapters.Postgres
end
