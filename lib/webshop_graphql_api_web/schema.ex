defmodule WebshopGraphqlApiWeb.Schema do
  use Absinthe.Schema

  alias WebshopGraphqlApiWeb.Resolvers

  import_types(WebshopGraphqlApiWeb.Schema.Types)

  query do
    @desc "Return all customers"
    field :customers, list_of(:customer_type) do
      resolve(&Resolvers.CustomerResolver.customers/3)
    end

    @desc "Return all employees"
    field :employees, list_of(:employee_type) do
      resolve(&Resolvers.EmployeeResolver.employees/3)
    end
  end

  mutation do
    @desc "Create a new customer"
    field :create_customer, :customer_type do
      arg(:input, non_null(:customer_input_type))
      resolve(&Resolvers.CustomerResolver.create_customer/3)
    end

    @desc "Create a new employee"
    field :create_employee, :employee_type do
      arg(:input, non_null(:employee_input_type))
      resolve(&Resolvers.EmployeeResolver.create_employee/3)
    end

    @desc "Login a customer"
    field :create_customer_session, :customer_session_type do
      arg(:input, non_null(:customer_session_input_type))
      resolve(&Resolvers.SessionResolver.create_customer_session/3)
    end
  end
end
