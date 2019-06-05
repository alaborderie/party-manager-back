defmodule PartyManagerBackWeb.EventsUsersController do
  use PartyManagerBackWeb, :controller

  alias PartyManagerBack.Party
  alias PartyManagerBack.Party.EventsUsers

  action_fallback PartyManagerBackWeb.FallbackController

  def index(conn, _params) do
    events_users = Party.list_events_users()
    render(conn, "index.json", events_users: events_users)
  end

  def create(conn, %{"events_users" => events_users_params}) do
    with {:ok, %EventsUsers{} = events_users} <- Party.create_events_users(events_users_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.events_users_path(conn, :show, events_users))
      |> render("show.json", events_users: events_users)
    end
  end

  def show(conn, %{"id" => id}) do
    events_users = Party.get_events_users!(id)
    render(conn, "show.json", events_users: events_users)
  end

  def update(conn, %{"id" => id, "events_users" => events_users_params}) do
    events_users = Party.get_events_users!(id)

    with {:ok, %EventsUsers{} = events_users} <-
           Party.update_events_users(events_users, events_users_params) do
      render(conn, "show.json", events_users: events_users)
    end
  end

  def delete(conn, %{"id" => id}) do
    events_users = Party.get_events_users!(id)

    with {:ok, %EventsUsers{}} <- Party.delete_events_users(events_users) do
      send_resp(conn, :no_content, "")
    end
  end
end
