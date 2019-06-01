defmodule WebshopGraphqlApi.Factory do
  use ExMachina.Ecto, repo: WebshopGraphqlApi.Repo
  alias WebshopGraphqlApi.Accounts.{Employee, Customer, Address}

  def employee_factory do
    %Employee{
      first_name: "Jane",
      last_name: "Smith",
      email: sequence(:email, &"email-#{&1}@example.com"),
      phone_number: "88844455566",
      password: "secret1234",
      password_confirmation: "secret1234",
      password_hash: Argon2.hash_pwd_salt("secret1234"),
      role: "intern"
    }
  end

  def make_admin(employee) do
    %{employee | role: "admin"}
  end

  def customer_factory do
    %Customer{
      first_name: "Jane",
      last_name: "Smith",
      email: sequence(:email, &"email-#{&1}@example.com"),
      password: "secret1234",
      password_confirmation: "secret1234",
      password_hash: Argon2.hash_pwd_salt("secret1234")
    }
  end

  def customer_address_factory do
    %Address{
      street_name: "Somestreet",
      house_number: "199-2",
      zip_code: "1079AR",
      city: "Amsterdam",
      customer: build(:customer)
    }
  end
end
