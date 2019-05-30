defmodule WebshopGraphqlApiWeb.Schema.Types.EmployeeType do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: WebshopGraphqlApi.Repo

  object :employee_type do
    field(:id, :id)
    field(:first_name, :string)
    field(:last_name, :string)
    field(:email, :string)
    field(:phone_number, :string)
    field(:role, :string)
  end

  input_object :employee_input_type do
    field(:first_name, non_null(:string))
    field(:last_name, non_null(:string))
    field(:email, non_null(:string))
    field(:phone_number, non_null(:string))
    field(:password, non_null(:string))
    field(:password_confirmation, non_null(:string))
    field(:role, non_null(:string))
  end
end
