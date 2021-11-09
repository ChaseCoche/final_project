defmodule FinalProject.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bcrypt

  schema "users" do
    field :email, :string
    field :name,  :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :player_style,  Ecto.Enum, values: []
    field :game_style,    Ecto.Enum, values: [:fps, :moba, :racing ]
    timestamps()
  end

  def changeset(%__MODULE__{}=user, attrs) do
    user
    |>  cast(attrs, [:email,:name,:password])
  end

  def create_changeset(%__MODULE__{} = user, attrs) do
    user
    |> cast(attrs, [:email,:name,:password])
    |> validate_required([:email,:name,:password])
    |> validate_length(:password, min: 8)
    |> validate_format(:email, ~r/@/)
    |> put_hash()
  end

  defp put_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset)
  do
    put_change(changeset, :password_hash, Bcrypt.hash_pwd_salt(password))
  end
  defp put_hash(changeset), do: changeset
end
