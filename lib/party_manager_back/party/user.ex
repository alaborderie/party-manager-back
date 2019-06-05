defmodule PartyManagerBack.Party.User do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  alias Comeonin.Bcrypt

  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :email, :string, unique: true, null: false
    field :password, :string, null: false
    field :is_admin, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :email, :password])
    |> unique_constraint(:email)
    |> validate_required([:first_name, :last_name, :email, :password])
    |> update_change(:password, &Bcrypt.hashpwsalt/1)
  end
end
