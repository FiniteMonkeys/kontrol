defmodule Kontrol.MixProject do
  @moduledoc false

  use Mix.Project

  def project do
    [
      app: :kontrol,
      version: "0.1.0",
      name: "Kontrol",
      description: description(),
      source_url: "http://github.com/FiniteMonkeys/kontrol",
      homepage_url: "http://github.com/FiniteMonkeys/kontrol",
      package: package(),
      elixir: "~> 1.9",
      elixirc_options: [warnings_as_errors: true],
      elixirc_paths: elixirc_paths(Mix.env()),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      preferred_cli_env: [espec: :test],
      aliases: aliases(),
      deps: deps()
    ]
  end

  def application do
    [
      mod: {Kontrol.Application, []},
      extra_applications: [:logger]
    ]
  end

  defp aliases do
    [
      credo: ["credo --strict"],
      test: ["format", "credo --strict", "dialyzer", "espec"]
    ]
  end

  defp deps do
    [
      {:credo, "~> 1.1", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0.0-rc.7", only: [:dev, :test], runtime: false},
      {:espec, "~> 1.8", only: :test},
      {:ex_doc, "~> 0.24.0", only: [:dev, :test], runtime: false},
      {:pid_controller, "~> 0.1.2"},
      {:space_ex, "~> 0.8.0"}
    ]
  end

  defp description, do: "An exploration of control theory, using Kerbal Space Program."

  defp elixirc_paths(:test), do: ["lib"]
  defp elixirc_paths(_), do: ["lib"]

  defp package do
    [
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/FiniteMonkeys/kontrol"}
    ]
  end
end
