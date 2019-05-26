defmodule WebshopGraphqlApi.Accounts.Session do
  alias WebshopGraphqlApi.Accounts.{Employee, Customer}
  alias WebshopGraphqlApi.Repo
  alias WebshopGraphqlApi.Utils.Password

  def authenticate_customer(args) do
    Repo.get_by(Customer, email: String.downcase(args.email))
    |> compare_passwords(args)
  end

  def authenticate_employee(args) do
    Repo.get_by(Employee, email: String.downcase(args.email))
    |> compare_passwords(args)
  end

  defp compare_passwords(model, args) do
    case Password.check_password(model, args) do
      true -> {:ok, model}
      _ -> {:error, "Incorrect login credentials"}
    end
  end
end
