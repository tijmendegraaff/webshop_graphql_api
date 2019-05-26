use Mix.Config

# Configure your database
config :webshop_graphql_api, WebshopGraphqlApi.Repo,
  username: "postgres",
  password: "",
  database: "webshop_graphql_api_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :webshop_graphql_api, WebshopGraphqlApiWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
