defmodule FinalProject.Library do
  alias FinalProject.{Game, User, Repo}


  def add(%User{} = user, attrs) do
    user
    |> Ecto.build_assoc(:games)
    |> Game.changeset(attrs)
    |> Repo.insert!()
  end
end
