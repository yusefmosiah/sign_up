defmodule SignUp.Repo do
  use Ecto.Repo,
    otp_app: :sign_up,
    adapter: Ecto.Adapters.Postgres
end
