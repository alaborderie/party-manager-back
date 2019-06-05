defmodule PartyManagerBack.Guardian do
  @moduledoc false
  use Guardian, otp_app: :party_manager_back

  def subject_for_token(resource, _claims) do
    sub = to_string(resource.id)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]
    resource = PartyManagerBack.Party.get_user!(id)
    {:ok, resource}
  end
end
