import Config

# Code generator configuration
config :oapi_generator,
  default: [
    base_location: "lib/",
    base_module: GitHub,
    group: [
      Actions,
      Actions.Runner,
      Actions.Workflow,
      AdvancedSecurity,
      Alert,
      Branch,
      Check,
      CodeOfConduct,
      CodeScanning,
      Codespace,
      Commit,
      Content,
      Dependabot,
      Dependabot.Alert,
      Deployment,
      Gist,
      Git,
      Hook,
      Installation,
      Interaction,
      Interaction.Limit,
      Issue,
      License,
      Marketplace,
      Organization,
      Organization.ProgrammaticAccessGrant,
      Pages,
      Project,
      ProtectedBranch,
      PullRequest,
      RateLimit,
      Reaction,
      Release,
      Repository,
      Repository.Advisory,
      Repository.Rule.Set.Conditions,
      Runner,
      SCIM,
      SecretScanning,
      Team,
      Timeline,
      User,
      Webhook,
      Webhook.Config
    ],
    merge: [
      {~r/^Full/, ""},
      {~r/Full$/, ""},
      {~r/^Minimal/, ""},
      {~r/Minimal$/, ""},
      {~r/^Simple/, ""},
      {~r/Simple$/, ""},
      {"PrivateUser", "User"},
      {"PublicUser", "User"}
    ],
    operation_location: "operations/",
    rename: [
      {~r/^Codespaces/, "Codespace"},
      {"GitignoreTemplate", "GitIgnoreTemplate"},
      {"Job", "Actions.Job"},
      {~r/Oidc/, "OIDC"},
      {~r/Page([A-Z])/, "Pages\\1"},
      {~r/RepositoryRule([A-Z])/, "RepositoryRule.\\1"},
      {~r/(Org|Repository)Ruleset([A-Z])/, "\\1Ruleset.\\2"},
      {~r/^Runner/, "Actions.Runner"},
      {~r/^Scim/, "SCIM"},
      {~r/^Ssh/, "SSH"},
      {~r/^Workflow/, "Actions.Workflow"}
    ],
    schema_location: "schemas/",
    types: [
      error: {GitHub.Error, :t}
    ]
  ]

# Test configuration
config :oapi_github,
  app_name: "Test App",
  default_auth: {"client_one", "abc123"}
