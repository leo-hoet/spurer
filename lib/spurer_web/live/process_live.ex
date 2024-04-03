defmodule SpurerWeb.ProcessLive do
  alias Spurer.Locations
  use SpurerWeb, :live_view

  @topic "location_updates"

  @spec render(any()) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do
    ~H"""
    Current temperature: <%= @temperature %>°F <button phx-click="inc_temperature">+</button>

    <pre>
      Current locations: <%= @locations %>
    </pre>

    <pre>
      <%= @pnames %>
    </pre>
    """
  end

  defp process_cpu() do
    Process.list()
    |> Enum.map(&Process.info(&1))
    |> Enum.sort(&(&1[:reductions] >= &2[:reductions]))
    |> Enum.take(20)
    |> Enum.map(& &1[:registered_name])
    |> Enum.filter(&(&1 != nil))
    |> Enum.join("\n")
  end

  defp get_locations() do
    Locations.list_locations()
    |> Enum.map(&"id:#{Map.get(&1, :id, "not_found")}\n")
  end

  def mount(_params, _session, socket) do
    SpurerWeb.Endpoint.subscribe(@topic)
    temperature = 70

    socket =
      socket
      |> assign(:pnames, process_cpu())
      |> assign(:locations, get_locations())
      |> assign(:temperature, temperature)

    {:ok, socket}
  end

  def handle_event("inc_temperature", _params, socket) do
    {:noreply, update(socket, :temperature, &(&1 + 1))}
  end

  def handle_info(msg, socket) do
    {:noreply, assign(socket, :locations, get_locations())}
  end
end
