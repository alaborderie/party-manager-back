defmodule PartyManagerBackWeb.DefaultController do
  use PartyManagerBackWeb, :controller

  def index(conn, _params) do
    text conn, "PartyManager!"
  end

end
