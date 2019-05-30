defmodule WebshopGraphqlApi.Accounts.Employee do
  use Ecto.Schema
  import Ecto.Changeset

  alias WebshopGraphqlApi.Validators.EmailValidator
  alias WebshopGraphqlApi.Utils.Password

  schema "employees" do
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
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
      :password,
      :password_confirmation,
      :role
    ])
    |> validate_required([
      :first_name,
      :last_name,
      :email,
      :phone_number,
      :password,
      :password_confirmation,
      :role
    ])
    |> EmailValidator.validate_email(:email)
    |> update_change(:email, &String.downcase(&1))
    |> validate_length(:password, min: 6, max: 100)
    |> validate_confirmation(:password, message: "passwords don't match")
    |> unique_constraint(:email)
    |> Password.hash_password()
  end
end
