defmodule GitHub.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :oapi_github,
      version: @version,
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs()
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

  defp docs do
    [
      main: "readme",
      extras: [
        "README.md": [title: "Overview"]
      ],
      groups_for_modules: [
        Client: [
          GitHub,
          GitHub.Auth,
          GitHub.Config,
          GitHub.Error,
          GitHub.Operation
        ],
        Plugins: ~r/GitHub.Plugin/,
        Operations: [
          GitHub.Actions,
          GitHub.Activity,
          GitHub.Apps,
          GitHub.Billing,
          GitHub.Checks,
          GitHub.CodeScanning,
          GitHub.CodesOfConduct,
          GitHub.Codespaces,
          GitHub.Dependabot,
          GitHub.DependencyGraph,
          GitHub.Emojis,
          GitHub.EnterpriseAdmin,
          GitHub.Gists,
          GitHub.Git,
          GitHub.Gitignore,
          GitHub.Interactions,
          GitHub.Issues,
          GitHub.Licenses,
          GitHub.Markdown,
          GitHub.Meta,
          GitHub.Migrations,
          GitHub.Oidc,
          GitHub.Packages,
          GitHub.Projects,
          GitHub.Pulls,
          GitHub.RateLimit,
          GitHub.Reactions,
          GitHub.Repos,
          GitHub.Search,
          GitHub.SecretScanning,
          GitHub.ServerStatistics,
          GitHub.Teams,
          GitHub.Users
        ],
        Schemas: ~r//
      ]
    ]
  end
end
