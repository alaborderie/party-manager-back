defmodule PartyManagerBack.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :name, :string
      add :description, :text
      add :background_img, :string
      add :start_date, :date
      add :end_date, :date
      add :place, :string
      add :group, references(:groups, on_delete: :nothing)
      add :creator, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:events, [:group])
  end
end
