defmodule WebshopGraphqlApiWeb.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build common data structures and query the data layer.

  Finally, if the test case interacts with the database,
  it cannot be async. For this reason, every test runs
  inside a transaction which is reset at the beginning
  of the test unless the test case is marked as async.
  """

  use ExUnit.CaseTemplate

  alias WebshopGraphqlApi.Guardian

  using do
    quote do
      # Import conveniences for testing with connections
      use Phoenix.ConnTest
      alias WebshopGraphqlApiWeb.Router.Helpers, as: Routes

      # The default endpoint for testing
      @endpoint WebshopGraphqlApiWeb.Endpoint

      defp auth_user(conn, user) do
        {:ok, token, _} = Guardian.encode_and_sign(user)
        put_req_header(conn, "authorization", "Bearer #{token}")
      end
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(WebshopGraphqlApi.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(WebshopGraphqlApi.Repo, {:shared, self()})
    end

    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end
end
