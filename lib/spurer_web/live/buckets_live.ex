defmodule SpurerWeb.BucketsLive do
  alias Phoenix.Socket.Broadcast
  alias Spurer.Storage.Bucket
  use SpurerWeb, :live_view

  @topic "buckets_updates"

  @spec render(any()) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do
    ~H"""
    <style>
      {`
          @keyframes blink {
            50% {
              background-color: transparent; /* Change to desired blink color */
            }
          }

          .animate-blink {
            animation: blink 1s infinite;
          }
        `}
    </style>
    <button phx-click="new_bucket_clk">New bucket</button>

    <button phx-click="blink_clk">blink</button>

    <div class="flex flex-wrap space-x-4">
      <%= for key <- bucket_keys @buckets do %>
        <div class="bg-gray-200 rounded-lg p-2 m-2 animate-blink"><%= key %></div>
      <% end %>
    </div>
    """
  end

  defp bucket_keys(buckets) do
    buckets
  end

  defp get_buckets_names() do
    Bucket.get_all_names()
  end

  def mount(_params, _session, socket) do
    SpurerWeb.Endpoint.subscribe(@topic)

    socket =
      socket
      |> assign(:buckets, get_buckets_names())

    {:ok, socket}
  end

  def handle_info(
        %Broadcast{
          topic: "buckets_updates",
          event: "new_bucket",
          payload: payload
        } = _msg,
        socket
      ) do
    IO.inspect(payload)
    socket = assign(socket, :buckets, get_buckets_names())
    {:noreply, socket}
  end

  def handle_info(
        %Broadcast{
          topic: "buckets_updates",
          event: "bucket_updated",
          payload: bucket_name
        } = _msg,
        socket
      ) do
    socket = assign(socket, :buckets, get_buckets_names())
    {:noreply, socket}
  end

  def handle_event("blink_clk", _unsigned_params, socket) do
    {:noreply, socket}
  end

  def handle_event("new_bucket_clk", _params, socket) do
    random_str = for _ <- 1..10, into: "", do: <<Enum.random(~c"0123456789abcdef")>>
    {:ok, _} = Bucket.start(random_str)
    SpurerWeb.Endpoint.broadcast(@topic, "new_bucket", random_str)
    SpurerWeb.Endpoint.broadcast(@topic, "bucket_updated", random_str)
    {:noreply, socket}
  end
end
