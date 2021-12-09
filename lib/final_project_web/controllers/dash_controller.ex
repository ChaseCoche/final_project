defmodule FinalProjectWeb.DashController do
  use FinalProjectWeb, :controller
  alias FinalProject.{Accounts, User}
  plug :authenticate_user

  def index(%{assigns: %{authenticated_user: user}} = conn, _params) do
    render(conn, "index.html", account: user)
  end

  def authenticate_user(conn, _opts) do
    token = get_session(conn, :user_token)
    {:ok, id} = Phoenix.Token.verify(FinalProjectWeb.Endpoint, "randomized_salt", token)
    assign(conn, :authenticated_user, Accounts.get(id))
  end

  def renedit(%{assigns: %{authenticated_user: _user}} = conn, %{"id" => id}) do
    account = Accounts.get(id)
    changeset = User.update_changeset(account)

    render(conn, "edit.html",changeset: changeset, id: id, account: account)
  end

  def edit(%{assigns: %{authenticated_user: _user}} = conn,  %{"id" => id, "user" => attrs} = _params
  ) do
  account = Accounts.get(id)
  Accounts.update(account, attrs)
  render(conn, "index.html", account: account)
  end

end
