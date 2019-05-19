defmodule PartyManagerBack.AuthAccessPipeline do
  use Guardian.Plug.Pipeline, otp_app: :party_manager_back

  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource, allow_blank: true
end
