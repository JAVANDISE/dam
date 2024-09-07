defmodule JavandiseWeb.PageController do
  use JavandiseWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    # render(conn, :home, layout: false)
    conn
    |> assign_prop(:text, "Hello world")
    |> render_inertia("Dashboard")
  end
end
