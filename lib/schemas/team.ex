defmodule GitHub.Team do
  @moduledoc """
  Provides struct and types for Team, TeamSimple
  """

  @type simple :: %__MODULE__{
          description: String.t() | nil,
          html_url: String.t(),
          id: integer,
          ldap_dn: String.t() | nil,
          members_url: String.t(),
          name: String.t(),
          node_id: String.t(),
          permission: String.t(),
          privacy: String.t() | nil,
          repositories_url: String.t(),
          slug: String.t(),
          url: String.t()
        }

  @type t :: %__MODULE__{
          description: String.t() | nil,
          html_url: String.t(),
          id: integer,
          members_url: String.t(),
          name: String.t(),
          node_id: String.t(),
          parent: GitHub.Team.simple() | nil,
          permission: String.t(),
          permissions: map | nil,
          privacy: String.t() | nil,
          repositories_url: String.t(),
          slug: String.t(),
          url: String.t()
        }

  defstruct [
    :description,
    :html_url,
    :id,
    :ldap_dn,
    :members_url,
    :name,
    :node_id,
    :parent,
    :permission,
    :permissions,
    :privacy,
    :repositories_url,
    :slug,
    :url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:simple) do
    [
      description: {:nullable, :string},
      html_url: :string,
      id: :integer,
      ldap_dn: :string,
      members_url: :string,
      name: :string,
      node_id: :string,
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
