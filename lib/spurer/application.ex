defmodule Spurer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      SpurerWeb.Telemetry,
      # Start the Ecto repository
      Spurer.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Spurer.PubSub},
      # Start Finch
      {Finch, name: Spurer.Finch},
      # Start the Endpoint (http/https)
      SpurerWeb.Endpoint,
      # Start a worker by calling: Spurer.Worker.start_link(arg)
      # {Spurer.Worker, arg},
      {Registry, [keys: :unique, name: Spurer.BucketRegistry]},
      {DynamicSupervisor, strategy: :one_for_one, name: Spurer.BucketSupervisor}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Spurer.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SpurerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
