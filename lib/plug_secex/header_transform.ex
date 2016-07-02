defmodule PlugSecex.HeaderTransform do
  @moduledoc """
  Module to operate on the %Plug.Conn{} struct

  This module can perform set and delete operation 
  """

  import Plug.Conn, only: [delete_resp_header: 2, update_resp_header: 4]

  @doc """
  Set given list of key-value pairs in response header
  """
  def set(conn, headers) when is_list(headers) do
    List.foldl(headers, conn, fn ({k, v}, conn) ->
      _set(conn, Atom.to_string(k), v)
    end)
  end

  @doc """
  Delete given list of keys from response header
  """
  def delete(conn, headers) when is_list(headers) do
    List.foldl(headers, conn, fn (k, conn) ->
      _delete(conn, Atom.to_string(k))
    end)
  end

  defp _set(conn, k, v) when is_bitstring(v) do
    update_resp_header(conn, k, v, fn(_) -> v end)
  end
  defp _set(conn, _k, _v), do: conn

  defp _delete(conn, k) when is_bitstring(k) do
    delete_resp_header(conn, k)
  end
  defp _delete(conn, _k), do: conn
end
