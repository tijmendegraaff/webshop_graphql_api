defmodule WebshopGraphqlApi.Repo do
  use Ecto.Repo,
    otp_app: :webshop_graphql_api,
    adapter: Ecto.Adapters.Postgres
end
