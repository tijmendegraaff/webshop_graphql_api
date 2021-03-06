defmodule WebshopGraphqlApi.Repo.Migrations.CreateCustomers do
  use Ecto.Migration

  def change do
    create table(:customers) do
      add :first_name, :string, null: false
      add :last_name, :string, null: false
      add :email, :string, null: false
      add :phone_number, :string
      add :password_hash, :string, null: false

      timestamps()
    end

    create unique_index(:customers, [:email])
  end
end
