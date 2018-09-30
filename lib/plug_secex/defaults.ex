defmodule PlugSecex.Defaults do
  @moduledoc """
  Module giving default values for HTTP headers
  """

  @set_defaults [
    server: "",
    "x-content-type-options": "nosniff",
    "x-dns-prefetch-control": "off",
    "strict-transport-security": "max-age=31536000",
    "x-xss-protection": "1; mode=block",
    "x-frame-options": "SAMEORIGIN",
    "content-security-policy":
      "default-src 'self'; script-src 'self' 'unsafe-inline' 'unsafe-eval'; style-src 'self' 'unsafe-inline' 'unsafe-eval'",
    "cross-origin-window-policy": "deny",
    "x-download-options": "noopen",
    "x-permitted-cross-domain-policies": "none"
  ]

  @delete_defaults [
    :"x-powered-by"
  ]

  def to_set, do: @set_defaults
  def to_delete, do: @delete_defaults
end
