defmodule PlugSecexTest do
  use ExUnit.Case
  use Plug.Test

  alias PlugSecex

  doctest PlugSecex

  setup do
    conn = conn(:get, "/", "id=1")
    {:ok, %{conn: conn}}
  end

  test "Adds default security headers", %{conn: conn} do
    conn = PlugSecex.call(conn, PlugSecex.init([]))
    assert Enum.member?(conn.resp_headers, {"strict-transport-security", "max-age=31536000"})
    assert Enum.member?(conn.resp_headers, {"x-dns-prefetch-control", "off"})
  end

  test "overrides with any custom header", %{conn: conn} do
    conn = PlugSecex.call(conn, PlugSecex.init([overrides: ["x-dns-prefetch-control": "on"]]))
    assert Enum.member?(conn.resp_headers, {"x-dns-prefetch-control", "on"})
  end

  test "except works appropriately", %{conn: conn} do
    conn = PlugSecex.call(conn, PlugSecex.init([except: ["x-dns-prefetch-control"]]))
    assert Enum.member?(conn.resp_headers, {"x-dns-prefetch-control", "on"}) === false
    assert Enum.member?(conn.resp_headers, {"x-dns-prefetch-control", "off"}) === false
  end

  test "except takes priority over overrides & they work together", %{conn: conn} do
    conn = PlugSecex.call(conn, PlugSecex.init([overrides: ["x-dns-prefetch-control": "on"], except: ["x-dns-prefetch-control"]]))
    assert Enum.member?(conn.resp_headers, {"x-dns-prefetch-control", "on"}) === false
    assert Enum.member?(conn.resp_headers, {"x-dns-prefetch-control", "off"}) === false
    conn = PlugSecex.call(conn, PlugSecex.init([overrides: ["xyz": "abc"], except: ["x-dns-prefetch-control"]]))
    assert Enum.member?(conn.resp_headers, {"x-dns-prefetch-control", "on"}) === false
    assert Enum.member?(conn.resp_headers, {"x-dns-prefetch-control", "off"}) === false
    assert Enum.member?(conn.resp_headers, {"xyz", "abc"})
  end

  test "handles invalid entries", %{conn: conn} do
    conn = PlugSecex.call(conn, PlugSecex.init([overrides: ["abc": "on", "xyz": nil]]))
    assert Enum.member?(conn.resp_headers, {"xyz", nil}) === false
  end
end
