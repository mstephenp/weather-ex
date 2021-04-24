defmodule WexWeb.PageLiveTest do
  use WexWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "Current Weather"
    assert render(page_live) =~ "Current Weather"
  end
end
