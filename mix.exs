defmodule SimpleCardBrand.MixProject do
  use Mix.Project

  @source_url "https://github.com/rgacote/SimpleCardBrand"
  @version "1.0.0"
  def project do
    [
      app: :simplecardbrand,
      version: @version,
      elixir: "~> 1.14",
      build_embedded: Mix.env() == :prod,
      escript: [main_module: Commandline.CLI],
      description: "Identify card brands",
      package: package(),
      deps: deps(),

      # Docs
      name: "SimpleCardBrand",
      docs: docs()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:stream_data, "~> 0.6", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.21", only: :dev, runtime: false},
      {:dialyxir, "~> 0.5", only: [:dev], runtime: false}

      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Raymond GA Côté"],
      licenses: ["BSD-3-Clause"],
      links: %{"GitHub" => "https://github.com/rgacote/SimpleCardBrand"}
    ]
  end

  # Example
  # https://github.com/elixir-ecto/ecto/blob/b275ef25349b14ee0e01da7388dea544fecc1fc2/mix.exs
  defp docs do
    [
      main: "SimpleCardBrand",
      source_ref: "v#{@version}",
      source_url: @source_url,
      extra_section: "GUIDES",
      skip_undefined_reference_warnings_on: ["CHANGELOG.md"],
      extras: extras(),
      groups_for_extras: groups_for_extras()
    ]
  end

  defp extras() do
    ["README.md", "CHANGELOG.md"]
  end

  defp groups_for_extras do
    [Introduction: "README.md"]
  end
end
