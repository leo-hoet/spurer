defmodule SpurerWeb.BucketController do
  use SpurerWeb, :controller

  action_fallback SpurerWeb.FallbackController
  alias Spurer.Storage.Bucket

  def index(conn, _params) do
    keys = Bucket.get_all_names()
    render(conn, :index, buckets: keys)
  end

  def create(conn, %{"bucket" => bucket_name}) do
    {:ok, _pid} = Bucket.start(bucket_name)

    conn
    |> put_status(:created)
    |> render(:show, buckets: bucket_name)
  end

  def update(conn, %{"id" => bucket_name, "data" => data}) do
    [bucket | _] = Bucket.lookup(bucket_name)
    {bucket_pid, _} = bucket

    Bucket.put_value(bucket_pid, Map.get(data, "key"), Map.get(data, "value"))

    render(conn, :show_value, value: Map.get(data, "value"))
  end
end
