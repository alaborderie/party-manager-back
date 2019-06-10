defmodule PartyManagerBack.Repo.Migrations.CreateGroupsUsers do
  use Ecto.Migration

  def change do
    create table(:groups_users) do
      add :user, references(:users, on_delete: :nothing)
      add :group, references(:groups, on_delete: :nothing)

      timestamps()
    end

    create index(:groups_users, [:user])
    create index(:groups_users, [:group])
  end
end
