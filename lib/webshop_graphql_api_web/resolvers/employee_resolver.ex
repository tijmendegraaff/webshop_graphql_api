defmodule WebshopGraphqlApiWeb.Resolvers.EmployeeResolver do
  alias WebshopGraphqlApi.Accounts

  def employees(_, _, _) do
    {:ok, Accounts.list_employees()}
  end

  def create_employee(_, %{input: input}, _) do
    Accounts.create_employee(input)
  end
end
