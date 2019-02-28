defmodule Vector.Mixfile do
  use Mix.Project

  def project do
    [app: :vector,
     version: "1.0.1",
     elixir: "~> 1.2",
     description: description(),
     package: package(),
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     test_coverage: [tool: ExCoveralls],
     preferred_cli_env: [coveralls: :test],
     dialyzer: [plt_add_apps: [:poison, :mix]],
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

  defp deps do
    [
      {:earmark, "~> 1.0", only: :dev},
      {:ex_doc, "~> 0.18", only: :dev},
      {:benchfella, "~> 0.3", only: :dev},
      {:excoveralls, "~> 0.4", only: :test},
      {:dialyxir, "~> 0.4", only: [:dev], runtime: false},
      {:credo, "~> 0.8", only: [:dev, :test], runtime: false}
    ]
  end

  defp description do
    """
    Library of common vector functions for use in geometric or graphical calculations.
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*"],
      maintainers: ["Powell Kinney"],
      licenses: ["MIT"],
      links: %{ "GitHub" => "https://github.com/pkinney/vector_ex",
                "Docs" => "https://hexdocs.pm/vector/Vector.html"}
    ]
  end
end
