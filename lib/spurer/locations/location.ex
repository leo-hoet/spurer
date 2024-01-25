defmodule Spurer.Locations.Location do
  use Ecto.Schema
  import Ecto.Changeset

  schema "locations" do
    field :lat, :float
    field :lon, :float

    timestamps()
  end

  @doc false
  def changeset(location, attrs) do
    location
    |> cast(attrs, [:lat, :lon])
    |> validate_required([:lat, :lon])
  end
end
