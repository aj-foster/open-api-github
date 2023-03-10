defmodule GitHub.Feed do
  @moduledoc """
  Provides struct and type for Feed
  """

  @type t :: %__MODULE__{
          _links: map,
          current_user_actor_url: String.t() | nil,
          current_user_organization_url: String.t() | nil,
          current_user_organization_urls: [String.t()] | nil,
          current_user_public_url: String.t() | nil,
          current_user_url: String.t() | nil,
          repository_discussions_category_url: String.t() | nil,
          repository_discussions_url: String.t() | nil,
          security_advisories_url: String.t() | nil,
          timeline_url: String.t(),
          user_url: String.t()
        }

  defstruct [
    :_links,
    :current_user_actor_url,
    :current_user_organization_url,
    :current_user_organization_urls,
    :current_user_public_url,
    :current_user_url,
    :repository_discussions_category_url,
    :repository_discussions_url,
    :security_advisories_url,
    :timeline_url,
    :user_url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      _links: :map,
      current_user_actor_url: :string,
      current_user_organization_url: :string,
      current_user_organization_urls: {:array, :string},
      current_user_public_url: :string,
      current_user_url: :string,
      repository_discussions_category_url: :string,
      repository_discussions_url: :string,
      security_advisories_url: :string,
      timeline_url: :string,
      user_url: :string
    ]
  end
end
