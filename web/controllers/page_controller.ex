defmodule BackgroundScores.PageController do
  use BackgroundScores.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
