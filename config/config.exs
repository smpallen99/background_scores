# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :background_scores,
  ecto_repos: [BackgroundScores.Repo]

# Configures the endpoint
config :background_scores, BackgroundScores.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "RAL2OsOLlYlMufkUykOS70/MHETTCG3IOrqEWFiiPm9r5nRWw1DGeMZWtLw09Z3c",
  render_errors: [view: BackgroundScores.ErrorView, accepts: ~w(html json)],
  pubsub: [name: BackgroundScores.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :quantum, :background_scores, 
  cron: [
    # Every minute
    "* * * * *": &BackgroundScores.Scores.fetch_scores/0
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
