# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     WebshopGraphqlApi.Repo.insert!(%WebshopGraphqlApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias WebshopGraphqlApi.Repo
alias WebshopGraphqlApi.Accounts.{Employee, Customer, Address}

#
# CUSTOMERS
#

tijmen =
  %Customer{}
  |> Customer.changeset(%{
    first_name: "Tijmen",
    last_name: "de Graaff",
    email: "tijmen@example.com",
    phone_number: "06544455511",
    password: "password12345",
    password_confirmation: "password12345"
  })
  |> Repo.insert!()

merel =
  %Customer{}
  |> Customer.changeset(%{
    first_name: "Merel",
    last_name: "de Graaff",
    email: "merel@example.com",
    password: "password12345",
    password_confirmation: "password12345"
  })
  |> Repo.insert!()

floortje =
  %Customer{}
  |> Customer.changeset(%{
    first_name: "Floortje",
    last_name: "de Graaff",
    email: "floortje@example.com",
    password: "password12345",
    password_confirmation: "password12345"
  })
  |> Repo.insert!()

#
# EMPLOYEES
#

admin_tijmen =
  %Employee{}
  |> Employee.changeset(%{
    first_name: "Tijmen",
    last_name: "de Graaff",
    email: "tijmen@tijmen.com",
    phone_number: "06544455511",
    password: "password12345",
    password_confirmation: "password12345",
    role: "admin"
  })
  |> Repo.insert!()

#
# CUSTOMER ADDRESS
#

%Address{
  street_name: "SomeStreet",
  house_number: "199-2",
  zip_code: "1088LP",
  city: "Amsterdam",
  default: true,
  customer: tijmen
}
|> Repo.insert!()
