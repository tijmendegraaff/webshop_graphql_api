defmodule WebshopGraphqlApiWeb.Schema.Mutation.CreateEmployeeTest do
  use WebshopGraphqlApiWeb.ConnCase, async: true

  import WebshopGraphqlApi.Factory

  @query """
  mutation($input: EmployeeInputType!){
    createEmployee(input: $input){
      firstName
      lastName
      email
      phoneNumber
      role
    }
  }
  """

  test "createEmployee mutation creates a employee with valid attributes by and admin user" do
    admin =
      build(:employee)
      |> make_admin
      |> insert

    employee = build(:employee)

    input = %{
      input: %{
        "firstName" => employee.first_name,
        "lastName" => employee.last_name,
        "email" => employee.email,
        "role" => employee.role,
        "phoneNumber" => employee.phone_number,
        "password" => employee.password,
        "passwordConfirmation" => employee.password_confirmation
      }
    }

    conn =
      build_conn()
      |> auth_user(admin)

    conn =
      post conn, "/api",
        query: @query,
        variables: input

    assert %{
             "data" => %{
               "createEmployee" => data
             }
           } = json_response(conn, 200)

    assert data == %{
             "email" => employee.email,
             "firstName" => employee.first_name,
             "lastName" => employee.last_name,
             "phoneNumber" => employee.phone_number,
             "role" => employee.role
           }
  end

  test "createEmployee mutation throws an error when user is not an admin" do
    admin = insert(:employee)

    employee = build(:employee)

    input = %{
      input: %{
        "firstName" => employee.first_name,
        "lastName" => employee.last_name,
        "email" => employee.email,
        "role" => employee.role,
        "phoneNumber" => employee.phone_number,
        "password" => employee.password,
        "passwordConfirmation" => employee.password_confirmation
      }
    }

    conn =
      build_conn()
      |> auth_user(admin)

    conn =
      post conn, "/api",
        query: @query,
        variables: input

    assert %{
             "data" => %{"createEmployee" => nil},
             "errors" => [
               %{
                 "locations" => [%{"column" => 0, "line" => 2}],
                 "message" => "unauthorized",
                 "path" => ["createEmployee"]
               }
             ]
           } == json_response(conn, 200)
  end
end
