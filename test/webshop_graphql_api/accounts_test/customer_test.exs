defmodule WebshopGraphqlApi.AccountsTest.CustomerTest do
  use WebshopGraphqlApi.DataCase

  alias WebshopGraphqlApi.Accounts

  describe "customers" do
    alias WebshopGraphqlApi.Accounts.Customer

    @valid_attrs %{
      email: "some@email.com",
      first_name: "some first_name",
      last_name: "some last_name",
      password: "password1234",
      password_confirmation: "password1234",
      phone_number: "some phone_number"
    }
    @update_attrs %{
      email: "some_other@email.com",
      first_name: "some first_name",
      last_name: "some last_name",
      password: "password1234",
      password_confirmation: "password1234",
      phone_number: "some phone_number"
    }
    @invalid_attrs %{
      email: nil,
      first_name: nil,
      last_name: nil,
      password: nil,
      password_confirmation: nil,
      phone_number: nil
    }

    def customer_fixture(attrs \\ %{}) do
      {:ok, customer} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_customer()

      customer
    end

    test "list_customers/0 returns all customers" do
      customer = customer_fixture()
      assert Accounts.list_customers() == [customer]
    end

    test "get_customer!/1 returns the customer with given id" do
      customer = customer_fixture()
      assert Accounts.get_customer!(customer.id) == customer
    end

    test "create_customer/1 with valid data creates a customer" do
      assert {:ok, %Customer{} = customer} = Accounts.create_customer(@valid_attrs)
      assert customer.email == @valid_attrs.email
      assert customer.first_name == @valid_attrs.first_name
      assert customer.last_name == @valid_attrs.last_name
      assert customer.password_hash != nil
    end

    test "create_customer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_customer(@invalid_attrs)
    end

    test "update_customer/2 with valid data updates the customer" do
      customer = customer_fixture()
      assert {:ok, %Customer{} = customer} = Accounts.update_customer(customer, @update_attrs)
      assert customer.email == @update_attrs.email
      assert customer.first_name == @update_attrs.first_name
      assert customer.last_name == @update_attrs.last_name
    end

    test "update_customer/2 with invalid data returns error changeset" do
      customer = customer_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_customer(customer, @invalid_attrs)
      assert customer == Accounts.get_customer!(customer.id)
    end

    test "delete_customer/1 deletes the customer" do
      customer = customer_fixture()
      assert {:ok, %Customer{}} = Accounts.delete_customer(customer)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_customer!(customer.id) end
    end

    test "change_customer/1 returns a customer changeset" do
      customer = customer_fixture()
      assert %Ecto.Changeset{} = Accounts.change_customer(customer)
    end
  end
end
