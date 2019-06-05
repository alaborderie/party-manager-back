defmodule PartyManagerBackWeb.Router do
  use PartyManagerBackWeb, :router

  pipeline :api do
    plug :accepts, ["json"]

    plug Guardian.Plug.Pipeline,
      module: PartyManagerBack.Guardian,
      error_handler: PartyManagerBack.AuthErrorHandler

    plug Guardian.Plug.VerifyHeader
    plug Guardian.Plug.LoadResource, allow_blank: true
  end

  pipeline :authenticated do
    plug Guardian.Plug.EnsureAuthenticated
  end

  scope "/api", PartyManagerBackWeb do
    pipe_through :api
    resources "/subscribe", UserController, only: [:create]
    resources "/login", AuthenticationController, only: [:create, :delete]
    if System.get_env("PARTY_MANAGER_PROD"), do: pipe_through(:authenticated)
    resources "/users", UserController, except: [:new, :edit, :create]
    resources "/groups", GroupController, except: [:new, :edit, :delete]
    resources "/events", EventController, except: [:new, :edit]
    resources "/events_users", EventsUsersController, except: [:new, :edit]
  end

  pipeline :browser do
    plug(:accepts, ["html"])
  end

  scope "/", PartyManagerBackWeb do
    pipe_through :browser
    get "/", DefaultController, :index
  end
end
