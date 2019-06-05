defmodule PartyManagerBack.Party.Event do
  @moduledoc false
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
    field :creator, :id

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [
      :name,
      :description,
      :background_img,
      :start_date,
      :end_date,
      :place,
      :group,
      :creator
    ])
    |> validate_required([:name, :description, :start_date, :end_date])
  end
end
