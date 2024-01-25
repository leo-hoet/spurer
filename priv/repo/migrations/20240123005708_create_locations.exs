defmodule Spurer.Repo.Migrations.CreateLocations do
  use Ecto.Migration

  def change do
    create table(:locations) do
      add :lat, :float, null: false
      add :lon, :float, null: false

      timestamps()
    end
  end
end
