defmodule PartyManagerBackWeb.GroupUserView do
  use PartyManagerBackWeb, :view
  alias PartyManagerBackWeb.GroupUserView

  def render("index.json", %{groups_users: groups_users}) do
    %{data: render_many(groups_users, GroupUserView, "group_user.json")}
  end

  def render("show.json", %{group_user: group_user}) do
    %{data: render_one(group_user, GroupUserView, "group_user.json")}
  end

  def render("group_user.json", %{group_user: group_user}) do
    %{id: group_user.id, group: group_user.group, user: group_user.user}
  end
end
