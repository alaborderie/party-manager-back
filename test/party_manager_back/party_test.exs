defmodule PartyManagerBack.PartyTest do
  use PartyManagerBack.DataCase

  alias PartyManagerBack.Party

  describe "users" do
    alias PartyManagerBack.Party.User

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Party.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Party.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Party.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Party.create_user(@valid_attrs)
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Party.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Party.update_user(user, @update_attrs)
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Party.update_user(user, @invalid_attrs)
      assert user == Party.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Party.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Party.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Party.change_user(user)
    end
  end

  describe "groups" do
    alias PartyManagerBack.Party.Group

    @valid_attrs %{background_img: "some background_img", description: "some description", name: "some name"}
    @update_attrs %{background_img: "some updated background_img", description: "some updated description", name: "some updated name"}
    @invalid_attrs %{background_img: nil, description: nil, name: nil}

    def group_fixture(attrs \\ %{}) do
      {:ok, group} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Party.create_group()

      group
    end

    test "list_groups/0 returns all groups" do
      group = group_fixture()
      assert Party.list_groups() == [group]
    end

    test "get_group!/1 returns the group with given id" do
      group = group_fixture()
      assert Party.get_group!(group.id) == group
    end

    test "create_group/1 with valid data creates a group" do
      assert {:ok, %Group{} = group} = Party.create_group(@valid_attrs)
      assert group.background_img == "some background_img"
      assert group.description == "some description"
      assert group.name == "some name"
    end

    test "create_group/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Party.create_group(@invalid_attrs)
    end

    test "update_group/2 with valid data updates the group" do
      group = group_fixture()
      assert {:ok, %Group{} = group} = Party.update_group(group, @update_attrs)
      assert group.background_img == "some updated background_img"
      assert group.description == "some updated description"
      assert group.name == "some updated name"
    end

    test "update_group/2 with invalid data returns error changeset" do
      group = group_fixture()
      assert {:error, %Ecto.Changeset{}} = Party.update_group(group, @invalid_attrs)
      assert group == Party.get_group!(group.id)
    end

    test "delete_group/1 deletes the group" do
      group = group_fixture()
      assert {:ok, %Group{}} = Party.delete_group(group)
      assert_raise Ecto.NoResultsError, fn -> Party.get_group!(group.id) end
    end

    test "change_group/1 returns a group changeset" do
      group = group_fixture()
      assert %Ecto.Changeset{} = Party.change_group(group)
    end
  end
end
