# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :sentry_demo,
  ecto_repos: [SentryDemo.Repo]

# Configures the endpoint
config :sentry_demo, SentryDemoWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "/6Gg1iESfr+rczwMvgWUt4bJ+rgmcMariGBI/m76xT6gzVmqAMcUP/mgvg4KXgpU",
  render_errors: [view: SentryDemoWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: SentryDemo.PubSub,
  live_view: [signing_salt: "fB6V/hY3"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
