defmodule WebshopGraphqlApi.Repo.Migrations.CreateCustomers do
  use Ecto.Migration

  def change do
    create table(:customers) do
      add :first_name, :string
      add :last_name, :string
      add :email, :string
      add :date_of_birth, :naive_datetime
      add :phone_number, :string
      add :password_hash, :string

      timestamps()
    end

  end
end
