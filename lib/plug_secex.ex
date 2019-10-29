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

  If you need to determine one of these at run time - for instance, in order to
  use a content security policy that allows resources from a location
  configured in environment variables - you can pass a "module, function,
  arguments" tuple; calling that function with those arguments must return a
  list as shown in the previous example.

      pipeline :browser do
        plug PlugSecex,
          overrides: {MyModule, :overrides, [arg1, arg2]},
          except: {MyModule, :exceptions, [arg3]}
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
    overrides = expand_option(opts[:overrides])

    excepts =
      expand_option(opts[:except])
      |> Enum.map(fn x -> String.to_atom(x) end)

    conn
    |> process_header(overrides, excepts)
  end

  defp expand_option(value) when is_list(value), do: value

  defp expand_option({module, function, args}) when is_list(args) do
    apply(module, function, args)
  end

  defp expand_option(nil), do: []

  defp expand_option(val) do
    raise(ArgumentError, "invalid header option #{inspect(val)}")
  end

  defp process_header(conn, overrides, except) do
    headers_to_set =
      to_set()
      |> Keyword.merge(overrides)
      |> Keyword.drop(except)

    headers_to_delete =
      to_delete()
      |> Enum.filter(fn x -> Enum.member?(except, x) === false end)

    conn
    |> set(headers_to_set)
    |> delete(headers_to_delete)
  end
end
