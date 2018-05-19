# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :foodpicker,
  ecto_repos: [Foodpicker.Repo]

# Configures the endpoint
config :foodpicker, FoodpickerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "LyW46B6TYBI66AZ8gRA6i2ew4oNNa1KGkYugYWyvzgu8CHiUUQuaNGd6IHDDeQii",
  render_errors: [view: FoodpickerWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Foodpicker.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
