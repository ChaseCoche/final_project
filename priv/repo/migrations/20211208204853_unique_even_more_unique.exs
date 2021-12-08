defmodule FinalProject.Repo.Migrations.UniqueEvenMoreUnique do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION citext", "DROP EXTENSION citext"
    alter table(:users) do
      modify :email, :citext, null: false
    end
  end
end
