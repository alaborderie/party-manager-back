defmodule PartyManagerBackWeb.Events_UsersView do
  use PartyManagerBackWeb, :view
  alias PartyManagerBackWeb.Events_UsersView

  def render("index.json", %{events_users: events_users}) do
    %{data: render_many(events_users, Events_UsersView, "events__users.json")}
  end

  def render("show.json", %{events__users: events__users}) do
    %{data: render_one(events__users, Events_UsersView, "events__users.json")}
  end

  def render("events__users.json", %{events__users: events__users}) do
    %{id: events__users.id,
      is_going: events__users.is_going}
  end
end
