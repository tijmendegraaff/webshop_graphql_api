defmodule WebshopGraphqlApi.Utils.Password do
  import Ecto.Changeset
  alias WebshopGraphqlApi.Accounts.{Customer, Employee}

  def hash_password(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Argon2.add_hash(password))
    |> delete_change(:password_confirmation)
  end

  def hash_password(changeset) do
    changeset
  end

  def check_password(%Customer{password_hash: password_hash}, params) do
    Argon2.verify_pass(params.password, password_hash)
  end

  def check_password(%Employee{password_hash: password_hash}, params) do
    Argon2.verify_pass(params.password, password_hash)
  end

  def check_password(_, _params) do
    false
  end
end
