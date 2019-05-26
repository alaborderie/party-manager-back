defmodule PartyManagerBack.Party.Group do
  use Ecto.Schema
  import Ecto.Changeset

  defp create_img(data_url) do
    if data_url != nil do
      with %{scheme: "data"} = uri <- URI.parse(data_url),
           %URL.Data{data: data} <- URL.Data.parse(uri) do
        file_name = to_string(System.system_time(:millisecond)) <> "." <> "jpeg"
        file_url = "priv/static/images/" <> file_name
        File.write!(file_url, data)
        hostname = Application.get_env(:party_manager_back, PartyManagerBackWeb.Endpoint)[:url][:host]
        port = Application.get_env(:party_manager_back, PartyManagerBackWeb.Endpoint)[:url][:port]
        "http://" <> hostname <> ":" <> to_string(port) <> "/images/" <> file_name
      end
    else
      nil
    end
  end

  schema "groups" do
    field :background_img, :string
    field :description, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(group, attrs) do
    group
    |> cast(attrs, [:name, :description, :background_img])
    |> validate_required([:name, :description])
    |> update_change(:background_img, &create_img/1)
  end
end
