defmodule WebshopGraphqlApiWeb.Resolvers.EmployeeResolver do
  alias WebshopGraphqlApi.Accounts
  alias WebshopGraphqlApi.Accounts.Session
  alias WebshopGraphqlApi.Guardian

  def employees(_, _, _) do
    {:ok, Accounts.list_employees()}
  end

  def create_employee(_, %{input: input}, _) do
    Accounts.create_employee(input)
  end

  def create_employee_session(_, %{input: input}, _) do
    with {:ok, employee} <- Session.authenticate_employee(input),
         {:ok, jwt, _} <- Guardian.encode_and_sign(employee) do
      {:ok, %{employee: employee, token: jwt}}
    end
  end
end
