defmodule GitHub.AppPermissions do
  @moduledoc """
  Provides struct and type for AppPermissions
  """

  @type t :: %__MODULE__{
          actions: String.t() | nil,
          administration: String.t() | nil,
          checks: String.t() | nil,
          contents: String.t() | nil,
          deployments: String.t() | nil,
          environments: String.t() | nil,
          issues: String.t() | nil,
          members: String.t() | nil,
          metadata: String.t() | nil,
          organization_administration: String.t() | nil,
          organization_announcement_banners: String.t() | nil,
          organization_custom_roles: String.t() | nil,
          organization_hooks: String.t() | nil,
          organization_packages: String.t() | nil,
          organization_plan: String.t() | nil,
          organization_projects: String.t() | nil,
          organization_secrets: String.t() | nil,
          organization_self_hosted_runners: String.t() | nil,
          organization_user_blocking: String.t() | nil,
          packages: String.t() | nil,
          pages: String.t() | nil,
          pull_requests: String.t() | nil,
          repository_announcement_banners: String.t() | nil,
          repository_hooks: String.t() | nil,
          repository_projects: String.t() | nil,
          secret_scanning_alerts: String.t() | nil,
          secrets: String.t() | nil,
          security_events: String.t() | nil,
          single_file: String.t() | nil,
          statuses: String.t() | nil,
          team_discussions: String.t() | nil,
          vulnerability_alerts: String.t() | nil,
          workflows: String.t() | nil
        }

  defstruct [
    :actions,
    :administration,
    :checks,
    :contents,
    :deployments,
    :environments,
    :issues,
    :members,
    :metadata,
    :organization_administration,
    :organization_announcement_banners,
    :organization_custom_roles,
    :organization_hooks,
    :organization_packages,
    :organization_plan,
    :organization_projects,
    :organization_secrets,
    :organization_self_hosted_runners,
    :organization_user_blocking,
    :packages,
    :pages,
    :pull_requests,
    :repository_announcement_banners,
    :repository_hooks,
    :repository_projects,
    :secret_scanning_alerts,
    :secrets,
    :security_events,
    :single_file,
    :statuses,
    :team_discussions,
    :vulnerability_alerts,
    :workflows
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      actions: :string,
      administration: :string,
      checks: :string,
      contents: :string,
      deployments: :string,
      environments: :string,
      issues: :string,
      members: :string,
      metadata: :string,
      organization_administration: :string,
      organization_announcement_banners: :string,
      organization_custom_roles: :string,
      organization_hooks: :string,
      organization_packages: :string,
      organization_plan: :string,
      organization_projects: :string,
      organization_secrets: :string,
      organization_self_hosted_runners: :string,
      organization_user_blocking: :string,
      packages: :string,
      pages: :string,
      pull_requests: :string,
      repository_announcement_banners: :string,
      repository_hooks: :string,
      repository_projects: :string,
      secret_scanning_alerts: :string,
      secrets: :string,
      security_events: :string,
      single_file: :string,
      statuses: :string,
      team_discussions: :string,
      vulnerability_alerts: :string,
      workflows: :string
    ]
  end
end
