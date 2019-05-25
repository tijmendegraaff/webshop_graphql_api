defmodule WebshopGraphqlApi.Accounts.Customer do
  use Ecto.Schema
  import Ecto.Changeset

  alias WebshopGraphqlApi.Validators.EmailValidator

  schema "customers" do
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :password_hash, :string
    field :phone_number, :string

    timestamps()
  end

  @doc false
  def changeset(customer, attrs) do
    customer
    |> cast(attrs, [
      :first_name,
      :last_name,
      :email,
      :phone_number,
      :password
    ])
    |> validate_required([
      :first_name,
      :last_name,
      :email,
      :phone_number,
      :password
    ])
    |> EmailValidator.validate_email(:email)
    |> update_change(:email, &String.downcase(&1))
    |> validate_length(:password, min: 6, max: 100)
    |> validate_confirmation(:password, message: "passwords don't match")
    |> unique_constraint(:email)
  end
end
