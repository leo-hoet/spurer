defmodule Spurer.Repo do
  use Ecto.Repo,
    otp_app: :spurer,
    adapter: Ecto.Adapters.Postgres
end
