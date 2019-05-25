defmodule WebshopGraphqlApi.AccountsTest do
  use WebshopGraphqlApi.DataCase

  alias WebshopGraphqlApi.Accounts

  describe "customers" do
    alias WebshopGraphqlApi.Accounts.Customer

    @valid_attrs %{
      date_of_birth: ~N[2010-04-17 14:00:00],
      email: "some email",
      first_name: "some first_name",
      last_name: "some last_name",
      password_hash: "some password_hash",
      phone_number: "some phone_number"
    }
    @update_attrs %{
      date_of_birth: ~N[2011-05-18 15:01:01],
      email: "some updated email",
      first_name: "some updated first_name",
      last_name: "some updated last_name",
      password_hash: "some updated password_hash",
      phone_number: "some updated phone_number"
    }
    @invalid_attrs %{
      date_of_birth: nil,
      email: nil,
      first_name: nil,
      last_name: nil,
      password_hash: nil,
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
      assert customer.date_of_birth == ~N[2010-04-17 14:00:00]
      assert customer.email == "some email"
      assert customer.first_name == "some first_name"
      assert customer.last_name == "some last_name"
      assert customer.password_hash == "some password_hash"
      assert customer.phone_number == "some phone_number"
    end

    test "create_customer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_customer(@invalid_attrs)
    end

    test "update_customer/2 with valid data updates the customer" do
      customer = customer_fixture()
      assert {:ok, %Customer{} = customer} = Accounts.update_customer(customer, @update_attrs)
      assert customer.date_of_birth == ~N[2011-05-18 15:01:01]
      assert customer.email == "some updated email"
      assert customer.first_name == "some updated first_name"
      assert customer.last_name == "some updated last_name"
      assert customer.password_hash == "some updated password_hash"
      assert customer.phone_number == "some updated phone_number"
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
