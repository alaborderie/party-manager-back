defmodule PartyManagerBackWeb.GroupControllerTest do
  use PartyManagerBackWeb.ConnCase

  alias PartyManagerBack.Party
  alias PartyManagerBack.Party.Group

  @create_attrs %{
    background_img: "some background_img",
    description: "some description",
    name: "some name"
  }
  @update_attrs %{
    background_img: "some updated background_img",
    description: "some updated description",
    name: "some updated name"
  }
  @invalid_attrs %{background_img: nil, description: nil, name: nil}

  def fixture(:group) do
    {:ok, group} = Party.create_group(@create_attrs)
    group
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all groups", %{conn: conn} do
      conn = get(conn, Routes.group_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create group" do
    test "renders group when data is valid", %{conn: conn} do
      conn = post(conn, Routes.group_path(conn, :create), group: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.group_path(conn, :show, id))

      assert %{
               "id" => id,
               "background_img" => "some background_img",
               "description" => "some description",
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.group_path(conn, :create), group: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update group" do
    setup [:create_group]

    test "renders group when data is valid", %{conn: conn, group: %Group{id: id} = group} do
      conn = put(conn, Routes.group_path(conn, :update, group), group: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.group_path(conn, :show, id))

      assert %{
               "id" => id,
               "background_img" => "some updated background_img",
               "description" => "some updated description",
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, group: group} do
      conn = put(conn, Routes.group_path(conn, :update, group), group: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  defp create_group(_) do
    group = fixture(:group)
    {:ok, group: group}
  end
end
