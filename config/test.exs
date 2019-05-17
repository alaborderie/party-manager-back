use Mix.Config

# Configure your database
config :party_manager_back, PartyManagerBack.Repo,
  username: "root",
  password: "",
  database: "party_manager_back_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :party_manager_back, PartyManagerBackWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
