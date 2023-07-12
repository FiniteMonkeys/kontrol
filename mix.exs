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
      credo: ["format", "credo --strict"],
      test: ["format", "espec"]
    ]
  end

  defp deps do
    [
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.3", only: [:dev, :test], runtime: false},
      {:espec, "~> 1.9", only: :test},
      {:ex_doc, "~> 0.30.2", only: [:dev, :test], runtime: false},
      {:pid_controller, "~> 0.1.2"},
      {:space_ex,
       git: "https://github.com/CraigCottingham/space_ex.git",
       ref: "4fcde3576fa2a55a3477bdd24a0f8c891bbd4a25"}
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
