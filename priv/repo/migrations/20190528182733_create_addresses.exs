defmodule WebshopGraphqlApi.Repo.Migrations.CreateAddresses do
  use Ecto.Migration

  def change do
    create table(:adresses) do
      add :street_name, :string
      add :house_number, :string
      add :zip_code, :string
      add :city, :string
      add :default, :boolean
      add :customer_id, references(:customers)

      timestamps()
    end
  end
end
