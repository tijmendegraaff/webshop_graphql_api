defmodule WebshopGraphqlApiWeb.Schema.Types.EmployeeSessionType do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: WebshopGraphqlApi.Repo

  object :employee_session_type do
    field(:token, :string)
    field(:employee, :employee_type)
  end

  input_object :employee_session_input_type do
    field(:email, non_null(:string))
    field(:password, non_null(:string))
  end
end
