defmodule MetroWeb.NotificationsLive do
  use Phoenix.LiveView

  alias Metro.Notification.Notification
  alias MetroWeb.SharedView

  def render(assigns) do
    SharedView.render("notifications.html", assigns)
  end


  def mount(session, socket) do
    if connected?(socket) do
      Metro.PubSub.Listener.subscribe(session.current_user)
    end
    user = Metro.Account.get_user!(session.current_user)
    {:ok, fetch(session.current_user, user.pending_notifications, socket)}
  end

  def handle_event("clear", _, socket) do
    IO.puts "clear"
    IO.puts "clear"
    IO.puts "clear"
    IO.puts "clear"
    IO.puts "clear"
    IO.puts "clear"
    IO.puts "clear"
    IO.puts "clear"
    IO.puts "clear"

    {:noreply, update(socket, :pending, &(&1 + 1))}
  end

  def handle_info(
        {Metro.PubSub.Listener, "new_notification", %{notification: notification, to: user, pending: pending}},
        socket
      ) do
    {:noreply, fetch(user, pending, socket)}
  end

  defp fetch(user, pending, socket) do
  {unread, seen} = Enum.split(Notification.for(user), pending)
    assign(socket, seen: seen, unread: unread, pending: pending)
  end
end