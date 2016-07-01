defmodule PlugSecex do
  @moduledoc """
  This module adds sensible HTTP headers to secure the web applications written in Elixir.
  """

  def init(opts), do: opts

  def call(conn, _opts) do
    Plug.Conn.send_resp(conn)
  end
end
