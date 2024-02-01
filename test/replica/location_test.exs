defmodule Spurer.ReplicaLocationTest do
  use ExUnit.Case, async: true
  alias Spurer.Replica.Location

  test "create and update all locations" do
    {:ok, server} = Location.start_link()

    empty_state = Location.get_all(server)
    assert empty_state == []

    :ok = Location.add(server, 1)

    locations = Location.get_all(server)

    assert locations === [1]
  end
end
