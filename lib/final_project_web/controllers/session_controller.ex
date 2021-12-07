defmodule FinalProjectWeb.SessionController do
  use FinalProjectWeb, :controller
  alias FinalProject.Accounts.UserAuth
  alias FinalProject.{User,Accounts}

  def new(conn, _param) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => %{"email" => email, "password" => password}}) do
    with %User{id: id} <- UserAuth.login(email, password),
         token <- Phoenix.Token.sign(FinalProjectWeb.Endpoint, "randomized_salt", id) do
      conn
      |> clear_session()
      |> configure_session(renew: true)
      |> put_session(:user_token, token)
      |> redirect(to: Routes.dash_path(conn, :index))
    else
      nil ->
        conn
        |> render("new.html")
    end
  end

  def create_account(
    %{"email" => _email, "name" => _name, "password" => _password, "game_style" => _game_style} = params
      ) do
    Accounts.create(params)

    render("new.html")
  end

end
