defmodule PartyManagerBack.PartyTest do
  use PartyManagerBack.DataCase

  alias PartyManagerBack.Party

  describe "users" do
    alias PartyManagerBack.Party.User

    @valid_attrs %{first_name: "some first_name", last_name: "some last_name", email: "some email", password: "some password"}
    @update_attrs %{first_name: "some updated first_name", last_name: "some updated last_name", email: "some updated email"}
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

  describe "events" do
    alias PartyManagerBack.Party.Event

    @valid_attrs %{background_img: "some background_img", description: "some description", end_date: ~D[2010-04-17], name: "some name", place: "some place", start_date: ~D[2010-04-17]}
    @update_attrs %{background_img: "some updated background_img", description: "some updated description", end_date: ~D[2011-05-18], name: "some updated name", place: "some updated place", start_date: ~D[2011-05-18]}
    @invalid_attrs %{background_img: nil, description: nil, end_date: nil, name: nil, place: nil, start_date: nil}

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
    alias PartyManagerBack.Party.Events_Users

    @valid_attrs %{is_going: true}
    @update_attrs %{is_going: false}
    @invalid_attrs %{is_going: nil}

    def events__users_fixture(attrs \\ %{}) do
      {:ok, events__users} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Party.create_events__users()

      events__users
    end

    test "list_events_users/0 returns all events_users" do
      events__users = events__users_fixture()
      assert Party.list_events_users() == [events__users]
    end

    test "get_events__users!/1 returns the events__users with given id" do
      events__users = events__users_fixture()
      assert Party.get_events__users!(events__users.id) == events__users
    end

    test "create_events__users/1 with valid data creates a events__users" do
      assert {:ok, %Events_Users{} = events__users} = Party.create_events__users(@valid_attrs)
      assert events__users.is_going == true
    end

    test "create_events__users/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Party.create_events__users(@invalid_attrs)
    end

    test "update_events__users/2 with valid data updates the events__users" do
      events__users = events__users_fixture()
      assert {:ok, %Events_Users{} = events__users} = Party.update_events__users(events__users, @update_attrs)
      assert events__users.is_going == false
    end

    test "update_events__users/2 with invalid data returns error changeset" do
      events__users = events__users_fixture()
      assert {:error, %Ecto.Changeset{}} = Party.update_events__users(events__users, @invalid_attrs)
      assert events__users == Party.get_events__users!(events__users.id)
    end

    test "delete_events__users/1 deletes the events__users" do
      events__users = events__users_fixture()
      assert {:ok, %Events_Users{}} = Party.delete_events__users(events__users)
      assert_raise Ecto.NoResultsError, fn -> Party.get_events__users!(events__users.id) end
    end

    test "change_events__users/1 returns a events__users changeset" do
      events__users = events__users_fixture()
      assert %Ecto.Changeset{} = Party.change_events__users(events__users)
    end
  end
end
