defmodule PartyManagerBackWeb.AuthenticationController do
  use PartyManagerBackWeb, :controller

  alias PartyManagerBack.Party
  alias PartyManagerBack.Guardian

  action_fallback PartyManagerBackWeb.FallbackController

  def create(conn, %{"session" => sessions_params}) do
    user = Party.get_by_email(sessions_params["email"])
    if Comeonin.Bcrypt.checkpw(sessions_params["password"], user.password) do
      {:ok, jwt, _full_claims} = Guardian.encode_and_sign(user)
      conn
      |> render("sign_in.json", %{user: user, jwt: jwt})
    else
      conn
      |> put_status(401)
      |> text("Wrong password/email combination")
    end
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:current_user_id)
    |> send_resp(:no_content, "")
  end

end
