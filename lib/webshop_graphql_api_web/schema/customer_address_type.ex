defmodule WebshopGraphqlApiWeb.Schema.Types.CustomerAddressType do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: WebshopGraphqlApi.Repo

  object :customer_address_type do
    field(:street_name, :string)
    field(:house_number, :string)
    field(:zip_code, :string)
    field(:city, :string)
    field(:default, :boolean)
    field :customer, :customer_type, resolve: assoc(:customer)
  end

  input_object :customer_address_input_type do
    field(:street_name, non_null(:string))
    field(:house_number, non_null(:string))
    field(:zip_code, non_null(:string))
    field(:city, non_null(:string))
    field(:default, :boolean)
  end
end
