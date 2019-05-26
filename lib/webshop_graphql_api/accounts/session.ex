defmodule WebshopGraphqlApi.Accounts.Session do
  alias WebshopGraphqlApi.Accounts.{Employee, Customer}
  alias WebshopGraphqlApi.Repo
  alias WebshopGraphqlApi.Utils.Password

  def authenticate_customer(args) do
    customer = Repo.get_by(Customer, email: String.downcase(args.email))

    case Password.check_password(customer, args) do
      true -> {:ok, customer}
      _ -> {:error, "Incorrect login credentials"}
    end
  end
end
