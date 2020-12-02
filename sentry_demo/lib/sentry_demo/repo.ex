defmodule SentryDemo.Repo do
  use Ecto.Repo,
    otp_app: :sentry_demo,
    adapter: Ecto.Adapters.Postgres
end
