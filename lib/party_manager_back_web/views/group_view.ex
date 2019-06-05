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
      background_img: group.background_img
    }
  end
end
