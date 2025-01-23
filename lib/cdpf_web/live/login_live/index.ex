defmodule CdpfWeb.LoginLive.Index do
  use CdpfWeb, :live_view

  alias HTTPoison

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, email: "", password: "", error: nil)}
  end


  @impl true
  def handle_info({CdpfWeb.LoginLive.FormComponent, {:saved, login}}, socket) do
    {:noreply, stream_insert(socket, :login_collection, login)}
  end

  @impl true
  def handle_event("submit", %{"email" => email, "password" => password}, socket) do
    case login_user(email, password) do
      {:ok, token} ->
        # Redirect or save token in session
        {:noreply, push_redirect(socket, to: "/dashboard")}

      {:error, reason} ->
        {:noreply, assign(socket, error: reason)}
    end
  end

  defp login_user(email, password) do
    url = "http://your-backend-url/api/login"
    body = Jason.encode!(%{email: email, password: password})
    headers = [{"Content-Type", "application/json"}]

    case HTTPoison.post(url, body, headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: response_body}} ->
        {:ok, Jason.decode!(response_body)["token"]}

      {:ok, %HTTPoison.Response{status_code: 401, body: _}} ->
        {:error, "Invalid credentials"}

      _ ->
        {:error, "An error occurred"}
    end
  end

end
