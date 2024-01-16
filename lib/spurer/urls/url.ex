defmodule Spurer.Urls.Url do
  use Ecto.Schema
  import Ecto.Changeset

  schema "urls" do
    field :link, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(url, attrs) do
    url
    |> cast(attrs, [:link, :title])
    |> validate_required([:link, :title])
  end
end
