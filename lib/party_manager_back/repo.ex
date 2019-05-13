defmodule PartyManagerBack.Repo do
  use Ecto.Repo,
    otp_app: :party_manager_back,
    adapter: Ecto.Adapters.MySQL
end
