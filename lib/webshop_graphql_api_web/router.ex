defmodule WebshopGraphqlApiWeb.Router do
  use WebshopGraphqlApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug WebshopGraphqlApiWeb.Plugs.Context
  end

  scope "/api" do
    pipe_through :api

    forward(
      "/graphiql",
      Absinthe.Plug.GraphiQL,
      schema: WebshopGraphqlApiWeb.Schema
    )

    forward(
      "/",
      Absinthe.Plug,
      schema: WebshopGraphqlApiWeb.Schema
    )
  end
end
