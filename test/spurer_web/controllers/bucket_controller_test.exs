defmodule SpurerWeb.BucketControllerTest do
  use SpurerWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all children", %{conn: conn} do
      conn = get(conn, ~p"/api/buckets")
      json_response(conn, 200)["buckets"]
    end
  end

  describe "create bucket" do
    test "create a bucket and return its name", %{conn: conn} do
      conn = post(conn, ~p"/api/buckets", bucket: "testBucket")
      assert %{"buckets" => ["testBucket"]} = json_response(conn, 201)

      conn = get(conn, ~p"/api/buckets")
      assert ["testBucket"] = json_response(conn, 200)["buckets"]
    end
  end

  describe "update key in a bucket" do
    test "create a bucket and store a value", %{conn: conn} do
      conn = post(conn, ~p"/api/buckets", bucket: "testBucket")

      data = %{
        "key" => "hello",
        "value" => "world"
      }

      conn = put(conn, ~p"/api/buckets/testBucket", data: data)
      assert %{"value" => "world"} == json_response(conn, 200)
    end
  end

  # hasta aca

  # describe "create location" do
  #   test "renders location when data is valid", %{conn: conn} do
  #     conn = post(conn, ~p"/api/locations", location: @create_attrs)
  #     assert %{"id" => id} = json_response(conn, 201)["data"]

  #     conn = get(conn, ~p"/api/locations/#{id}")

  #     assert %{
  #              "id" => ^id,
  #              "lat" => 120.5,
  #              "lon" => 120.5
  #            } = json_response(conn, 200)["data"]
  #   end

  #   test "renders errors when data is invalid", %{conn: conn} do
  #     conn = post(conn, ~p"/api/locations", location: @invalid_attrs)
  #     assert json_response(conn, 422)["errors"] != %{}
  #   end
  # end

  # describe "update location" do
  #   setup [:create_location]

  #   test "renders location when data is valid", %{
  #     conn: conn,
  #     location: %Location{id: id} = location
  #   } do
  #     conn = put(conn, ~p"/api/locations/#{location}", location: @update_attrs)
  #     assert %{"id" => ^id} = json_response(conn, 200)["data"]

  #     conn = get(conn, ~p"/api/locations/#{id}")

  #     assert %{
  #              "id" => ^id,
  #              "lat" => 456.7,
  #              "lon" => 456.7
  #            } = json_response(conn, 200)["data"]
  #   end

  #   test "renders errors when data is invalid", %{conn: conn, location: location} do
  #     conn = put(conn, ~p"/api/locations/#{location}", location: @invalid_attrs)
  #     assert json_response(conn, 422)["errors"] != %{}
  #   end
  # end

  # describe "delete location" do
  #   setup [:create_location]

  #   test "deletes chosen location", %{conn: conn, location: location} do
  #     conn = delete(conn, ~p"/api/locations/#{location}")
  #     assert response(conn, 204)

  #     assert_error_sent 404, fn ->
  #       get(conn, ~p"/api/locations/#{location}")
  #     end
  #   end
  # end

  # defp create_location(_) do
  #   location = location_fixture()
  #   %{location: location}
  # end
end
