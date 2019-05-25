defmodule WebshopGraphqlApiWeb.Resolvers.CustomerResolver do
  alias WebshopGraphqlApi.Accounts

  def customers(_, _, _) do
    {:ok, Accounts.list_customers()}
  end
end
