defmodule PlugSecex.HeaderTransform do
  @moduledoc """
  Module to operate on the %Plug.Conn{} struct

  This module can perform set and delete operation 
  """

  import Plug.Conn, only: [delete_resp_header: 2, update_resp_header: 4]

  @doc """
  Set given list of key-value pairs in response header
  """
  def set(conn, nil), do: conn

  @doc """
  Delete given key from response header
  """
  defp delete(conn, k) when is_bitstring(k) do
    delete_resp_header(conn, k)
  end
  defp delete(conn, _k), do: conn

  defp _set(conn, k, v) when is_bitstring(v) do
    update_resp_header(conn, k, v, fn(_) -> v end)
  end
  defp _set(conn, _k, _v), do: conn
end
