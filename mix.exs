defmodule GitHub.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :oapi_github,
      version: @version,
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    if Mix.env() == :prod do
      [
        extra_applications: [:logger]
      ]
    else
      [
        extra_applications: [:logger, :hackney]
      ]
    end
  end

  defp deps do
    [
      {:ex_doc, "~> 0.28", only: :dev},
      {:jason, "~> 1.0", optional: true},
      {:httpoison, "~> 1.7", optional: true},
      # {:open_api, github: "aj-foster/open-api-generator", branch: "main", only: :dev}
      {:open_api, path: "/Users/aj/Documents/Projects/aj-foster/open-api-generator", only: :dev},
      {:redix, "~> 1.0", optional: true}
    ]
  end
end
