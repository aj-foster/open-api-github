defmodule GitHub.Organization.Full do
  @moduledoc """
  Provides struct and type for OrganizationFull
  """

  @type t :: %__MODULE__{
          advanced_security_enabled_for_new_repositories: boolean | nil,
          avatar_url: String.t(),
          billing_email: String.t() | nil,
          blog: String.t() | nil,
          collaborators: integer | nil,
          company: String.t() | nil,
          created_at: String.t(),
          default_repository_permission: String.t() | nil,
          dependabot_alerts_enabled_for_new_repositories: boolean | nil,
          dependabot_security_updates_enabled_for_new_repositories: boolean | nil,
          dependency_graph_enabled_for_new_repositories: boolean | nil,
          description: String.t() | nil,
          disk_usage: integer | nil,
          email: String.t() | nil,
          events_url: String.t(),
          followers: integer,
          following: integer,
          has_organization_projects: boolean,
          has_repository_projects: boolean,
          hooks_url: String.t(),
          html_url: String.t(),
          id: integer,
          is_verified: boolean | nil,
          issues_url: String.t(),
          location: String.t() | nil,
          login: String.t(),
          members_allowed_repository_creation_type: String.t() | nil,
          members_can_create_internal_repositories: boolean | nil,
          members_can_create_pages: boolean | nil,
          members_can_create_private_pages: boolean | nil,
          members_can_create_private_repositories: boolean | nil,
          members_can_create_public_pages: boolean | nil,
          members_can_create_public_repositories: boolean | nil,
          members_can_create_repositories: boolean | nil,
          members_can_fork_private_repositories: boolean | nil,
          members_url: String.t(),
          name: String.t() | nil,
          node_id: String.t(),
          owned_private_repos: integer | nil,
          plan: map | nil,
          private_gists: integer | nil,
          public_gists: integer,
          public_members_url: String.t(),
          public_repos: integer,
          repos_url: String.t(),
          secret_scanning_enabled_for_new_repositories: boolean | nil,
          secret_scanning_push_protection_custom_link: String.t() | nil,
          secret_scanning_push_protection_custom_link_enabled: boolean | nil,
          secret_scanning_push_protection_enabled_for_new_repositories: boolean | nil,
          total_private_repos: integer | nil,
          twitter_username: String.t() | nil,
          two_factor_requirement_enabled: boolean | nil,
          type: String.t(),
          updated_at: String.t(),
          url: String.t(),
          web_commit_signoff_required: boolean | nil
        }

  defstruct [
    :advanced_security_enabled_for_new_repositories,
    :avatar_url,
    :billing_email,
    :blog,
    :collaborators,
    :company,
    :created_at,
    :default_repository_permission,
    :dependabot_alerts_enabled_for_new_repositories,
    :dependabot_security_updates_enabled_for_new_repositories,
    :dependency_graph_enabled_for_new_repositories,
    :description,
    :disk_usage,
    :email,
    :events_url,
    :followers,
    :following,
    :has_organization_projects,
    :has_repository_projects,
    :hooks_url,
    :html_url,
    :id,
    :is_verified,
    :issues_url,
    :location,
    :login,
    :members_allowed_repository_creation_type,
    :members_can_create_internal_repositories,
    :members_can_create_pages,
    :members_can_create_private_pages,
    :members_can_create_private_repositories,
    :members_can_create_public_pages,
    :members_can_create_public_repositories,
    :members_can_create_repositories,
    :members_can_fork_private_repositories,
    :members_url,
    :name,
    :node_id,
    :owned_private_repos,
    :plan,
    :private_gists,
    :public_gists,
    :public_members_url,
    :public_repos,
    :repos_url,
    :secret_scanning_enabled_for_new_repositories,
    :secret_scanning_push_protection_custom_link,
    :secret_scanning_push_protection_custom_link_enabled,
    :secret_scanning_push_protection_enabled_for_new_repositories,
    :total_private_repos,
    :twitter_username,
    :two_factor_requirement_enabled,
    :type,
    :updated_at,
    :url,
    :web_commit_signoff_required
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      advanced_security_enabled_for_new_repositories: :boolean,
      avatar_url: :string,
      billing_email: {:nullable, :string},
      blog: :string,
      collaborators: {:nullable, :integer},
      company: :string,
      created_at: :string,
      default_repository_permission: {:nullable, :string},
      dependabot_alerts_enabled_for_new_repositories: :boolean,
      dependabot_security_updates_enabled_for_new_repositories: :boolean,
      dependency_graph_enabled_for_new_repositories: :boolean,
      description: {:nullable, :string},
      disk_usage: {:nullable, :integer},
      email: :string,
      events_url: :string,
      followers: :integer,
      following: :integer,
      has_organization_projects: :boolean,
      has_repository_projects: :boolean,
      hooks_url: :string,
      html_url: :string,
      id: :integer,
      is_verified: :boolean,
      issues_url: :string,
      location: :string,
      login: :string,
      members_allowed_repository_creation_type: :string,
      members_can_create_internal_repositories: :boolean,
      members_can_create_pages: :boolean,
      members_can_create_private_pages: :boolean,
      members_can_create_private_repositories: :boolean,
      members_can_create_public_pages: :boolean,
      members_can_create_public_repositories: :boolean,
      members_can_create_repositories: {:nullable, :boolean},
      members_can_fork_private_repositories: {:nullable, :boolean},
      members_url: :string,
      name: :string,
      node_id: :string,
      owned_private_repos: :integer,
      plan: :map,
      private_gists: {:nullable, :integer},
      public_gists: :integer,
      public_members_url: :string,
      public_repos: :integer,
      repos_url: :string,
      secret_scanning_enabled_for_new_repositories: :boolean,
      secret_scanning_push_protection_custom_link: {:nullable, :string},
      secret_scanning_push_protection_custom_link_enabled: :boolean,
      secret_scanning_push_protection_enabled_for_new_repositories: :boolean,
      total_private_repos: :integer,
      twitter_username: {:nullable, :string},
      two_factor_requirement_enabled: {:nullable, :boolean},
      type: :string,
      updated_at: :string,
      url: :string,
      web_commit_signoff_required: :boolean
    ]
  end
end
