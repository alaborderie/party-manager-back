defmodule PartyManagerBackWeb.Router do
  use PartyManagerBackWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PartyManagerBackWeb do
    pipe_through :api
  end
end
