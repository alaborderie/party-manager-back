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
    requesting_user = PartyManagerBack.Guardian.Plug.current_resource(conn)
    if requesting_user.is_admin do
      users = Party.list_users()
      render(conn, "index.json", users: users)
    else
      conn
      |> put_status(401)
      |> text("Admin role is required")
    end
  end

  @apidoc """
  @api {post} /users/:id Create a new user
  @apiName CreateUser
  @apiGroup Users

  @apiParam {Object} user User to be created
  @apiParam {String} user.first_name First name of user to create
  @apiParam {String} user.last_name Last name of user to create
  @apiParam {String} user.email Email of user to create
  @apiParam {String} user.password Password of user

  @apiSuccess {Object} data Data of response (Created user)
  @apiSuccess {String} data.first_name First name of user
  @apiSuccess {String} data.last_name Last name of user
  @apiSuccess {String} data.email Email of user
  """
  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Party.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  @apidoc """
  @api {get} /users/:id Get user with given id
  @apiName GetUser
  @apiGroup Users

  @apiSuccess {Object} data Data of response (User that has id == given id)
  @apiSuccess {String} data.first_name First name of user
  @apiSuccess {String} data.last_name Last name of user
  @apiSuccess {String} data.email Email of user
  """
  def show(conn, %{"id" => id}) do
    user = Party.get_user!(id)
    render(conn, "show.json", user: user)
  end

  @apidoc """
  @api {put} /users/:id Update an existing user
  @apiName UpdateUser
  @apiGroup Users

  @apiParam {Object} user User to update
  @apiParam {String} user.first_name First name of user to update
  @apiParam {String} user.last_name Last name of user to update
  @apiParam {String} user.email Email of user to update

  @apiSuccess {Object} data Data of response (Updated user)
  @apiSuccess {String} data.first_name First name of user
  @apiSuccess {String} data.last_name Last name of user
  @apiSuccess {String} data.email Email of user
  """
  def update(conn, %{"id" => id, "user" => user_params}) do
    requesting_user = PartyManagerBack.Guardian.Plug.current_resource(conn)
    if requesting_user.is_admin or requesting_user.id == id do
      user = Party.get_user!(id)

      with {:ok, %User{} = user} <- Party.update_user(user, user_params) do
        render(conn, "show.json", user: user)
      end
    else
      conn
      |> put_status(401)
      |> text("You are not authorized to do that.")
    end
  end

  @apidoc """
  @api {delete} /users/:id Delete an existing user
  @apiName DeleteUser
  @apiGroup Users
  """
  def delete(conn, %{"id" => id}) do
    requesting_user = PartyManagerBack.Guardian.Plug.current_resource(conn)
    if requesting_user.is_admin or requesting_user.id == id do
      user = Party.get_user!(id)

      with {:ok, %User{}} <- Party.delete_user(user) do
        send_resp(conn, :no_content, "")
      end
    else
      conn
      |> put_status(401)
      |> text("You are not authorized to do that.")
    end
  end
end
