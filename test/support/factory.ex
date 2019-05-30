defmodule WebshopGraphqlApi.Factory do
  use ExMachina.Ecto, repo: WebshopGraphqlApi.Repo
  alias WebshopGraphqlApi.Accounts.{Employee, Customer}

  def employee_factory do
    %Employee{
      first_name: "Jane",
      last_name: "Smith",
      email: sequence(:email, &"email-#{&1}@example.com"),
      phone_number: "88844455566",
      password: "secret1234",
      password_confirmation: "secret1234",
      password_hash: Argon2.hash_pwd_salt("secret1234"),
      role: sequence(:role, ["admin", "intern"])
    }
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
end
