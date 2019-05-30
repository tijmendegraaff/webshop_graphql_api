defmodule WebshopGraphqlApi.Repo.Migrations.CreateAddresses do
  use Ecto.Migration

  def change do
    create table(:adresses) do
      add :street_name, :string, null: false
      add :house_number, :string, null: false
      add :zip_code, :string, null: false
      add :city, :string, null: false
      add :default, :boolean, null: false
      add :customer_id, references(:customers), null: false

      timestamps()
    end

    create index(:adresses, [:customer_id])
  end
end
