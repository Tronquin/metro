defmodule MetroWeb.PageController do
  use MetroWeb, :controller

  alias Metro.Location
  alias Metro.Location.Event

  def index(conn, _params) do
    events = Location.list_events()
    books = Enum.take(Location.list_books(), 4)
    {head, events} = List.pop_at(events, 0)
    render(conn, "index.html", books: books, events: events, head: head)
  end
end
