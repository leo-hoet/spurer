defmodule Spurer.LocationsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Spurer.Locations` context.
  """

  @doc """
  Generate a location.
  """
  def location_fixture(attrs \\ %{}) do
    {:ok, location} =
      attrs
      |> Enum.into(%{
        lat: 120.5,
        lon: 120.5
      })
      |> Spurer.Locations.create_location()

    location
  end
end
