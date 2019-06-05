defmodule PartyManagerBack.Party.EventsUsers do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  schema "events_users" do
    field :is_going, :boolean, default: false
    field :user, :id
    field :event, :id

    timestamps()
  end

  @doc false
  def changeset(events_users, attrs) do
    events_users
    |> cast(attrs, [:is_going])
    |> validate_required([:is_going])
  end
end
