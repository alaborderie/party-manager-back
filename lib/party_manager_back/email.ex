defmodule PartyManagerBack.Email do
  @moduledoc false
  use Bamboo.Phoenix, view: PartyManagerBackWeb.EmailView

  def send_email(user, group) do
    base_email
    |> to(user.email)
    |> subject("Event created!")
    |> assign(:user, user.first_name <> " " <> user.last_name)
    |> assign(:group, group.name)
    |> render(:new_event)
  end

  def base_email do
    new_email
    |> from("Antoine Laborderie<antoine.laborderie@gmail.com>")
    |> put_html_layout({PartyManagerBackWeb.LayoutView, "email.html"})
  end
end
