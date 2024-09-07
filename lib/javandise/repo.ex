defmodule Javandise.Repo do
  use Ecto.Repo,
    otp_app: :javandise,
    adapter: Ecto.Adapters.Postgres
end
