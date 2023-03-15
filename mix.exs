defmodule MapWithIndifferentAccess.MixProject do
  use Mix.Project

  def project do
    [
      app: :map_with_indifferent_access,
      version: "1.0.0",
      elixir: "~> 1.13",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      description:
        "Utility functions making it easier to work with maps which can either have atom keys or string keys, but never both.",
      package: [
        files: ["lib", ".formatter.exs", "mix.exs", "README*", "LICENSE*"],
        licenses: ["Apache-2.0"],
        links: %{
          "Source code" => "https://github.com/allegro/map-with-indifferent-access",
          "Documentation" => "https://hexdocs.pm/map_with_indifferent_access"
        }
      ],
      docs: [
        main: "readme",
        source_url: "https://github.com/allegro/map-with-indifferent-access",
        extras: ["README.md"]
      ],
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:dialyxir, "~> 1.0", only: [:dev, :test], runtime: false},
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.27", only: :dev, runtime: false}
    ]
  end
end
