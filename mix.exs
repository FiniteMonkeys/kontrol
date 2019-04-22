defmodule Kontrol.MixProject do
  use Mix.Project

  def project do
    [
      app: :kontrol,
      version: "0.1.0",
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      preferred_cli_env: [espec: :test],
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Kontrol.Application, []}
    ]
  end

  # Specifies which paths to compile per environment.
  # spec/factories
  defp elixirc_paths(:test), do: ["lib"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.0"},
      {:espec, "~> 1.6", only: :test},
      {:space_ex, "~> 0.8.0"}
    ]
  end

  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      credo: ["credo --strict"],
      test: ["espec"]
    ]
  end
end
