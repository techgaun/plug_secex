defmodule PlugSecex do
  @moduledoc """
  PlugSecex adds sensible HTTP headers to secure the web applications written in Elixir.

  ## Example

      pipeline :browser do
        plug PlugSecex
      end

  You can also specify to override or disable particular set of headers.

      pipeline :browser do
        plug PlugSecex,
          overrides: [
            "x-dns-prefetch-control": "on",
            "x-frame-options": "DENY",
            "custom-header": "value"
          ],
          except: [
            "x-powered-by"
          ]
      end

  The supported headers and their values by default are:

      "x-content-type-options": "nosniff",
      "x-dns-prefetch-control": "off",
      "strict-transport-security": "max-age=31536000",
      "x-xss-protection": "1; mode=block",
      "x-frame-options": "SAMEORIGIN",
      "content-security-policy": "default-src 'self'; script-src 'self' 'unsafe-inline' 'unsafe-eval'; style-src 'self' 'unsafe-inline' 'unsafe-eval'"

  The headers that are removed by default are:

      "x-powered-by",
      "server"
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
