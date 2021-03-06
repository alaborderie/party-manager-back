defmodule PartyManagerBack.PartyTest do
  use PartyManagerBack.DataCase

  alias PartyManagerBack.Party

  describe "users" do
    alias PartyManagerBack.Party.User

    @valid_attrs %{
      first_name: "some first_name",
      last_name: "some last_name",
      email: "some email",
      password: "some password"
    }
    @update_attrs %{
      first_name: "some updated first_name",
      last_name: "some updated last_name",
      email: "some updated email"
    }
    @invalid_attrs %{first_name: nil, last_name: nil, email: nil}

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
      assert user.first_name == "some first_name"
      assert user.last_name == "some last_name"
      assert user.email == "some email"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Party.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Party.update_user(user, @update_attrs)
      assert user.first_name == "some updated first_name"
      assert user.last_name == "some updated last_name"
      assert user.email == "some updated email"
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

    @valid_attrs %{
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

  describe "events" do
    alias PartyManagerBack.Party.Event

    @valid_attrs %{
      background_img: "some background_img",
      description: "some description",
      end_date: ~D[2010-04-17],
      name: "some name",
      place: "some place",
      start_date: ~D[2010-04-17]
    }
    @update_attrs %{
      background_img: "some updated background_img",
      description: "some updated description",
      end_date: ~D[2011-05-18],
      name: "some updated name",
      place: "some updated place",
      start_date: ~D[2011-05-18]
    }
    @invalid_attrs %{
      background_img: nil,
      description: nil,
      end_date: nil,
      name: nil,
      place: nil,
      start_date: nil
    }

    def event_fixture(attrs \\ %{}) do
      {:ok, event} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Party.create_event()

      event
    end

    test "list_events/0 returns all events" do
      event = event_fixture()
      assert Party.list_events() == [event]
    end

    test "get_event!/1 returns the event with given id" do
      event = event_fixture()
      assert Party.get_event!(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      assert {:ok, %Event{} = event} = Party.create_event(@valid_attrs)
      assert event.background_img == "some background_img"
      assert event.description == "some description"
      assert event.end_date == ~D[2010-04-17]
      assert event.name == "some name"
      assert event.place == "some place"
      assert event.start_date == ~D[2010-04-17]
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Party.create_event(@invalid_attrs)
    end

    test "update_event/2 with valid data updates the event" do
      event = event_fixture()
      assert {:ok, %Event{} = event} = Party.update_event(event, @update_attrs)
      assert event.background_img == "some updated background_img"
      assert event.description == "some updated description"
      assert event.end_date == ~D[2011-05-18]
      assert event.name == "some updated name"
      assert event.place == "some updated place"
      assert event.start_date == ~D[2011-05-18]
    end

    test "update_event/2 with invalid data returns error changeset" do
      event = event_fixture()
      assert {:error, %Ecto.Changeset{}} = Party.update_event(event, @invalid_attrs)
      assert event == Party.get_event!(event.id)
    end

    test "delete_event/1 deletes the event" do
      event = event_fixture()
      assert {:ok, %Event{}} = Party.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> Party.get_event!(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      event = event_fixture()
      assert %Ecto.Changeset{} = Party.change_event(event)
    end
  end

  describe "events_users" do
    alias PartyManagerBack.Party.EventsUsers

    @valid_attrs %{is_going: true}
    @update_attrs %{is_going: false}
    @invalid_attrs %{is_going: nil}

    def events_users_fixture(attrs \\ %{}) do
      {:ok, events_users} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Party.create_events_users()

      events_users
    end

    test "list_events_users/0 returns all events_users" do
      events_users = events_users_fixture()
      assert Party.list_events_users() == [events_users]
    end

    test "get_events_users!/1 returns the events_users with given id" do
      events_users = events_users_fixture()
      assert Party.get_events_users!(events_users.id) == events_users
    end

    test "create_events_users/1 with valid data creates a events_users" do
      assert {:ok, %EventsUsers{} = events_users} = Party.create_events_users(@valid_attrs)
      assert events_users.is_going == true
    end

    test "create_events_users/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Party.create_events_users(@invalid_attrs)
    end

    test "update_events_users/2 with valid data updates the events_users" do
      events_users = events_users_fixture()

      assert {:ok, %EventsUsers{} = events_users} =
               Party.update_events_users(events_users, @update_attrs)

      assert events_users.is_going == false
    end

    test "update_events_users/2 with invalid data returns error changeset" do
      events_users = events_users_fixture()
      assert {:error, %Ecto.Changeset{}} = Party.update_events_users(events_users, @invalid_attrs)
      assert events_users == Party.get_events_users!(events_users.id)
    end

    test "delete_events_users/1 deletes the events_users" do
      events_users = events_users_fixture()
      assert {:ok, %EventsUsers{}} = Party.delete_events_users(events_users)
      assert_raise Ecto.NoResultsError, fn -> Party.get_events_users!(events_users.id) end
    end

    test "change_events_users/1 returns a events_users changeset" do
      events_users = events_users_fixture()
      assert %Ecto.Changeset{} = Party.change_events_users(events_users)
    end
  end

  describe "groups_users" do
    alias PartyManagerBack.Party.GroupUser

    @valid_attrs %{group: 42, user: 42}
    @update_attrs %{group: 43, user: 43}
    @invalid_attrs %{group: nil, user: nil}

    def group_user_fixture(attrs \\ %{}) do
      {:ok, group_user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Party.create_group_user()

      group_user
    end

    test "list_groups_users/0 returns all groups_users" do
      group_user = group_user_fixture()
      assert Party.list_groups_users() == [group_user]
    end

    test "get_group_user!/1 returns the group_user with given id" do
      group_user = group_user_fixture()
      assert Party.get_group_user!(group_user.id) == group_user
    end

    test "create_group_user/1 with valid data creates a group_user" do
      assert {:ok, %GroupUser{} = group_user} = Party.create_group_user(@valid_attrs)
      assert group_user.group == 42
      assert group_user.user == 42
    end

    test "create_group_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Party.create_group_user(@invalid_attrs)
    end

    test "update_group_user/2 with valid data updates the group_user" do
      group_user = group_user_fixture()
      assert {:ok, %GroupUser{} = group_user} = Party.update_group_user(group_user, @update_attrs)
      assert group_user.group == 43
      assert group_user.user == 43
    end

    test "update_group_user/2 with invalid data returns error changeset" do
      group_user = group_user_fixture()
      assert {:error, %Ecto.Changeset{}} = Party.update_group_user(group_user, @invalid_attrs)
      assert group_user == Party.get_group_user!(group_user.id)
    end

    test "delete_group_user/1 deletes the group_user" do
      group_user = group_user_fixture()
      assert {:ok, %GroupUser{}} = Party.delete_group_user(group_user)
      assert_raise Ecto.NoResultsError, fn -> Party.get_group_user!(group_user.id) end
    end

    test "change_group_user/1 returns a group_user changeset" do
      group_user = group_user_fixture()
      assert %Ecto.Changeset{} = Party.change_group_user(group_user)
    end
  end
end
