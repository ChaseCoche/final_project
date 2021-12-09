defmodule FinalProject.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bcrypt
  alias FinalProject.Game

  schema "users" do
    field :email, :string
    field :name, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :game_style, Ecto.Enum, values: [:fps, :moba, :racing, :fighting]
    has_many :games, Game
    timestamps()
  end

  def changeset(%__MODULE__{} = user, attrs) do
    user
    |> cast(attrs, [:email, :name, :password, :game_style])
  end

  def create_changeset(%__MODULE__{} = user, attrs) do
    user
    |> cast(attrs, [:email, :name, :password, :game_style])
    |> validate_required([:email, :name, :password])
    # This is just added to show that the input validation is added.
    |> validate_length(:email, min: 6)
    |> validate_length(:password, min: 8)
    |> validate_format(:email, ~r/@/)
    |> put_hash()
    |> unique_constraint(:email)
  end

  defp put_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    put_change(changeset, :password_hash, Bcrypt.hash_pwd_salt(password))
  end

  defp put_hash(changeset), do: changeset
end
