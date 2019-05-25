defmodule WebshopGraphqlApiWeb.Resolvers.CustomerResolver do
  alias WebshopGraphqlApi.Accounts

  def customers(_, _, _) do
    {:ok, Accounts.list_customers()}
  end

  def create_customer(_, %{input: input}, _) do
    Accounts.create_customer(input)
  end
end
