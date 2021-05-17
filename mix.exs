defmodule Vector.Mixfile do
  use Mix.Project

  @source_url "https://github.com/pkinney/vector_ex"
  @version "1.0.1"

  def project do
    [
      app: :vector,
      version: @version,
      elixir: "~> 1.2",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [coveralls: :test],
      dialyzer: [plt_add_apps: [:poison, :mix]],
      package: package(),
      deps: deps(),
      docs: docs()
    ]
  end

  def application do
    [
      applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:benchfella, "~> 0.3", only: :dev},
      {:excoveralls, "~> 0.4", only: :test},
      {:dialyxir, "~> 0.4", only: [:dev], runtime: false},
      {:credo, "~> 0.8", only: [:dev, :test], runtime: false}
    ]
  end

  defp package do
    [
      description:
        "Library of common vector functions for use in geometric or graphical calculations.",
      files: ["lib", "mix.exs", "README*"],
      maintainers: ["Powell Kinney"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => @source_url,
      }
    ]
  end

  defp docs do
    [
      extras: [
        "LICENSE.md": [title: "License"],
        "README.md": [title: "Overview"]
      ],
      main: "readme",
      source_url: @source_url,
      api_reference: false,
      formatters: ["html"]
    ]
  end
end
