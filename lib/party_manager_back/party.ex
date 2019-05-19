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
    Repo.get_by!(User, email: email)
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

  alias PartyManagerBack.Party.Events_Users

  @doc """
  Returns the list of events_users.

  ## Examples

      iex> list_events_users()
      [%Events_Users{}, ...]

  """
  def list_events_users do
    Repo.all(Events_Users)
  end

  @doc """
  Gets a single events__users.

  Raises `Ecto.NoResultsError` if the Events  users does not exist.

  ## Examples

      iex> get_events__users!(123)
      %Events_Users{}

      iex> get_events__users!(456)
      ** (Ecto.NoResultsError)

  """
  def get_events__users!(id), do: Repo.get!(Events_Users, id)

  @doc """
  Creates a events__users.

  ## Examples

      iex> create_events__users(%{field: value})
      {:ok, %Events_Users{}}

      iex> create_events__users(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_events__users(attrs \\ %{}) do
    %Events_Users{}
    |> Events_Users.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a events__users.

  ## Examples

      iex> update_events__users(events__users, %{field: new_value})
      {:ok, %Events_Users{}}

      iex> update_events__users(events__users, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_events__users(%Events_Users{} = events__users, attrs) do
    events__users
    |> Events_Users.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Events_Users.

  ## Examples

      iex> delete_events__users(events__users)
      {:ok, %Events_Users{}}

      iex> delete_events__users(events__users)
      {:error, %Ecto.Changeset{}}

  """
  def delete_events__users(%Events_Users{} = events__users) do
    Repo.delete(events__users)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking events__users changes.

  ## Examples

      iex> change_events__users(events__users)
      %Ecto.Changeset{source: %Events_Users{}}

  """
  def change_events__users(%Events_Users{} = events__users) do
    Events_Users.changeset(events__users, %{})
  end
end
