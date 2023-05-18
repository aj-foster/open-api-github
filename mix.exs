defmodule GitHub.MixProject do
  use Mix.Project

  @version "0.0.12"
  @source_url "https://github.com/aj-foster/open-api-github"

  def project do
    [
      app: :oapi_github,
      version: @version,
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      name: "GitHub REST API Client",
      source_url: @source_url,
      homepage_url: @source_url,
      deps: deps(),
      docs: docs(),
      package: package()
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
      {:ex_doc, "~> 0.29", only: :dev, runtime: false},
      {:faker, "~> 0.15"},
      {:jason, "~> 1.0", optional: true},
      {:httpoison, "~> 1.7 or ~> 2.0", optional: true},
      {:oapi_generator, "0.0.6", only: [:dev, :test], runtime: false},
      {:redix, "~> 1.0", optional: true}
    ]
  end

  defp docs do
    [
      main: "readme",
      extras: [
        "README.md": [title: "Overview"],
        "CODE_OF_CONDUCT.md": [title: "Code of Conduct"],
        "CONTRIBUTING.md": [title: "Contributing"],
        LICENSE: [title: "License"]
      ],
      groups_for_modules: [
        Client: [
          GitHub,
          GitHub.Auth,
          GitHub.Config,
          GitHub.Error,
          GitHub.Operation
        ],
        Testing: [
          ~r/GitHub.Testing/,
          GitHub.Plugin.TestClient
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
          GitHub.Orgs,
          GitHub.Packages,
          GitHub.Projects,
          GitHub.Pulls,
          GitHub.RateLimit,
          GitHub.Reactions,
          GitHub.Repos,
          GitHub.Search,
          GitHub.SecretScanning,
          GitHub.SecurityAdvisories,
          GitHub.Teams,
          GitHub.Users
        ],
        Schemas: ~r//
      ]
    ]
  end

  defp package do
    [
      description: "GitHub REST API Client for Elixir",
      files: [
        ".api-version",
        ".formatter.exs",
        "lib",
        "LICENSE",
        "mix.exs",
        "README.md"
      ],
      licenses: ["MIT"],
      links: %{"GitHub" => @source_url, "Sponsor" => "https://github.com/sponsors/aj-foster"},
      maintainers: ["AJ Foster"]
    ]
  end
end
