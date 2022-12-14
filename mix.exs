defmodule GitHub.MixProject do
  use Mix.Project

  def project do
    [
      app: :oapi_github,
      version: "0.1.0",
      elixir: "~> 1.14",
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
      # {:open_api, github: "aj-foster/open-api-generator", branch: "main"}
      {:open_api, path: "/Users/aj/Documents/Projects/aj-foster/open-api-generator"}
    ]
  end
end
