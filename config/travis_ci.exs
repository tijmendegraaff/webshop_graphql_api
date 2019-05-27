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

config :webshop_graphql_api, WebshopGraphqlApi.Guardian,
  issuer: "webshop_graphql_api",
  secret_key: "9rz8YRrhsqndkexMLUe32HbB8ajS7b2tIpLsTVFy7sBMbCUk3Px4bZrd4rDKJ2o+"

# Print only warnings and errors during test
config :logger, level: :warn
