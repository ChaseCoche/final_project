defmodule FinalProjectWeb.DashView do
  use FinalProjectWeb, :view

  def user_view(assigns) do
    ~H"""

      <div>
      <a href={@edit_link}>Edit</a>
      </div>
    """
  end


  defp with_edit_link(conn_or_socket, user) do

    Map.put_new(user, :edit_link, Routes.dash_path(conn_or_socket, :edit, user.id))
  end
end
