defmodule PartyManagerBackWeb.EventController do
  use PartyManagerBackWeb, :controller

  alias PartyManagerBack.Party
  alias PartyManagerBack.Party.Event

  action_fallback PartyManagerBackWeb.FallbackController

  def index(conn, _params) do
    events = Party.list_events()
    render(conn, "index.json", events: events)
  end

  def create(conn, %{"event" => event_params}) do
    with {:ok, %Event{} = event} <- Party.create_event(event_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.event_path(conn, :show, event))
      |> render("show.json", event: event)
    end
  end

  def show(conn, %{"id" => id}) do
    event = Party.get_event!(id)
    render(conn, "show.json", event: event)
  end

  def update(conn, %{"id" => id, "event" => event_params}) do
    event = Party.get_event!(id)

    with {:ok, %Event{} = event} <- Party.update_event(event, event_params) do
      render(conn, "show.json", event: event)
    end
  end

  def delete(conn, %{"id" => id}) do
    event = Party.get_event!(id)

    with {:ok, %Event{}} <- Party.delete_event(event) do
      send_resp(conn, :no_content, "")
    end
  end
end
