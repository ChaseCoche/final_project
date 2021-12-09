defmodule FinalProject.UserAuthTest do
  use FinalProject.DataCase
  alias FinalProject.{Accounts, User, Accounts.UserAuth}

  describe "UserAuth.login/2" do
    test "Login should go through allow user access" do
      email = "chantheman@jackiechan.net"
      password = "1337ChAnNy69"
      params = %{name: "Jackie Chan", email: email, password: password}

      assert {:ok, %{email: email}} = Accounts.create(params)

      assert %User{email: ^email} = UserAuth.login(email, password)
    end
  end
end
