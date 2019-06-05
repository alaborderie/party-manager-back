defmodule PartyManagerBackWeb.EventsUsersView do
  use PartyManagerBackWeb, :view
  alias PartyManagerBackWeb.EventsUsersView

  def render("index.json", %{events_users: events_users}) do
    %{data: render_many(events_users, EventsUsersView, "events_users.json")}
  end

  def render("show.json", %{events_users: events_users}) do
    %{data: render_one(events_users, EventsUsersView, "events_users.json")}
  end

  def render("events_users.json", %{events_users: events_users}) do
    %{id: events_users.id,
      is_going: events_users.is_going}
  end
end
