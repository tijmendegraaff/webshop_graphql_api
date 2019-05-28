defmodule WebshopGraphqlApi.Accounts.Address do
  use Ecto.Schema
  import Ecto.Changeset

  alias WebshopGraphqlApi.Accounts

  schema "adresses" do
    field :street_name, :string
    field :house_number, :string
    field :zip_code, :string
    field :city, :string
    field :default, :boolean, default: true
    belongs_to :customer, Accounts.Customer

    timestamps()
  end

  @doc false
  def changeset(address, attrs) do
    address
    |> cast(attrs, [
      :street_name,
      :house_number,
      :zip_code,
      :city,
      :default,
      :customer_id
    ])
    |> validate_required([
      :street_name,
      :house_number,
      :zip_code,
      :city,
      :default,
      :customer_id
    ])
  end
end
