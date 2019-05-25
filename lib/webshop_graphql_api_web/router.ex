defmodule WebshopGraphqlApiWeb.Router do
  use WebshopGraphqlApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", WebshopGraphqlApiWeb do
    pipe_through :api
  end
end
