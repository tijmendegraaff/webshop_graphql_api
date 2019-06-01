defmodule WebshopGraphqlApi.AccountsTest.CustomerAddressTest do
  use WebshopGraphqlApi.DataCase, async: true
  import WebshopGraphqlApi.Factory

  describe "addresses" do
    # @valid_attrs %{
    #   street_name: "Somestreet",
    #   house_number: "199-2",
    #   zip_code: "1079AR",
    #   city: "Amsterdam",
    #   customer_id: &customer.id
    # }

    # customer = insert(:customer)

    # @update_attrs %{
    #   street_name: "Someotherstreet",
    #   house_number: "34",
    #   zip_code: "1088PO",
    #   city: "Laren",
    #   customer_id: 6
    # }
    # @invalid_attrs %{
    #   street_name: nil,
    #   house_number: nil,
    #   zip_code: nil,
    #   city: nil,
    #   customer_id: nil
    # }

    # def address_fixture(attrs \\ %{}) do
    #   {:ok, address} =
    #     attrs
    #     |> Enum.into(@valid_attrs)
    #     |> Accounts.create_address()

    #   address
    # end

    # test "create_address/1 with valid data creates an address" do
    #   assert {:ok, %Address{} = address} = Accounts.create_address(@valid_attrs)
    #   assert address.street_name == @valid_attrs.street_name
    #   assert address.house_number == @valid_attrs.house_number
    #   assert address.zip_code == @valid_attrs.zip_code
    #   assert address.city == @valid_attrs.city
    #   assert address.customer_id == @valid_attrs.customer_id
    # end

    # test "create_address/1 with invalid data returns error changeset" do
    #   assert {:error, %Ecto.Changeset{}} = Accounts.create_address(@invalid_attrs)
    # end
  end
end
