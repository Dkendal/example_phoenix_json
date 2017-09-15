defmodule ElixirHelloJson.Application do
  use Application

  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the Ecto repository
      supervisor(ElixirHelloJson.Repo, []),
      # worker(Task, [&configure_mnesia_in_memory/0], restart: :transient),
      # Start the endpoint when the application starts
      supervisor(ElixirHelloJsonWeb.Endpoint, []),
      # Start your own worker by calling: ElixirHelloJson.Worker.start_link(arg1, arg2, arg3)
      # worker(ElixirHelloJson.Worker, [arg1, arg2, arg3]),
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ElixirHelloJson.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ElixirHelloJsonWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  def configure_mnesia_in_memory() do
    Process.sleep(500)
    IO.puts "\nconfigure mnesia"
    {:ok, _} = Application.ensure_all_started(:my_parent)

    path = Application.app_dir(:my_child, "priv/repo/migrations")
    Ecto.Migrator.run(MyParent.Repo, path, :up, all: true)

    IO.inspect Mix.Task.run("ecto.create")
    IO.inspect Mix.Task.run("ecto.migrate")
  end
end
