defmodule WebshopGraphqlApiWeb.Schema.Types.CustomerAddressType do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers, only: [dataloader: 1, dataloader: 3]

  alias WebshopGraphqlApi.Accounts

  object :customer_address_type do
    field(:street_name, :string)
    field(:house_number, :string)
    field(:zip_code, :string)
    field(:city, :string)
    field(:default, :boolean)
    field :customer, :customer_type, resolve: dataloader(Accounts)
  end

  input_object :customer_address_input_type do
    field(:street_name, non_null(:string))
    field(:house_number, non_null(:string))
    field(:zip_code, non_null(:string))
    field(:city, non_null(:string))
    field(:default, :boolean)
  end
end
