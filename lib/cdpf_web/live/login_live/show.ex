defmodule CdpfWeb.LoginLive.Show do
  use CdpfWeb, :live_view

  alias Cdpf.Accounts

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:login, Accounts.get_login!(id))}
  end

  defp page_title(:show), do: "Show Login"
  defp page_title(:edit), do: "Edit Login"
end
