defmodule PartyManagerBackWeb.Events_UsersControllerTest do
  use PartyManagerBackWeb.ConnCase

  alias PartyManagerBack.Party
  alias PartyManagerBack.Party.Events_Users

  @create_attrs %{
    is_going: true
  }
  @update_attrs %{
    is_going: false
  }
  @invalid_attrs %{is_going: nil}

  def fixture(:events__users) do
    {:ok, events__users} = Party.create_events__users(@create_attrs)
    events__users
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all events_users", %{conn: conn} do
      conn = get(conn, Routes.events__users_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create events__users" do
    test "renders events__users when data is valid", %{conn: conn} do
      conn = post(conn, Routes.events__users_path(conn, :create), events__users: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.events__users_path(conn, :show, id))

      assert %{
               "id" => id,
               "is_going" => true
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.events__users_path(conn, :create), events__users: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update events__users" do
    setup [:create_events__users]

    test "renders events__users when data is valid", %{conn: conn, events__users: %Events_Users{id: id} = events__users} do
      conn = put(conn, Routes.events__users_path(conn, :update, events__users), events__users: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.events__users_path(conn, :show, id))

      assert %{
               "id" => id,
               "is_going" => false
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, events__users: events__users} do
      conn = put(conn, Routes.events__users_path(conn, :update, events__users), events__users: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete events__users" do
    setup [:create_events__users]

    test "deletes chosen events__users", %{conn: conn, events__users: events__users} do
      conn = delete(conn, Routes.events__users_path(conn, :delete, events__users))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.events__users_path(conn, :show, events__users))
      end
    end
  end

  defp create_events__users(_) do
    events__users = fixture(:events__users)
    {:ok, events__users: events__users}
  end
end
