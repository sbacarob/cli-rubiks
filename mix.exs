defmodule RubiksTimer.MixProject do
  use Mix.Project

  def project do
    [
      app: :rubiks_timer,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
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
      #{:ratatouille, "~> 0.4.2"},
      {:ratatouille, git: "https://github.com/ndreynolds/ratatouille"},
    ]
  end
end
