defmodule GitHub.User do
  @moduledoc """
  Provides struct and types for PrivateUser, PublicUser, SimpleUser
  """

  @type private :: %__MODULE__{
          __info__: map,
          avatar_url: String.t(),
          bio: String.t() | nil,
          blog: String.t() | nil,
          business_plus: boolean | nil,
          collaborators: integer,
          company: String.t() | nil,
          created_at: String.t(),
          disk_usage: integer,
          email: String.t() | nil,
          events_url: String.t(),
          followers: integer,
          followers_url: String.t(),
          following: integer,
          following_url: String.t(),
          gists_url: String.t(),
          gravatar_id: String.t() | nil,
          hireable: boolean | nil,
          html_url: String.t(),
          id: integer,
          ldap_dn: String.t() | nil,
          location: String.t() | nil,
          login: String.t(),
          name: String.t() | nil,
          node_id: String.t(),
          organizations_url: String.t(),
          owned_private_repos: integer,
          plan: map | nil,
          private_gists: integer,
          public_gists: integer,
          public_repos: integer,
          received_events_url: String.t(),
          repos_url: String.t(),
          site_admin: boolean,
          starred_url: String.t(),
          subscriptions_url: String.t(),
          suspended_at: String.t() | nil,
          total_private_repos: integer,
          twitter_username: String.t() | nil,
          two_factor_authentication: boolean,
          type: String.t(),
          updated_at: String.t(),
          url: String.t()
        }

  @type public :: %__MODULE__{
          __info__: map,
          avatar_url: String.t(),
          bio: String.t() | nil,
          blog: String.t() | nil,
          collaborators: integer | nil,
          company: String.t() | nil,
          created_at: String.t(),
          disk_usage: integer | nil,
          email: String.t() | nil,
          events_url: String.t(),
          followers: integer,
          followers_url: String.t(),
          following: integer,
          following_url: String.t(),
          gists_url: String.t(),
          gravatar_id: String.t() | nil,
          hireable: boolean | nil,
          html_url: String.t(),
          id: integer,
          location: String.t() | nil,
          login: String.t(),
          name: String.t() | nil,
          node_id: String.t(),
          organizations_url: String.t(),
          owned_private_repos: integer | nil,
          plan: map | nil,
          private_gists: integer | nil,
          public_gists: integer,
          public_repos: integer,
          received_events_url: String.t(),
          repos_url: String.t(),
          site_admin: boolean,
          starred_url: String.t(),
          subscriptions_url: String.t(),
          suspended_at: String.t() | nil,
          total_private_repos: integer | nil,
          twitter_username: String.t() | nil,
          type: String.t(),
          updated_at: String.t(),
          url: String.t()
        }

  @type simple :: %__MODULE__{
          __info__: map,
          avatar_url: String.t(),
          email: String.t() | nil,
          events_url: String.t(),
          followers_url: String.t(),
          following_url: String.t(),
          gists_url: String.t(),
          gravatar_id: String.t() | nil,
          html_url: String.t(),
          id: integer,
          login: String.t(),
          name: String.t() | nil,
          node_id: String.t(),
          organizations_url: String.t(),
          received_events_url: String.t(),
          repos_url: String.t(),
          site_admin: boolean,
          starred_at: String.t() | nil,
          starred_url: String.t(),
          subscriptions_url: String.t(),
          type: String.t(),
          url: String.t()
        }

  defstruct [
    :__info__,
    :avatar_url,
    :bio,
    :blog,
    :business_plus,
    :collaborators,
    :company,
    :created_at,
    :disk_usage,
    :email,
    :events_url,
    :followers,
    :followers_url,
    :following,
    :following_url,
    :gists_url,
    :gravatar_id,
    :hireable,
    :html_url,
    :id,
    :ldap_dn,
    :location,
    :login,
    :name,
    :node_id,
    :organizations_url,
    :owned_private_repos,
    :plan,
    :private_gists,
    :public_gists,
    :public_repos,
    :received_events_url,
    :repos_url,
    :site_admin,
    :starred_at,
    :starred_url,
    :subscriptions_url,
    :suspended_at,
    :total_private_repos,
    :twitter_username,
    :two_factor_authentication,
    :type,
    :updated_at,
    :url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(:private) do
    [
      avatar_url: :string,
      bio: {:nullable, :string},
      blog: {:nullable, :string},
      business_plus: :boolean,
      collaborators: :integer,
      company: {:nullable, :string},
      created_at: :string,
      disk_usage: :integer,
      email: {:nullable, :string},
      events_url: :string,
      followers: :integer,
      followers_url: :string,
      following: :integer,
      following_url: :string,
      gists_url: :string,
      gravatar_id: {:nullable, :string},
      hireable: {:nullable, :boolean},
      html_url: :string,
      id: :integer,
      ldap_dn: :string,
      location: {:nullable, :string},
      login: :string,
      name: {:nullable, :string},
      node_id: :string,
      organizations_url: :string,
      owned_private_repos: :integer,
      plan: :map,
      private_gists: :integer,
      public_gists: :integer,
      public_repos: :integer,
      received_events_url: :string,
      repos_url: :string,
      site_admin: :boolean,
      starred_url: :string,
      subscriptions_url: :string,
      suspended_at: {:nullable, :string},
      total_private_repos: :integer,
      twitter_username: {:nullable, :string},
      two_factor_authentication: :boolean,
      type: :string,
      updated_at: :string,
      url: :string
    ]
  end

  def __fields__(:public) do
    [
      avatar_url: :string,
      bio: {:nullable, :string},
      blog: {:nullable, :string},
      collaborators: :integer,
      company: {:nullable, :string},
      created_at: :string,
      disk_usage: :integer,
      email: {:nullable, :string},
      events_url: :string,
      followers: :integer,
      followers_url: :string,
      following: :integer,
      following_url: :string,
      gists_url: :string,
      gravatar_id: {:nullable, :string},
      hireable: {:nullable, :boolean},
      html_url: :string,
      id: :integer,
      location: {:nullable, :string},
      login: :string,
      name: {:nullable, :string},
      node_id: :string,
      organizations_url: :string,
      owned_private_repos: :integer,
      plan: :map,
      private_gists: :integer,
      public_gists: :integer,
      public_repos: :integer,
      received_events_url: :string,
      repos_url: :string,
      site_admin: :boolean,
      starred_url: :string,
      subscriptions_url: :string,
      suspended_at: {:nullable, :string},
      total_private_repos: :integer,
      twitter_username: {:nullable, :string},
      type: :string,
      updated_at: :string,
      url: :string
    ]
  end

  def __fields__(:simple) do
    [
      avatar_url: :string,
      email: {:nullable, :string},
      events_url: :string,
      followers_url: :string,
      following_url: :string,
      gists_url: :string,
      gravatar_id: {:nullable, :string},
      html_url: :string,
      id: :integer,
      login: :string,
      name: {:nullable, :string},
      node_id: :string,
      organizations_url: :string,
      received_events_url: :string,
      repos_url: :string,
      site_admin: :boolean,
      starred_at: :string,
      starred_url: :string,
      subscriptions_url: :string,
      type: :string,
      url: :string
    ]
  end
end
