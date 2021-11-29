defmodule FinalProject.Accounts do
  alias FinalProject.User
  alias FinalProject.Repo

#import Ecto.Query

  def create(params) do
    %User{}
    |> User.create_changeset(params)
    |> Repo.insert()
  end #Takes user params and inserts into database

  def get(id) do
    User
    |> Repo.get(User.id)
  end


end
