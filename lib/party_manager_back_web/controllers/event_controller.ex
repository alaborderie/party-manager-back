defmodule PartyManagerBackWeb.EventController do
  use PartyManagerBackWeb, :controller

  alias PartyManagerBack.Party
  alias PartyManagerBack.Party.Event
  use HTTPoison.Base

  action_fallback PartyManagerBackWeb.FallbackController

  def index(conn, _params) do
    events = Party.list_events()
    render(conn, "index.json", events: events)
  end

  def create(conn, %{"event" => event_params, "tmdb" => tmdb_params}) do
    background_url =
      if !!tmdb_params do
        url =
          "https://api.themoviedb.org/3/search/movie?api_key=341cc10a4e7d1530cf23d11cee7b9720&language=fr_fr&page=17include_adult=true&query=" <>
            tmdb_params["movie"]

        response = HTTPoison.get!(url)
        req = Jason.decode!(response.body)

        if !req["error"] do
          poster_path = Enum.at(req["results"], 0)["poster_path"]
          "https://image.tmdb.org/t/p/w500" <> poster_path
        end
      end

    event_params_updated = Map.put(event_params, "background_img", background_url)

    with {:ok, %Event{} = event} <- Party.create_event(event_params_updated) do
      Party.send_emails(event)

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
