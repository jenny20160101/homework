defmodule Pento2.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Pento2.Repo,
      # Start the Telemetry supervisor
      Pento2Web.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Pento2.PubSub},
      # Start the Endpoint (http/https)
      Pento2Web.Endpoint
      # Start a worker by calling: Pento2.Worker.start_link(arg)
      # {Pento2.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Pento2.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    Pento2Web.Endpoint.config_change(changed, removed)
    :ok
  end
end
