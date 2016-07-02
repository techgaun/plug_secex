defmodule PlugSecex do
  @moduledoc """
  PlugSecex adds sensible HTTP headers to secure the web applications written in Elixir.

  ## Example

    pipeline :browser do
      plug PlugSecex
    end
  """
  import PlugSecex.{Defaults, HeaderTransform}

  def init(opts), do: opts

  def call(conn, opts) do
    excepts = (opts[:except] || [])
      |> Enum.map(fn x -> String.to_atom(x) end)
    overrides = opts[:overrides] || []

    conn
    |> process_header(overrides, excepts)
  end

  defp process_header(conn, overrides, except) do
    headers_to_set = to_set
      |> Keyword.merge(overrides)
      |> Keyword.drop(except)
    headers_to_delete = to_delete
      |> Enum.filter(fn x -> Enum.member?(except, x) === false end)
    conn
    |> set(headers_to_set)
    |> delete(headers_to_delete)
  end
end
