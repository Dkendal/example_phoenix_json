# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :elixir_hello_json, ElixirHelloJsonWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "oIsM9VrCzrBJJTHZsJNcogk+x2hBkdsBYRi/cMl59qz3BYV1wAAmY3HfMs6Z8cmg",
  render_errors: [view: ElixirHelloJsonWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: ElixirHelloJson.PubSub,
           adapter: Phoenix.PubSub.PG2]


# ecto stuff
config :elixir_hello_json, MyRepo,
  host: {:system, :atom, "MNESIA_HOST", Kernel.node()},
  storage_type: {:system, :atom, "MNESIA_STORAGE_TYPE", :ram_copies}
  adapter: EctoMnesia.Adapter

config :mnesia, :dir, 'priv/data/mnesia'

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
