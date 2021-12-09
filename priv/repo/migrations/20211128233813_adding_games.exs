defmodule FinalProject.Repo.Migrations.AddingGames do
  use Ecto.Migration

  def change do
    create table("games") do
      add :name, :string, null: false
      add :publisher, :string
      add :platform, :string, null: false
      timestamps()
    end
  end
end
