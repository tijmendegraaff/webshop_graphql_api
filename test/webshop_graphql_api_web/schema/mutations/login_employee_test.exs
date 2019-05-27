defmodule WebshopGraphqlApiWeb.Schema.Mutation.LoginEmployeeTest do
  use WebshopGraphqlApiWeb.ConnCase, async: true

  import WebshopGraphqlApi.Factory

  alias WebshopGraphqlApi.Guardian

  @query """
  mutation ($input: EmployeeSessionInputType!) {
    createEmployeeSession(input: $input) {
      token
      employee
      {
        firstName
        lastName
        email
        role
      }
    }
  }
  """
  test "creating an employee session" do
    employee = insert(:employee)

    response =
      post(build_conn(), "/api", %{
        query: @query,
        variables: %{"input" => %{"email" => employee.email, "password" => employee.password}}
      })

    assert %{
             "data" => %{
               "createEmployeeSession" => %{
                 "token" => token,
                 "employee" => employee_data
               }
             }
           } = json_response(response, 200)

    assert %{
             "firstName" => employee.first_name,
             "lastName" => employee.last_name,
             "email" => employee.email,
             "role" => employee.role
           } == employee_data

    {:ok, %{"sub" => sub}} = Guardian.decode_and_verify(token)
    assert {:ok, %{"role" => "employee", "id" => Integer.to_string(employee.id)}} == {:ok, sub}
  end

  test "creating an employee session with wrong credentials throws an error" do
    employee = insert(:employee)

    response =
      post(build_conn(), "/api", %{
        query: @query,
        variables: %{"input" => %{"email" => "wrong@email.com", "password" => employee.password}}
      })

    assert %{
             "data" => %{"createEmployeeSession" => nil},
             "errors" => [
               %{
                 "locations" => [%{"column" => 0, "line" => 2}],
                 "message" => "Incorrect login credentials",
                 "path" => ["createEmployeeSession"]
               }
             ]
           } = json_response(response, 200)
  end
end
