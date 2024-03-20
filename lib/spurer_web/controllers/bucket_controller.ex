defmodule SpurerWeb.BucketController do
  use SpurerWeb, :controller

  action_fallback SpurerWeb.FallbackController
  alias Spurer.Storage.Bucket

  def index(conn, _params) do
    random_str = for _ <- 1..10, into: "", do: <<Enum.random(~c"0123456789abcdef")>>
    random_name = "Bucket: #{random_str}"
    Bucket.start(random_name)
    send_resp(conn, 201, random_name)
  end
end
