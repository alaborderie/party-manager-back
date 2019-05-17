defmodule PartyManagerBackWeb.Events_UsersController do
  use PartyManagerBackWeb, :controller

  alias PartyManagerBack.Party
  alias PartyManagerBack.Party.Events_Users

  action_fallback PartyManagerBackWeb.FallbackController

  def index(conn, _params) do
    events_users = Party.list_events_users()
    render(conn, "index.json", events_users: events_users)
  end

  def create(conn, %{"events__users" => events__users_params}) do
    with {:ok, %Events_Users{} = events__users} <- Party.create_events__users(events__users_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.events__users_path(conn, :show, events__users))
      |> render("show.json", events__users: events__users)
    end
  end

  def show(conn, %{"id" => id}) do
    events__users = Party.get_events__users!(id)
    render(conn, "show.json", events__users: events__users)
  end

  def update(conn, %{"id" => id, "events__users" => events__users_params}) do
    events__users = Party.get_events__users!(id)

    with {:ok, %Events_Users{} = events__users} <- Party.update_events__users(events__users, events__users_params) do
      render(conn, "show.json", events__users: events__users)
    end
  end

  def delete(conn, %{"id" => id}) do
    events__users = Party.get_events__users!(id)

    with {:ok, %Events_Users{}} <- Party.delete_events__users(events__users) do
      send_resp(conn, :no_content, "")
    end
  end
end
