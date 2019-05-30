defmodule WebshopGraphqlApiWeb.Schema.Mutation.CreateEmployeeTest do
  use WebshopGraphqlApiWeb.ConnCase, async: true

  import WebshopGraphqlApi.Factory

  @query """
  mutation($input: CustomerInputType!){
    createCustomer(input: $input){
      firstName
      lastName
      email
    }
  }
  """

  test "createCustomer mutation creates a customer with valid attributes" do
    customer = build(:customer)

    input = %{
      input: %{
        "firstName" => customer.first_name,
        "lastName" => customer.last_name,
        "email" => customer.email,
        "password" => customer.password,
        "passwordConfirmation" => customer.password_confirmation
      }
    }

    response =
      post(build_conn(), "/api", %{
        query: @query,
        variables: input
      })

    assert %{
             "data" => %{
               "createCustomer" => data
             }
           } = json_response(response, 200)

    assert data == %{
             "email" => customer.email,
             "firstName" => customer.first_name,
             "lastName" => customer.last_name
           }
  end

  test "createCustomer mutation fails with passwords that don't match" do
    customer = build(:customer)

    input = %{
      input: %{
        "firstName" => customer.first_name,
        "lastName" => customer.last_name,
        "email" => customer.email,
        "password" => customer.password,
        "passwordConfirmation" => "somerandomString"
      }
    }

    response =
      post(build_conn(), "/api", %{
        query: @query,
        variables: input
      })

    assert %{
             "errors" => [
               %{
                 "locations" => [%{"column" => 0, "line" => 2}],
                 "message" => "password_confirmation: passwords don't match",
                 "path" => ["createCustomer"]
               }
             ],
             "data" => %{"createCustomer" => nil}
           } == json_response(response, 200)
  end
end
