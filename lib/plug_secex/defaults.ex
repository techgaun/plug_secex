defmodule PlugSecex.Defaults do
  @moduledoc """
  Module giving default values for HTTP headers
  """

  @set_defaults [
    "X-Content-Type-Options": "nosniff",
    "X-DNS-Prefetch-Control": "off",
    "Strict-Transport-Security": "max-age=31536000",
    "X-Xss-Protection": "1; mode=block",
    "X-Frame-Options": "SAMEORIGIN",
    "Content-Security-Policy": "default-src 'self'; script-src 'self' 'unsafe-inline' 'unsafe-eval'; style-src 'self' 'unsafe-inline' 'unsafe-eval'"
  ]

  @delete_defaults [
    "X-Powered-By",
    "Server"
  ]

  def to_set, do: @set_defaults
  def to_delete, do: @delete_defaults
end
