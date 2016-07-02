defmodule PlugSecex.Defaults do
  @moduledoc """
  Module giving default values for HTTP headers
  """

  @set_defaults [
    "X-Content-Type-Options": "nosniff",
    "X-DNS-Prefetch-Control": "off"
  ]

  @delete_defaults [
    "X-Powered-By"
  ]

  def to_set, do: @set_defaults

end
