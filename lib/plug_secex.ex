defmodule PlugSecex do
  @moduledoc """
  This module adds sensible HTTP headers to secure the web applications written in Phoenix/Elixir.
  """

  import Plug.Conn, only: [delete_resp_header: 2, update_resp_header: 4]

  def init(opts), do: opts

  def call(conn, _opts) do
    Plug.Conn.send_resp(conn)
  end
end
