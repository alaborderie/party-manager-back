defmodule PartyManagerBackWeb.EventView do
  use PartyManagerBackWeb, :view
  alias PartyManagerBackWeb.EventView

  def render("index.json", %{events: events}) do
    %{data: render_many(events, EventView, "event.json")}
  end

  def render("show.json", %{event: event}) do
    %{data: render_one(event, EventView, "event.json")}
  end

  def render("event.json", %{event: event}) do
    %{id: event.id,
      name: event.name,
      description: event.description,
      background_img: event.background_img,
      start_date: event.start_date,
      end_date: event.end_date,
      place: event.place}
  end
end
