defmodule FinalProjectWeb.UsersController do
  use FinalProjectWeb, :controller
  alias FinalProject.Accounts
  # alias FinalProjectWeb.ErrorHelpers

  def view do
    quote do
      use Phoenix.View, root: "web/templates"

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_csrf_token: 0, get_flash: 2, view_module: 1]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      # vvvv BEGIN OUR CODE vvvv
      import Phoenix.HTML.Form, except: [number_input: 2, number_input: 3, text_input: 3]
      import FinalProjectWeb.ValidInputs
      # ^^^^ END OUR CODE ^^^^

      import FinalProjectWeb.Router.Helpers
      import FinalProjectWeb.ErrorHelpers
      import FinalProjectWeb.Gettext
    end
  end

  def new(conn, _params) do
    render(conn, "create.html")
  end

  def put_token(conn, user_id) do
    token = Phoenix.Token.sign(FinalProjectWeb.Endpoint, "randomized_salt", user_id)

    conn
    |> clear_session()
    |> configure_session(renew: true)
    |> put_session(:user_token, token)
  end

  def create(
        conn,
        %{
          "users" => %{
            "email" => _email,
            "name" => _name,
            "password" => _password,
            "game_style" => _game_style
          }
        } = params
      ) do
    user_params = params["users"]
    {:ok, %{id: id}} = Accounts.create(user_params)

    conn
    |> put_token(id)
    |> redirect(to: Routes.dash_path(conn, :index))
  end
end
