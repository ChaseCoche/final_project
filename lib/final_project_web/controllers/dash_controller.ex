defmodule FinalProjectWeb.DashController do
  use FinalProjectWeb, :controller
  alias FinalProject.Accounts
  plug :authenticate_user

  def index(%{assigns: %{authenticated_user: user}} = conn, _params) do
    render(conn, "index.html", account: user)
  end
  def authenticate_user(conn, _opts) do
    token = get_session(conn, :user_token)
    {:ok, id} = Phoenix.Token.verify(FinalProjectWeb.Endpoint, "randomized_salt", token)
    assign(conn, :authenticated_user, Accounts.get(id))
    end
  end
