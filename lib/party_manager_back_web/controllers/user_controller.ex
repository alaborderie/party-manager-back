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
      |> json(%{message: "Admin role is required"})
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
    emailRegex = ~r/^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\x{00A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\x{00A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\x{00A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\x{00A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\x{00A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}])|(([a-z]|\d|[\x{00A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}])([a-z]|\d|-|\.|_|~|[\x{00A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}])*([a-z]|\d|[\x{00A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}])))\.)+(([a-z]|[\x{00A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}])|(([a-z]|[\x{00A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}])([a-z]|\d|-|\.|_|~|[\x{00A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}])*([a-z]|[\x{00A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}])))$/u
    response =
      cond do
        !Regex.match?(emailRegex, user_params["email"]) ->
          conn
          |> put_status(:bad_request)
          |> json(%{message: "Bad email format", error_field: "email"})
        !Party.get_by_email(user_params["email"]) ->
          conn
          |> put_status(:conflict)
          |> json(%{message: "User email #{user_params["email"]} already exists", error_field: "email"})
        true -> nil
      end
    unless response do
      with {:ok, %User{} = user} <- Party.create_user(user_params) do
        conn
        |> put_status(:created)
        |> put_resp_header("location", Routes.user_path(conn, :show, user))
        |> render("show.json", user: user)
      end
    else
      response
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
      |> json(%{message: "You are not authorized to do that."})
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
      |> json(%{message: "You are not authorized to do that."})
    end
  end
end
