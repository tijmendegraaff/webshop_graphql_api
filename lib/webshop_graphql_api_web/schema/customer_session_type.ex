defmodule WebshopGraphqlApiWeb.Schema.Types.CustomerSessionType do
  use Absinthe.Schema.Notation

  object :customer_session_type do
    field(:token, :string)
    field(:customer, :customer_type)
  end

  input_object :customer_session_input_type do
    field(:email, non_null(:string))
    field(:password, non_null(:string))
  end
end
