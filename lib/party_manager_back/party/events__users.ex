defmodule PartyManagerBack.Party.Events_Users do
  use Ecto.Schema
  import Ecto.Changeset

  schema "events_users" do
    field :is_going, :boolean, default: false
    field :user, :id
    field :event, :id

    timestamps()
  end

  @doc false
  def changeset(events__users, attrs) do
    events__users
    |> cast(attrs, [:is_going])
    |> validate_required([:is_going])
  end
end
