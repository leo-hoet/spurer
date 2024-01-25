defmodule SpurerWeb.LocationJSON do
  alias Spurer.Locations.Location

  @doc """
  Renders a list of locations.
  """
  def index(%{locations: locations}) do
    %{data: for(location <- locations, do: data(location))}
  end

  @doc """
  Renders a single location.
  """
  def show(%{location: location}) do
    %{data: data(location)}
  end

  defp data(%Location{} = location) do
    %{
      id: location.id,
      lat: location.lat,
      lon: location.lon
    }
  end
end
