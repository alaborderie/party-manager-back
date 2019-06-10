defmodule PartyManagerBackWeb.GroupUserControllerTest do
  use PartyManagerBackWeb.ConnCase

  alias PartyManagerBack.Party
  alias PartyManagerBack.Party.GroupUser

  @create_attrs %{
    group: 42,
    user: 42
  }
  @update_attrs %{
    group: 43,
    user: 43
  }
  @invalid_attrs %{group: nil, user: nil}

  def fixture(:group_user) do
    {:ok, group_user} = Party.create_group_user(@create_attrs)
    group_user
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all groups_users", %{conn: conn} do
      conn = get(conn, Routes.group_user_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create group_user" do
    test "renders group_user when data is valid", %{conn: conn} do
      conn = post(conn, Routes.group_user_path(conn, :create), group_user: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.group_user_path(conn, :show, id))

      assert %{
               "id" => id,
               "group" => 42,
               "user" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.group_user_path(conn, :create), group_user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update group_user" do
    setup [:create_group_user]

    test "renders group_user when data is valid", %{
      conn: conn,
      group_user: %GroupUser{id: id} = group_user
    } do
      conn =
        put(conn, Routes.group_user_path(conn, :update, group_user), group_user: @update_attrs)

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.group_user_path(conn, :show, id))

      assert %{
               "id" => id,
               "group" => 43,
               "user" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, group_user: group_user} do
      conn =
        put(conn, Routes.group_user_path(conn, :update, group_user), group_user: @invalid_attrs)

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete group_user" do
    setup [:create_group_user]

    test "deletes chosen group_user", %{conn: conn, group_user: group_user} do
      conn = delete(conn, Routes.group_user_path(conn, :delete, group_user))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.group_user_path(conn, :show, group_user))
      end
    end
  end

  defp create_group_user(_) do
    group_user = fixture(:group_user)
    {:ok, group_user: group_user}
  end
end
