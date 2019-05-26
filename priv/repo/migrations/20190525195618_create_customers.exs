defmodule WebshopGraphqlApi.Repo.Migrations.CreateCustomers do
  use Ecto.Migration

  def change do
    create table(:customers) do
      add :first_name, :string
      add :last_name, :string
      add :email, :string
      add :phone_number, :string
      add :password_hash, :string

      timestamps()
    end

    create unique_index(:customers, [:email])
  end
end
