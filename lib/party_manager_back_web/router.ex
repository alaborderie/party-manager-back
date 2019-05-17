defmodule PartyManagerBackWeb.Router do
  use PartyManagerBackWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PartyManagerBackWeb do
    pipe_through :api
  end

  pipeline :browser do
    plug(:accepts, ["html"])
  end

  scope "/", PartyManagerBackWeb do
    pipe_through :browser
    get "/", DefaultController, :index
  end

  resources "/users", PartyManagerBackWeb.UserController, except: [:new, :edit]
  resources "/groups", PartyManagerBackWeb.GroupController, except: [:new, :edit]
end
