defmodule PartyManagerBackWeb.GroupController do
  use PartyManagerBackWeb, :controller

  alias PartyManagerBack.Party
  alias PartyManagerBack.Party.Group

  action_fallback(PartyManagerBackWeb.FallbackController)

  def index(conn, _params) do
    groups = Party.list_groups()
    render(conn, "index.json", groups: groups)
  end

  def create(conn, %{"group" => group_params}) do
    with {:ok, %Group{} = group} <- Party.create_group(group_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.group_path(conn, :show, group))
      |> render("show.json", group: group)
    end
  end

  def show(conn, %{"id" => id}) do
    group = Party.get_group!(id)
    events = Party.list_events_for_group(group.id)
    result = Map.put(group, :events, events)
    render(conn, "show.json", group: result)
  end

  def update(conn, %{"id" => id, "group" => group_params}) do
    group = Party.get_group!(id)

    with {:ok, %Group{} = group} <- Party.update_group(group, group_params) do
      render(conn, "show.json", group: group)
    end
  end

  def delete(conn, %{"id" => id}) do
    group = Party.get_group!(id)

    with {:ok, %Group{}} <- Party.delete_group(group) do
      send_resp(conn, :no_content, "")
    end
  end
end
