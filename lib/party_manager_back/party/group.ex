defmodule PartyManagerBack.Party.Group do
  use Ecto.Schema
  import Ecto.Changeset

  schema "groups" do
    field :background_img, :string
    field :description, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(group, attrs) do
    group
    |> cast(attrs, [:name, :description, :background_img])
    |> validate_required([:name, :description, :background_img])
  end
end
