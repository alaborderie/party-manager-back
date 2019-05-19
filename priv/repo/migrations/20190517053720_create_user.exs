defmodule PartyManagerBack.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :first_name, :string
      add :last_name, :string
      add :email, :string, unique: true, null: false
      add :password, :string, null: false
      add :is_admin, :boolean, default: false

      timestamps()
    end
  end
end
