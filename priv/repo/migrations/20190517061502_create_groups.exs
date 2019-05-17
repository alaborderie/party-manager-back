defmodule PartyManagerBack.Repo.Migrations.CreateGroups do
  use Ecto.Migration

  def change do
    create table(:groups) do
      add :name, :string
      add :description, :text
      add :background_img, :string

      timestamps()
    end

  end
end
