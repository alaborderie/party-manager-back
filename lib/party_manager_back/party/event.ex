defmodule PartyManagerBack.Party.Event do
  use Ecto.Schema
  import Ecto.Changeset

  schema "events" do
    field :background_img, :string
    field :description, :string
    field :end_date, :date
    field :name, :string
    field :place, :string
    field :start_date, :date
    field :group, :id

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:name, :description, :background_img, :start_date, :end_date, :place])
    |> validate_required([:name, :description, :background_img, :start_date, :end_date, :place])
  end
end
