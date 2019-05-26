defmodule WebshopGraphqlApiWeb.Resolvers.SessionResolver do
  alias WebshopGraphqlApi.Accounts.Session
  alias WebshopGraphqlApi.Guardian

  def create_customer_session(_, %{input: input}, _) do
    with {:ok, customer} <- Session.authenticate_customer(input),
         {:ok, jwt, _} <- Guardian.encode_and_sign(customer) do
      {:ok, %{customer: customer, token: jwt}}
    end
  end
end
