defmodule WebshopGraphqlApi.Accounts.Employee do
  use Ecto.Schema
  import Ecto.Changeset

  schema "employees" do
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :password_hash, :string
    field :phone_number, :string
    field :role, :string

    timestamps()
  end

  @doc false
  def changeset(employee, attrs) do
    employee
    |> cast(attrs, [
      :first_name,
      :last_name,
      :email,
      :phone_number,
      :password_hash,
      :role
    ])
    |> validate_required([
      :first_name,
      :last_name,
      :email,
      :phone_number,
      :password_hash,
      :role
    ])
  end
end
