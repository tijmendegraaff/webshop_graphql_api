defmodule WebshopGraphqlApi.Guardian do
  use Guardian, otp_app: :webshop_graphql_api
  alias WebshopGraphqlApi.Accounts

  def subject_for_token(%Accounts.Customer{} = customer, _claims) do
    sub = %{role: "customer", id: to_string(customer.id)}
    {:ok, sub}
  end

  def subject_for_token(%Accounts.Employee{} = employee, _claims) do
    sub = %{role: "employee", id: to_string(employee.id)}
    {:ok, sub}
  end

  def subject_for_token(_, _) do
    {:error, :reason_for_error}
  end

  def resource_from_claims(%{"sub" => user}) do
    case Map.get(user, "role") do
      "customer" ->
        resource =
          Map.get(user, "id")
          |> Accounts.get_customer!()

        {:ok, resource}

      "employee" ->
        resource =
          Map.get(user, "id")
          |> Accounts.get_employee!()

        {:ok, resource}
    end
  end

  def resource_from_claims(_claims) do
    {:error, :reason_for_error}
  end
end
