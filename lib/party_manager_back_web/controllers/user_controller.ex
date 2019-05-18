defmodule PartyManagerBackWeb.UserController do
  use PartyManagerBackWeb, :controller

  alias PartyManagerBack.Party
  alias PartyManagerBack.Party.User

  action_fallback PartyManagerBackWeb.FallbackController

  @apidoc """
  @api {get} /users Get list of users
  @apiName GetUsers
  @apiGroup Users

  @apiSuccess {Object[]} data Data of response (Array of users)
  @apiSuccess {String} data.first_name First name of user
  @apiSuccess {String} data.last_name Last name of user
  @apiSuccess {String} data.email Email of user
  """
  def index(conn, _params) do
    users = Party.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Party.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Party.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Party.get_user!(id)

    with {:ok, %User{} = user} <- Party.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Party.get_user!(id)

    with {:ok, %User{}} <- Party.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
