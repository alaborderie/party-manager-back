defmodule PartyManagerBack.Party.GroupUser do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  schema "groups_users" do
    field :group, :id
    field :user, :id

    timestamps()
  end

  @doc false
  def changeset(group_user, attrs) do
    group_user
    |> cast(attrs, [:group, :user])
    |> validate_required([:group, :user])
  end
end
