defmodule Cdpf.AccountsTest do
  use Cdpf.DataCase

  alias Cdpf.Accounts

  describe "login" do
    alias Cdpf.Accounts.Login

    import Cdpf.AccountsFixtures

    @invalid_attrs %{password: nil, email: nil}

    test "list_login/0 returns all login" do
      login = login_fixture()
      assert Accounts.list_login() == [login]
    end

    test "get_login!/1 returns the login with given id" do
      login = login_fixture()
      assert Accounts.get_login!(login.id) == login
    end

    test "create_login/1 with valid data creates a login" do
      valid_attrs = %{password: "some password", email: "some email"}

      assert {:ok, %Login{} = login} = Accounts.create_login(valid_attrs)
      assert login.password == "some password"
      assert login.email == "some email"
    end

    test "create_login/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_login(@invalid_attrs)
    end

    test "update_login/2 with valid data updates the login" do
      login = login_fixture()
      update_attrs = %{password: "some updated password", email: "some updated email"}

      assert {:ok, %Login{} = login} = Accounts.update_login(login, update_attrs)
      assert login.password == "some updated password"
      assert login.email == "some updated email"
    end

    test "update_login/2 with invalid data returns error changeset" do
      login = login_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_login(login, @invalid_attrs)
      assert login == Accounts.get_login!(login.id)
    end

    test "delete_login/1 deletes the login" do
      login = login_fixture()
      assert {:ok, %Login{}} = Accounts.delete_login(login)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_login!(login.id) end
    end

    test "change_login/1 returns a login changeset" do
      login = login_fixture()
      assert %Ecto.Changeset{} = Accounts.change_login(login)
    end
  end
end
