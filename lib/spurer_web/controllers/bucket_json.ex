defmodule SpurerWeb.BucketJSON do
  @doc """
  Renders a list of locations.
  """
  def index(%{buckets: buckets}) do
    %{buckets: buckets}
  end

  def show(%{buckets: bucketName}) do
    %{buckets: [bucketName]}
  end

  def show_value(%{value: value}) do
    %{value: value}
  end
end
