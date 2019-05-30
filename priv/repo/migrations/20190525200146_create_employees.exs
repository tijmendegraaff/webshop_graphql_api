defmodule WebshopGraphqlApi.Repo.Migrations.CreateEmployees do
  use Ecto.Migration

  def change do
    create table(:employees) do
      add :first_name, :string, null: false
      add :last_name, :string, null: false
      add :email, :string, null: false
      add :phone_number, :string, null: false
      add :password_hash, :string, null: false
      add :role, :string, null: false

      timestamps()
    end

    create unique_index(:employees, [:email])
  end
end
