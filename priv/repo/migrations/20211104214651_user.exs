defmodule FinalProject.Repo.Migrations.User do
  use Ecto.Migration

  def change do
    create table("users") do
      add :name, :string, null: false
      add :email, :string, null: false
      # Use BCrypt
      add :password_hash, :string, null: false
      add :game_style, :string, null: true
      add :player_style, :string, null: true
      timestamps()
    end

    alter table("games") do
      add :user_id, references("users")
    end
  end
end
