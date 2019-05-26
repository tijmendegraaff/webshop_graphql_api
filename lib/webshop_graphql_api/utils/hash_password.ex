defmodule WebshopGraphqlApi.Utils.HashPassword do
  import Ecto.Changeset

  def hash_password(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Argon2.add_hash(password))
    |> delete_change(:password_confirmation)
  end

  def hash_password(changeset) do
    changeset
  end
end
