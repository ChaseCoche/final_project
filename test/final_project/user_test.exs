defmodule FinalProject.UserTest do
  use FinalProject.DataCase
  use ExUnit.Case
  use Plug.Test
  alias FinalProject.Accounts



  describe "module User.create/1" do
    test "Creates new users"
    params = %{name: "Jackie Chan", email: "chantheman@jackie.net", password: "1337ChAnNy69"}
      assert {:ok, %{}} = Accounts.create(params)
    end

end
