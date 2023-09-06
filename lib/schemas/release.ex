defmodule GitHub.Release do
  @moduledoc """
  Provides struct and type for Release
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          assets: [GitHub.Release.Asset.t()],
          assets_url: String.t(),
          author: GitHub.User.simple(),
          body: String.t() | nil,
          body_html: String.t() | nil,
          body_text: String.t() | nil,
          created_at: String.t(),
          discussion_url: String.t() | nil,
          draft: boolean,
          html_url: String.t(),
          id: integer,
          mentions_count: integer | nil,
          name: String.t() | nil,
          node_id: String.t(),
          prerelease: boolean,
          published_at: String.t() | nil,
          reactions: GitHub.Reaction.Rollup.t() | nil,
          tag_name: String.t(),
          tarball_url: String.t() | nil,
          target_commitish: String.t(),
          upload_url: String.t(),
          url: String.t(),
          zipball_url: String.t() | nil
        }

  defstruct [
    :__info__,
    :assets,
    :assets_url,
    :author,
    :body,
    :body_html,
    :body_text,
    :created_at,
    :discussion_url,
    :draft,
    :html_url,
    :id,
    :mentions_count,
    :name,
    :node_id,
    :prerelease,
    :published_at,
    :reactions,
    :tag_name,
    :tarball_url,
    :target_commitish,
    :upload_url,
    :url,
    :zipball_url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      assets: {:array, {GitHub.Release.Asset, :t}},
      assets_url: :string,
      author: {GitHub.User, :simple},
      body: {:nullable, :string},
      body_html: :string,
      body_text: :string,
      created_at: :string,
      discussion_url: :string,
      draft: :boolean,
      html_url: :string,
      id: :integer,
      mentions_count: :integer,
      name: {:nullable, :string},
      node_id: :string,
      prerelease: :boolean,
      published_at: {:nullable, :string},
      reactions: {GitHub.Reaction.Rollup, :t},
      tag_name: :string,
      tarball_url: {:nullable, :string},
      target_commitish: :string,
      upload_url: :string,
      url: :string,
      zipball_url: {:nullable, :string}
    ]
  end
end
