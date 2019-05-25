defmodule WebshopGraphqlApi.Repo.Migrations.CreateEmployees do
  use Ecto.Migration

  def change do
    create table(:employees) do
      add :first_name, :string
      add :last_name, :string
      add :email, :string
      add :date_of_birth, :naive_datetime
      add :phone_number, :string
      add :password_hash, :string
      add :role, :string

      timestamps()
    end

  end
end
