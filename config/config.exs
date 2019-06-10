# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :party_manager_back,
  ecto_repos: [PartyManagerBack.Repo]

# Configures the endpoint
config :party_manager_back, PartyManagerBackWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "6BiVB429WQ7aYMkRMc6wPsPeYBWuKQp5YQR4/kplGAqaT+tS7JVeCTGEpeXY7pVG",
  render_errors: [view: PartyManagerBackWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: PartyManagerBack.PubSub, adapter: Phoenix.PubSub.PG2]

config :party_manager_back, PartyManagerBack.Guardian,
  issuer: "PartyManagerBack",
  secret_key: "ZwWJtc0do7WOwoEqw6V/GB4UMOAsUgpYTWmPAtWtRmnIknCzxu/tcL0o6hBX8kr7"

config :party_manager_back, PartyManagerBack.AuthAccessPipeline,
  module: PartyManagerBack.Guardian,
  error_handler: PartyManagerBack.AuthErrorHandler

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :party_manager_back, PartyManagerBack.Mailer,
  adapter: Bamboo.MailjetAdapter,
  api_key: System.get_env("PARTY_MANAGER_MAILJET_PUBLIC"),
  api_private_key: System.get_env("PARTY_MANAGER_MAILJET_PRIVATE")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
