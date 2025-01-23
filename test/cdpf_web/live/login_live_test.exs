defmodule CdpfWeb.LoginLiveTest do
  use CdpfWeb.ConnCase

  import Phoenix.LiveViewTest
  import Cdpf.AccountsFixtures

  @create_attrs %{password: "some password", email: "some email"}
  @update_attrs %{password: "some updated password", email: "some updated email"}
  @invalid_attrs %{password: nil, email: nil}

  defp create_login(_) do
    login = login_fixture()
    %{login: login}
  end

  describe "Index" do
    setup [:create_login]

    test "lists all login", %{conn: conn, login: login} do
      {:ok, _index_live, html} = live(conn, ~p"/login")

      assert html =~ "Listing Login"
      assert html =~ login.password
    end

    test "saves new login", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/login")

      assert index_live |> element("a", "New Login") |> render_click() =~
               "New Login"

      assert_patch(index_live, ~p"/login/new")

      assert index_live
             |> form("#login-form", login: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#login-form", login: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/login")

      html = render(index_live)
      assert html =~ "Login created successfully"
      assert html =~ "some password"
    end

    test "updates login in listing", %{conn: conn, login: login} do
      {:ok, index_live, _html} = live(conn, ~p"/login")

      assert index_live |> element("#login-#{login.id} a", "Edit") |> render_click() =~
               "Edit Login"

      assert_patch(index_live, ~p"/login/#{login}/edit")

      assert index_live
             |> form("#login-form", login: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#login-form", login: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/login")

      html = render(index_live)
      assert html =~ "Login updated successfully"
      assert html =~ "some updated password"
    end

    test "deletes login in listing", %{conn: conn, login: login} do
      {:ok, index_live, _html} = live(conn, ~p"/login")

      assert index_live |> element("#login-#{login.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#login-#{login.id}")
    end
  end

  describe "Show" do
    setup [:create_login]

    test "displays login", %{conn: conn, login: login} do
      {:ok, _show_live, html} = live(conn, ~p"/login/#{login}")

      assert html =~ "Show Login"
      assert html =~ login.password
    end

    test "updates login within modal", %{conn: conn, login: login} do
      {:ok, show_live, _html} = live(conn, ~p"/login/#{login}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Login"

      assert_patch(show_live, ~p"/login/#{login}/show/edit")

      assert show_live
             |> form("#login-form", login: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#login-form", login: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/login/#{login}")

      html = render(show_live)
      assert html =~ "Login updated successfully"
      assert html =~ "some updated password"
    end
  end
end
