defmodule WebshopGraphqlApiWeb.Schema.Mutation.CreateEmployeeAddressTest do
  use WebshopGraphqlApiWeb.ConnCase, async: true

  import WebshopGraphqlApi.Factory

  @query """
  mutation($input: CustomerAddressInputType!){
    createCustomerAddress(input: $input){
      default
      zipCode
      streetName
      houseNumber
      default
    }
  }
  """

  test "createCustomerAddress mutation creates an address for a customer" do
    customer = insert(:customer)

    input = %{
      input: %{
        "default" => false,
        "zipCode" => "1989TG",
        "streetName" => "Teststraat",
        "houseNumber" => "199-2",
        "city" => "Amsterdam"
      }
    }

    conn = build_conn() |> auth_user(customer)

    conn =
      post conn, "/api",
        query: @query,
        variables: input

    assert %{
             "data" => %{
               "createCustomerAddress" => %{
                 "default" => false,
                 "houseNumber" => "199-2",
                 "streetName" => "Teststraat",
                 "zipCode" => "1989TG"
               }
             }
           } == json_response(conn, 200)
  end

  test "createCustomerAddress mutation fails if input is not valid" do
    customer = insert(:customer)

    input = %{
      input: %{
        "default" => nil,
        "zipCode" => nil,
        "streetName" => nil,
        "houseNumber" => nil,
        "city" => nil
      }
    }

    conn = build_conn() |> auth_user(customer)

    conn =
      post conn, "/api",
        query: @query,
        variables: input

    assert %{
             "errors" => [
               %{
                 "locations" => [],
                 "message" =>
                   "Argument \"input\" has invalid value $input.\nIn field \"city\": Expected type \"String!\", found null.\nIn field \"houseNumber\": Expected type \"String!\", found null.\nIn field \"streetName\": Expected type \"String!\", found null.\nIn field \"zipCode\": Expected type \"String!\", found null."
               }
             ]
           } == json_response(conn, 200)
  end

  test "createCustomerAddress mutation fails if not signed in" do
    input = %{
      input: %{
        "default" => false,
        "zipCode" => "1989TG",
        "streetName" => "Teststraat",
        "houseNumber" => "199-2",
        "city" => "Amsterdam"
      }
    }

    conn = build_conn()

    conn =
      post conn, "/api",
        query: @query,
        variables: input

    assert %{
             "data" => %{"createCustomerAddress" => nil},
             "errors" => [
               %{
                 "locations" => [%{"column" => 0, "line" => 2}],
                 "message" => "unauthorized",
                 "path" => ["createCustomerAddress"]
               }
             ]
           } == json_response(conn, 200)
  end
end
