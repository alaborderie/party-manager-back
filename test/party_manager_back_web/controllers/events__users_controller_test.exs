defmodule PartyManagerBackWeb.EventsUsersControllerTest do
  use PartyManagerBackWeb.ConnCase

  alias PartyManagerBack.Party
  alias PartyManagerBack.Party.EventsUsers

  @create_attrs %{
    is_going: true
  }
  @update_attrs %{
    is_going: false
  }
  @invalid_attrs %{is_going: nil}

  def fixture(:events_users) do
    {:ok, events_users} = Party.create_events_users(@create_attrs)
    events_users
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all events_users", %{conn: conn} do
      conn = get(conn, Routes.events_users_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create events_users" do
    test "renders events_users when data is valid", %{conn: conn} do
      conn = post(conn, Routes.events_users_path(conn, :create), events_users: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.events_users_path(conn, :show, id))

      assert %{
               "id" => id,
               "is_going" => true
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.events_users_path(conn, :create), events_users: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update events_users" do
    setup [:create_events_users]

    test "renders events_users when data is valid", %{conn: conn, events_users: %EventsUsers{id: id} = events_users} do
      conn = put(conn, Routes.events_users_path(conn, :update, events_users), events_users: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.events_users_path(conn, :show, id))

      assert %{
               "id" => id,
               "is_going" => false
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, events_users: events_users} do
      conn = put(conn, Routes.events_users_path(conn, :update, events_users), events_users: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete events_users" do
    setup [:create_events_users]

    test "deletes chosen events_users", %{conn: conn, events_users: events_users} do
      conn = delete(conn, Routes.events_users_path(conn, :delete, events_users))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.events_users_path(conn, :show, events_users))
      end
    end
  end

  defp create_events_users(_) do
    events_users = fixture(:events_users)
    {:ok, events_users: events_users}
  end
end
