defmodule FinalProject.UserTest do
  use FinalProject.DataCase
  alias FinalProject.Accounts

  describe "module User.create/1" do
    test "Creates new users" do
      params = %{name: "Jackie Chan", email: "chantheman@jackie.net", password: "1337ChAnNy69"}
      assert {:ok, %{}} = Accounts.create(params)
    end

    test "Checking password not null case" do
      params = %{name: "Jackie Chan", email: "chantheman@jackie.net"}
      assert {:error, changeset} = Accounts.create(params)
      assert "can't be blank" in errors_on(changeset).password
    end

    test "Checking email not null case" do
      params = %{name: "Jackie Chan", password: "1337ChAnNy69"}
      assert {:error, changeset} = Accounts.create(params)
      assert "can't be blank" in errors_on(changeset).email
    end

    test "Checks that database only allows certain gamestyles" do
      params = %{
        name: "Jackie Chan",
        email: "chantheman@jackie.net",
        password: "1337ChAnNy69",
        game_style: :nonsense
      }

      assert {:error, changeset} = Accounts.create(params)
      assert "is invalid" in errors_on(changeset).game_style
    end
  end
end
