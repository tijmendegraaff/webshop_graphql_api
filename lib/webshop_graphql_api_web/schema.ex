defmodule WebshopGraphqlApiWeb.Schema do
  use Absinthe.Schema

  alias WebshopGraphqlApi.{Repo, Accounts}
  alias WebshopGraphqlApiWeb.Resolvers
  alias WebshopGraphqlApiWeb.Schema.Middleware

  import_types(WebshopGraphqlApiWeb.Schema.Types)

  def middleware(middleware, _field, %{identifier: :mutation}) do
    middleware ++ [Middleware.ChangesetErrors]
  end

  def middleware(middleware, _field, _object), do: middleware

  #
  # Add dataloader to middleware
  #
  def context(ctx) do
    source = Dataloader.Ecto.new(Repo)

    loader =
      Dataloader.new()
      |> Dataloader.add_source(Accounts, source)

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end

  #
  #
  #

  query do
    @desc "Return all customers"
    field :customers, list_of(:customer_type) do
      middleware(Middleware.Authorize, :intern)
      resolve(&Resolvers.CustomerResolver.customers/3)
    end

    @desc "Return all employees"
    field :employees, list_of(:employee_type) do
      middleware(Middleware.Authorize, :intern)
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
      middleware(Middleware.Authorize, :admin)
      resolve(&Resolvers.EmployeeResolver.create_employee/3)
    end

    @desc "Login a customer"
    field :create_customer_session, :customer_session_type do
      arg(:input, non_null(:customer_session_input_type))
      resolve(&Resolvers.CustomerResolver.create_customer_session/3)
    end

    @desc "Login a employee"
    field :create_employee_session, :employee_session_type do
      arg(:input, non_null(:employee_session_input_type))
      resolve(&Resolvers.EmployeeResolver.create_employee_session/3)
    end

    @desc "Add an adress for a customer"
    field :create_customer_address, :customer_address_type do
      arg(:input, non_null(:customer_address_input_type))
      middleware(Middleware.Authorize, :any)
      resolve(&Resolvers.CustomerResolver.create_customer_address/3)
    end
  end
end
