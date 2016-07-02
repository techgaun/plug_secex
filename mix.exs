defmodule PlugSecex.Mixfile do
  use Mix.Project

  def project do
    [app: :plug_secex,
     version: "0.1.0",
     elixir: "~> 1.2",
     description: "A module to insert sensible security headers",
     package: package,
     test_coverage: [tool: ExCoveralls],
     preferred_cli_env: ["coveralls": :test, "coveralls.detail": :test, "coveralls.post": :test, "coveralls.html": :test],
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     docs: [],
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:plug, ">= 1.0.0"},
      {:excoveralls, "~> 0.5", only: :test},
      {:ex_doc, "~> 0.12", only: :dev}
    ]
  end
  defp package do
    [
      maintainers: [
        "Samar Acharya"
      ],
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/techgaun/plug_secex"}
    ]
  end
end
