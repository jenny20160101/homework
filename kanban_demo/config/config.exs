# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :kanban_demo,
  ecto_repos: [KanbanDemo.Repo]

# Configures the endpoint
config :kanban_demo, KanbanDemoWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "oZF2jI0i4cZvwntklBnREDxcPYjzYxIEwSO5oCCRIAH3uzVVDJ1Mk+FIhRrx+88D",
  render_errors: [view: KanbanDemoWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: KanbanDemo.PubSub,
  live_view: [signing_salt: "igC+vA3G"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
