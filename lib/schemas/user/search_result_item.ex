defmodule GitHub.User.SearchResultItem do
  @moduledoc """
  Provides struct and type for UserSearchResultItem
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          avatar_url: String.t(),
          bio: String.t() | nil,
          blog: String.t() | nil,
          company: String.t() | nil,
          created_at: String.t() | nil,
          email: String.t() | nil,
          events_url: String.t(),
          followers: integer | nil,
          followers_url: String.t(),
          following: integer | nil,
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
          public_gists: integer | nil,
          public_repos: integer | nil,
          received_events_url: String.t(),
          repos_url: String.t(),
          score: number,
          site_admin: boolean,
          starred_url: String.t(),
          subscriptions_url: String.t(),
          suspended_at: String.t() | nil,
          text_matches: [map] | nil,
          type: String.t(),
          updated_at: String.t() | nil,
          url: String.t()
        }

  defstruct [
    :__info__,
    :avatar_url,
    :bio,
    :blog,
    :company,
    :created_at,
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
    :location,
    :login,
    :name,
    :node_id,
    :organizations_url,
    :public_gists,
    :public_repos,
    :received_events_url,
    :repos_url,
    :score,
    :site_admin,
    :starred_url,
    :subscriptions_url,
    :suspended_at,
    :text_matches,
    :type,
    :updated_at,
    :url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      avatar_url: :string,
      bio: {:nullable, :string},
      blog: {:nullable, :string},
      company: {:nullable, :string},
      created_at: :string,
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
      public_gists: :integer,
      public_repos: :integer,
      received_events_url: :string,
      repos_url: :string,
      score: :number,
      site_admin: :boolean,
      starred_url: :string,
      subscriptions_url: :string,
      suspended_at: {:nullable, :string},
      text_matches: {:array, :map},
      type: :string,
      updated_at: :string,
      url: :string
    ]
  end
end
