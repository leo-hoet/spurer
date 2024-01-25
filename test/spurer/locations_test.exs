defmodule Spurer.LocationsTest do
  use Spurer.DataCase

  alias Spurer.Locations

  describe "locations" do
    alias Spurer.Locations.Location

    import Spurer.LocationsFixtures

    @invalid_attrs %{lat: nil, lon: nil}

    test "list_locations/0 returns all locations" do
      location = location_fixture()
      assert Locations.list_locations() == [location]
    end

    test "get_location!/1 returns the location with given id" do
      location = location_fixture()
      assert Locations.get_location!(location.id) == location
    end

    test "create_location/1 with valid data creates a location" do
      valid_attrs = %{lat: 120.5, lon: 120.5}

      assert {:ok, %Location{} = location} = Locations.create_location(valid_attrs)
      assert location.lat == 120.5
      assert location.lon == 120.5
    end

    test "create_location/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Locations.create_location(@invalid_attrs)
    end

    test "update_location/2 with valid data updates the location" do
      location = location_fixture()
      update_attrs = %{lat: 456.7, lon: 456.7}

      assert {:ok, %Location{} = location} = Locations.update_location(location, update_attrs)
      assert location.lat == 456.7
      assert location.lon == 456.7
    end

    test "update_location/2 with invalid data returns error changeset" do
      location = location_fixture()
      assert {:error, %Ecto.Changeset{}} = Locations.update_location(location, @invalid_attrs)
      assert location == Locations.get_location!(location.id)
    end

    test "delete_location/1 deletes the location" do
      location = location_fixture()
      assert {:ok, %Location{}} = Locations.delete_location(location)
      assert_raise Ecto.NoResultsError, fn -> Locations.get_location!(location.id) end
    end

    test "change_location/1 returns a location changeset" do
      location = location_fixture()
      assert %Ecto.Changeset{} = Locations.change_location(location)
    end
  end
end
