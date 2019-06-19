defmodule PartyManagerBack.Party do
  @moduledoc """
  The Party context.
  """

  import Ecto.Query, warn: false
  alias PartyManagerBack.Repo

  alias PartyManagerBack.Party.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Get a user by his email.

  Raises `Ecto.NoResultsError` if the User does not exist.
  """
  def get_by_email(email) when is_nil(email) do
    nil
  end

  def get_by_email(email) do
    Repo.get_by(User, email: email)
  end

  @doc """
  Check if user already exists by checking his email.
  """
  def user_exists?(email) when is_nil(email) do
    false
  end

  def user_exists?(email) do
    Repo.exists?(User, email: email)
  end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  alias PartyManagerBack.Party.Group

  @doc """
  Returns the list of groups.

  ## Examples

      iex> list_groups()
      [%Group{}, ...]

  """
  def list_groups do
    Repo.all(Group)
  end

  @doc """
  Gets a single group.

  Raises `Ecto.NoResultsError` if the Group does not exist.

  ## Examples

      iex> get_group!(123)
      %Group{}

      iex> get_group!(456)
      ** (Ecto.NoResultsError)

  """
  def get_group!(id), do: Repo.get!(Group, id)

  @doc """
  Creates a group.

  ## Examples

      iex> create_group(%{field: value})
      {:ok, %Group{}}

      iex> create_group(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_group(attrs \\ %{}) do
    %Group{}
    |> Group.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a group.

  ## Examples

      iex> update_group(group, %{field: new_value})
      {:ok, %Group{}}

      iex> update_group(group, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_group(%Group{} = group, attrs) do
    group
    |> Group.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Group.

  ## Examples

      iex> delete_group(group)
      {:ok, %Group{}}

      iex> delete_group(group)
      {:error, %Ecto.Changeset{}}

  """
  def delete_group(%Group{} = group) do
    Repo.delete(group)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking group changes.

  ## Examples

      iex> change_group(group)
      %Ecto.Changeset{source: %Group{}}

  """
  def change_group(%Group{} = group) do
    Group.changeset(group, %{})
  end

  alias PartyManagerBack.Party.Event

  @doc """
  Returns the list of events.

  ## Examples

      iex> list_events()
      [%Event{}, ...]

  """
  def list_events do
    Repo.all(Event)
  end

  @doc """
  List events for the given group
  """
  def list_events_for_group(group_id) do
    Repo.all(Event, group: group_id)
  end

  @doc """
  Gets a single event.

  Raises `Ecto.NoResultsError` if the Event does not exist.

  ## Examples

      iex> get_event!(123)
      %Event{}

      iex> get_event!(456)
      ** (Ecto.NoResultsError)

  """
  def get_event!(id), do: Repo.get!(Event, id)

  @doc """
  Creates a event.

  ## Examples

      iex> create_event(%{field: value})
      {:ok, %Event{}}

      iex> create_event(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_event(attrs \\ %{}) do
    %Event{}
    |> Event.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a event.

  ## Examples

      iex> update_event(event, %{field: new_value})
      {:ok, %Event{}}

      iex> update_event(event, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_event(%Event{} = event, attrs) do
    event
    |> Event.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Event.

  ## Examples

      iex> delete_event(event)
      {:ok, %Event{}}

      iex> delete_event(event)
      {:error, %Ecto.Changeset{}}

  """
  def delete_event(%Event{} = event) do
    Repo.delete(event)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking event changes.

  ## Examples

      iex> change_event(event)
      %Ecto.Changeset{source: %Event{}}

  """
  def change_event(%Event{} = event) do
    Event.changeset(event, %{})
  end

  alias PartyManagerBack.Party.EventsUsers

  @doc """
  Returns the list of events_users.

  ## Examples

      iex> list_events_users()
      [%EventsUsers{}, ...]

  """
  def list_events_users do
    Repo.all(EventsUsers)
  end

  @doc """
  Gets a single events_users.

  Raises `Ecto.NoResultsError` if the Events  users does not exist.

  ## Examples

      iex> get_events_users!(123)
      %EventsUsers{}

      iex> get_events_users!(456)
      ** (Ecto.NoResultsError)

  """
  def get_events_users!(id), do: Repo.get!(EventsUsers, id)

  @doc """
  Creates a events_users.

  ## Examples

      iex> create_events_users(%{field: value})
      {:ok, %EventsUsers{}}

      iex> create_events_users(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_events_users(attrs \\ %{}) do
    %EventsUsers{}
    |> EventsUsers.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a events_users.

  ## Examples

      iex> update_events_users(events_users, %{field: new_value})
      {:ok, %EventsUsers{}}

      iex> update_events_users(events_users, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_events_users(%EventsUsers{} = events_users, attrs) do
    events_users
    |> EventsUsers.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a EventsUsers.

  ## Examples

      iex> delete_events_users(events_users)
      {:ok, %EventsUsers{}}

      iex> delete_events_users(events_users)
      {:error, %Ecto.Changeset{}}

  """
  def delete_events_users(%EventsUsers{} = events_users) do
    Repo.delete(events_users)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking events_users changes.

  ## Examples

      iex> change_events_users(events_users)
      %Ecto.Changeset{source: %EventsUsers{}}

  """
  def change_events_users(%EventsUsers{} = events_users) do
    EventsUsers.changeset(events_users, %{})
  end

  alias PartyManagerBack.Party.GroupUser

  @doc """
  Returns a list of groups_users by group ID
  """
  def get_group_users_by_group!(group_id) do
    Repo.all(GroupUser, group: group_id)
  end

  @doc """
  Send a mail to each user of the created event
  """
  def send_emails(%Event{} = event) do
    group_users =
      Enum.reject(get_group_users_by_group!(event.group), fn x -> x.user == event.creator end)

    Enum.each(group_users, fn x ->
      group = get_group!(x.group)
      user = get_user!(x.user)
      email = PartyManagerBack.Email.send_email(user, group)
      PartyManagerBack.Mailer.deliver_now(email)
    end)
  end

  @doc """
  Returns the list of groups_users.

  ## Examples

      iex> list_groups_users()
      [%GroupUser{}, ...]

  """
  def list_groups_users do
    Repo.all(GroupUser)
  end

  @doc """
  Gets a single group_user.

  Raises `Ecto.NoResultsError` if the Group user does not exist.

  ## Examples

      iex> get_group_user!(123)
      %GroupUser{}

      iex> get_group_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_group_user!(id), do: Repo.get!(GroupUser, id)

  @doc """
  Creates a group_user.

  ## Examples

      iex> create_group_user(%{field: value})
      {:ok, %GroupUser{}}

      iex> create_group_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_group_user(attrs \\ %{}) do
    %GroupUser{}
    |> GroupUser.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a group_user.

  ## Examples

      iex> update_group_user(group_user, %{field: new_value})
      {:ok, %GroupUser{}}

      iex> update_group_user(group_user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_group_user(%GroupUser{} = group_user, attrs) do
    group_user
    |> GroupUser.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a GroupUser.

  ## Examples

      iex> delete_group_user(group_user)
      {:ok, %GroupUser{}}

      iex> delete_group_user(group_user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_group_user(%GroupUser{} = group_user) do
    Repo.delete(group_user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking group_user changes.

  ## Examples

      iex> change_group_user(group_user)
      %Ecto.Changeset{source: %GroupUser{}}

  """
  def change_group_user(%GroupUser{} = group_user) do
    GroupUser.changeset(group_user, %{})
  end
end
