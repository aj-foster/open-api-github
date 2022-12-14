defmodule GitHub.Contributor do
  @moduledoc """
  Provides struct and type for Contributor
  """

  @type t :: %__MODULE__{
          avatar_url: String.t() | nil,
          contributions: integer,
          email: String.t() | nil,
          events_url: String.t() | nil,
          followers_url: String.t() | nil,
          following_url: String.t() | nil,
          gists_url: String.t() | nil,
          gravatar_id: String.t() | nil,
          html_url: String.t() | nil,
          id: integer | nil,
          login: String.t() | nil,
          name: String.t() | nil,
          node_id: String.t() | nil,
          organizations_url: String.t() | nil,
          received_events_url: String.t() | nil,
          repos_url: String.t() | nil,
          site_admin: boolean | nil,
          starred_url: String.t() | nil,
          subscriptions_url: String.t() | nil,
          type: String.t(),
          url: String.t() | nil
        }

  defstruct [
    :avatar_url,
    :contributions,
    :email,
    :events_url,
    :followers_url,
    :following_url,
    :gists_url,
    :gravatar_id,
    :html_url,
    :id,
    :login,
    :name,
    :node_id,
    :organizations_url,
    :received_events_url,
    :repos_url,
    :site_admin,
    :starred_url,
    :subscriptions_url,
    :type,
    :url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      avatar_url: :string,
      contributions: :integer,
      email: :string,
      events_url: :string,
      followers_url: :string,
      following_url: :string,
      gists_url: :string,
      gravatar_id: :string,
      html_url: :string,
      id: :integer,
      login: :string,
      name: :string,
      node_id: :string,
      organizations_url: :string,
      received_events_url: :string,
      repos_url: :string,
      site_admin: :boolean,
      starred_url: :string,
      subscriptions_url: :string,
      type: :string,
      url: :string
    ]
  end
end
