defmodule WebshopGraphqlApiWeb.Resolvers.CustomerResolver do
  alias WebshopGraphqlApi.Accounts
  alias WebshopGraphqlApi.Accounts.Session
  alias WebshopGraphqlApi.Guardian

  def customers(_, _, _) do
    {:ok, Accounts.list_customers()}
  end

  def create_customer(_, %{input: input}, _) do
    Accounts.create_customer(input)
  end

  def create_customer_session(_, %{input: input}, _) do
    with {:ok, customer} <- Session.authenticate_customer(input),
         {:ok, jwt, _} <- Guardian.encode_and_sign(customer) do
      {:ok, %{customer: customer, token: jwt}}
    end
  end
end
