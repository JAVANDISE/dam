defmodule Javandise.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      JavandiseWeb.Telemetry,
      Javandise.Repo,
      {DNSCluster, query: Application.get_env(:javandise, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Javandise.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Javandise.Finch},
      # Start a worker by calling: Javandise.Worker.start_link(arg)
      # {Javandise.Worker, arg},
      # Start to serve requests, typically the last entry
      JavandiseWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Javandise.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    JavandiseWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
