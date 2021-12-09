defmodule FinalProjectWeb.SessionController do
  use FinalProjectWeb, :controller
  alias FinalProject.Accounts.UserAuth
  alias FinalProject.User

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

  def delete(conn, _params) do
    conn
    |> clear_session()
    |> render("new.html")
    |> halt()
  end
end
