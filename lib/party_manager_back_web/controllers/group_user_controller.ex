defmodule PartyManagerBackWeb.GroupUserController do
  use PartyManagerBackWeb, :controller

  alias PartyManagerBack.Party
  alias PartyManagerBack.Party.GroupUser

  action_fallback PartyManagerBackWeb.FallbackController

  def index(conn, _params) do
    groups_users = Party.list_groups_users()
    render(conn, "index.json", groups_users: groups_users)
  end

  def create(conn, %{"group_user" => group_user_params}) do
    with {:ok, %GroupUser{} = group_user} <- Party.create_group_user(group_user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.group_user_path(conn, :show, group_user))
      |> render("show.json", group_user: group_user)
    end
  end

  def show(conn, %{"id" => id}) do
    group_user = Party.get_group_user!(id)
    render(conn, "show.json", group_user: group_user)
  end

  def update(conn, %{"id" => id, "group_user" => group_user_params}) do
    group_user = Party.get_group_user!(id)

    with {:ok, %GroupUser{} = group_user} <-
           Party.update_group_user(group_user, group_user_params) do
      render(conn, "show.json", group_user: group_user)
    end
  end

  def delete(conn, %{"id" => id}) do
    group_user = Party.get_group_user!(id)

    with {:ok, %GroupUser{}} <- Party.delete_group_user(group_user) do
      send_resp(conn, :no_content, "")
    end
  end
end
