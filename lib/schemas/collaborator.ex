defmodule GitHub.Collaborator do
  @moduledoc """
  Provides struct and type for Collaborator
  """

  @type t :: %__MODULE__{
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
          permissions: map | nil,
          received_events_url: String.t(),
          repos_url: String.t(),
          role_name: String.t(),
          site_admin: boolean,
          starred_url: String.t(),
          subscriptions_url: String.t(),
          type: String.t(),
          url: String.t()
        }

  defstruct [
    :__info__,
    :avatar_url,
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
    :permissions,
    :received_events_url,
    :repos_url,
    :role_name,
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
      permissions: :map,
      received_events_url: :string,
      repos_url: :string,
      role_name: :string,
      site_admin: :boolean,
      starred_url: :string,
      subscriptions_url: :string,
      type: :string,
      url: :string
    ]
  end
end
