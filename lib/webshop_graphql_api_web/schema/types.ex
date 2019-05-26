defmodule WebshopGraphqlApiWeb.Schema.Types do
  use Absinthe.Schema.Notation

  alias WebshopGraphqlApiWeb.Schema.Types

  # import your types
  import_types(Types.CustomerType)
  import_types(Types.EmployeeType)
end
