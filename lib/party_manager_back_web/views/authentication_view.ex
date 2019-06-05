defmodule PartyManagerBackWeb.AuthenticationView do
  use PartyManagerBackWeb, :view

  def render("sign_in.json", %{user: user, jwt: jwt}) do
    %{
      status: :ok,
      data: %{
        token: jwt,
        user_id: user.id
      }
    }
  end
end
