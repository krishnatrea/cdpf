defmodule Cdpf.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Cdpf.Accounts` context.
  """

  @doc """
  Generate a login.
  """
  def login_fixture(attrs \\ %{}) do
    {:ok, login} =
      attrs
      |> Enum.into(%{
        email: "some email",
        password: "some password"
      })
      |> Cdpf.Accounts.create_login()

    login
  end
end
