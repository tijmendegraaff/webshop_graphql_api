defmodule WebshopGraphqlApiWeb.Schema.Mutation.LoginCustomerTest do
  use WebshopGraphqlApiWeb.ConnCase, async: true

  import WebshopGraphqlApi.Factory

  alias WebshopGraphqlApi.Guardian

  @query """
  mutation ($input: CustomerSessionInputType!) {
    createCustomerSession(input: $input) {
      token
      customer
      {
        firstName
        lastName
        email
      }
    }
  }
  """
  test "creating an customer session" do
    customer = insert(:customer)

    response =
      post(build_conn(), "/api", %{
        query: @query,
        variables: %{"input" => %{"email" => customer.email, "password" => customer.password}}
      })

    assert %{
             "data" => %{
               "createCustomerSession" => %{
                 "token" => token,
                 "customer" => customer_data
               }
             }
           } = json_response(response, 200)

    assert %{
             "firstName" => customer.first_name,
             "lastName" => customer.last_name,
             "email" => customer.email
           } == customer_data

    {:ok, %{"sub" => sub}} = Guardian.decode_and_verify(token)
    assert {:ok, %{"role" => "customer", "id" => Integer.to_string(customer.id)}} == {:ok, sub}
  end

  test "creating an customer session with wrong credentials throws an error" do
    customer = insert(:customer)

    response =
      post(build_conn(), "/api", %{
        query: @query,
        variables: %{"input" => %{"email" => "wrong@email.com", "password" => customer.password}}
      })

    assert %{
             "data" => %{"createCustomerSession" => nil},
             "errors" => [
               %{
                 "locations" => [%{"column" => 0, "line" => 2}],
                 "message" => "Incorrect login credentials",
                 "path" => ["createCustomerSession"]
               }
             ]
           } = json_response(response, 200)
  end
end
