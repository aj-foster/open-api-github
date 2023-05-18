defmodule GitHub.Team do
  @moduledoc """
  Provides struct and types for Team, TeamFull, TeamSimple
  """

  @type full :: %__MODULE__{
          __info__: map,
          created_at: String.t(),
          description: String.t() | nil,
          html_url: String.t(),
          id: integer,
          ldap_dn: String.t() | nil,
          members_count: integer,
          members_url: String.t(),
          name: String.t(),
          node_id: String.t(),
          notification_setting: String.t() | nil,
          organization: GitHub.Team.Organization.t(),
          parent: GitHub.Team.simple() | nil,
          permission: String.t(),
          privacy: String.t() | nil,
          repos_count: integer,
          repositories_url: String.t(),
          slug: String.t(),
          updated_at: String.t(),
          url: String.t()
        }

  @type simple :: %__MODULE__{
          __info__: map,
          description: String.t() | nil,
          html_url: String.t(),
          id: integer,
          ldap_dn: String.t() | nil,
          members_url: String.t(),
          name: String.t(),
          node_id: String.t(),
          notification_setting: String.t() | nil,
          permission: String.t(),
          privacy: String.t() | nil,
          repositories_url: String.t(),
          slug: String.t(),
          url: String.t()
        }

  @type t :: %__MODULE__{
          __info__: map,
          description: String.t() | nil,
          html_url: String.t(),
          id: integer,
          members_url: String.t(),
          name: String.t(),
          node_id: String.t(),
          notification_setting: String.t() | nil,
          parent: GitHub.Team.simple() | nil,
          permission: String.t(),
          permissions: map | nil,
          privacy: String.t() | nil,
          repositories_url: String.t(),
          slug: String.t(),
          url: String.t()
        }

  defstruct [
    :__info__,
    :created_at,
    :description,
    :html_url,
    :id,
    :ldap_dn,
    :members_count,
    :members_url,
    :name,
    :node_id,
    :notification_setting,
    :organization,
    :parent,
    :permission,
    :permissions,
    :privacy,
    :repos_count,
    :repositories_url,
    :slug,
    :updated_at,
    :url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:full) do
    [
      created_at: :string,
      description: {:nullable, :string},
      html_url: :string,
      id: :integer,
      ldap_dn: :string,
      members_count: :integer,
      members_url: :string,
      name: :string,
      node_id: :string,
      notification_setting: :string,
      organization: {GitHub.Team.Organization, :t},
      parent: {:nullable, {GitHub.Team, :simple}},
      permission: :string,
      privacy: :string,
      repos_count: :integer,
      repositories_url: :string,
      slug: :string,
      updated_at: :string,
      url: :string
    ]
  end

  def __fields__(:simple) do
    [
      description: {:nullable, :string},
      html_url: :string,
      id: :integer,
      ldap_dn: :string,
      members_url: :string,
      name: :string,
      node_id: :string,
      notification_setting: :string,
      permission: :string,
      privacy: :string,
      repositories_url: :string,
      slug: :string,
      url: :string
    ]
  end

  def __fields__(:t) do
    [
      description: {:nullable, :string},
      html_url: :string,
      id: :integer,
      members_url: :string,
      name: :string,
      node_id: :string,
      notification_setting: :string,
      parent: {:nullable, {GitHub.Team, :simple}},
      permission: :string,
      permissions: :map,
      privacy: :string,
      repositories_url: :string,
      slug: :string,
      url: :string
    ]
  end
end
