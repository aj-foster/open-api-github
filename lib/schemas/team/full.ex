defmodule GitHub.Team.Full do
  @moduledoc """
  Provides struct and type for TeamFull
  """

  @type t :: %__MODULE__{
          created_at: String.t(),
          description: String.t() | nil,
          html_url: String.t(),
          id: integer,
          ldap_dn: String.t() | nil,
          members_count: integer,
          members_url: String.t(),
          name: String.t(),
          node_id: String.t(),
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

  defstruct [
    :created_at,
    :description,
    :html_url,
    :id,
    :ldap_dn,
    :members_count,
    :members_url,
    :name,
    :node_id,
    :organization,
    :parent,
    :permission,
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

  def __fields__(:t) do
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
end
