defmodule WebshopGraphqlApi.AccountsTest.EmpoyeeTest do
  use WebshopGraphqlApi.DataCase

  alias WebshopGraphqlApi.Accounts

  describe "employees" do
    alias WebshopGraphqlApi.Accounts.Employee

    @valid_attrs %{
      email: "email@email.com",
      first_name: "some first_name",
      last_name: "some last_name",
      password: "password1234",
      password_confirmation: "password1234",
      phone_number: "some phone_number",
      role: "intern"
    }
    @update_attrs %{
      email: "updated_email@email.com",
      first_name: "some updated first_name",
      last_name: "some updated last_name",
      password: "password1234",
      password_confirmation: "password1234",
      phone_number: "some updated phone_number",
      role: "senior"
    }
    @invalid_attrs %{
      email: nil,
      first_name: nil,
      last_name: nil,
      password: nil,
      password_confirmation: nil,
      phone_number: nil,
      role: nil
    }

    def employee_fixture(attrs \\ %{}) do
      {:ok, employee} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_employee()

      employee
    end

    test "list_employees/0 returns all employees" do
      employee = employee_fixture()
      assert Accounts.list_employees() == [employee]
    end

    test "get_employee!/1 returns the employee with given id" do
      employee = employee_fixture()
      assert Accounts.get_employee!(employee.id) == employee
    end

    test "create_employee/1 with valid data creates a employee" do
      assert {:ok, %Employee{} = employee} = Accounts.create_employee(@valid_attrs)
      assert employee.email == @valid_attrs.email
      assert employee.first_name == @valid_attrs.first_name
      assert employee.last_name == @valid_attrs.last_name
      assert employee.password_hash != nil
      assert employee.phone_number == @valid_attrs.phone_number
      assert employee.role == @valid_attrs.role
    end

    test "create_employee/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_employee(@invalid_attrs)
    end

    test "update_employee/2 with valid data updates the employee" do
      employee = employee_fixture()
      assert {:ok, %Employee{} = employee} = Accounts.update_employee(employee, @update_attrs)
      assert employee.email == @update_attrs.email
      assert employee.first_name == @update_attrs.first_name
      assert employee.last_name == @update_attrs.last_name
      assert employee.phone_number == @update_attrs.phone_number
      assert employee.password_hash != nil
      assert employee.role == @update_attrs.role
    end

    test "update_employee/2 with invalid data returns error changeset" do
      employee = employee_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_employee(employee, @invalid_attrs)
      assert employee == Accounts.get_employee!(employee.id)
    end

    test "delete_employee/1 deletes the employee" do
      employee = employee_fixture()
      assert {:ok, %Employee{}} = Accounts.delete_employee(employee)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_employee!(employee.id) end
    end

    test "change_employee/1 returns a employee changeset" do
      employee = employee_fixture()
      assert %Ecto.Changeset{} = Accounts.change_employee(employee)
    end
  end
end
