defmodule WebshopGraphqlApiWeb.Schema.Types.CustomerType do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers, only: [dataloader: 1, dataloader: 3]

  alias WebshopGraphqlApi.Accounts

  object :customer_type do
    field(:id, :id)
    field(:first_name, :string)
    field(:last_name, :string)
    field(:email, :string)
    field(:phone_number, :string)
    field :addresses, list_of(:customer_address_type), resolve: dataloader(Accounts)
  end

  input_object :customer_input_type do
    field(:first_name, non_null(:string))
    field(:last_name, non_null(:string))
    field(:email, non_null(:string))
    field(:phone_number, :string)
    field(:password, non_null(:string))
    field(:password_confirmation, non_null(:string))
  end
end
