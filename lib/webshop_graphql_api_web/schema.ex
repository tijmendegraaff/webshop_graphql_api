defmodule WebshopGraphqlApiWeb.Schema do
  use Absinthe.Schema

  alias WebshopGraphqlApiWeb.Resolvers

  import_types(WebshopGraphqlApiWeb.Schema.Types)

  query do
    @desc "Return all customers"
    field :customers, list_of(:customer_type) do
      resolve(&Resolvers.CustomerResolver.customers/3)
    end
  end
end
