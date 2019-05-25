defmodule WebshopGraphqlApi.Accounts.Customer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "customers" do
    field :email, :string
    field :first_name, :string
    field :last_name, :string
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
      :password_hash
    ])
    |> validate_required([
      :first_name,
      :last_name,
      :email,
      :phone_number,
      :password_hash
    ])
  end
end
