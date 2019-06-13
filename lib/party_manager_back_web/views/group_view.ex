defmodule PartyManagerBackWeb.GroupView do
  use PartyManagerBackWeb, :view
  alias PartyManagerBackWeb.GroupView

  def render("index.json", %{groups: groups}) do
    %{data: render_many(groups, GroupView, "group.json")}
  end

  def render("show.json", %{group: group}) do
    %{data: render_one(group, GroupView, "group.json")}
  end

  def render("group.json", %{group: group}) do
    %{
      id: group.id,
      name: group.name,
      description: group.description,
      background_img: group.background_img,
      events:
        Enum.map(
          group.events,
          fn event ->
            %{
              id: event.id,
              name: event.name,
              description: event.description,
              background_img: event.background_img,
              start_date: event.start_date,
              end_date: event.end_date,
              place: event.place
            }
          end
        )
    }
  end
end
