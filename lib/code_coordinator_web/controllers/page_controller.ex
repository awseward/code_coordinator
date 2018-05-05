defmodule CodeCoordinatorWeb.PageController do
  use CodeCoordinatorWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
