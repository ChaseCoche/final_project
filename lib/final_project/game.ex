defmodule FinalProject.Game do
  use Ecto.Schema
  import Ecto.Changeset
  alias FinalProject.User

  schema "games" do
    field :name, :string
    field :publisher, :string
    field :platform, Ecto.Enum, values: [:Playstation, :XBOX, :Nintendo, :PC]

    belongs_to :user, User

    timestamps()
  end

  def changeset(game, attrs \\ %{}) do
    game
    |> cast(attrs, [:name, :publisher, :platform])
  end
end
