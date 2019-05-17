defmodule PartyManagerBack.Repo.Migrations.CreateEventsUsers do
  use Ecto.Migration

  def change do
    create table(:events_users) do
      add :is_going, :boolean, default: false, null: false
      add :user, references(:users, on_delete: :nothing)
      add :event, references(:events, on_delete: :nothing)

      timestamps()
    end

    create index(:events_users, [:user])
    create index(:events_users, [:event])
  end
end
