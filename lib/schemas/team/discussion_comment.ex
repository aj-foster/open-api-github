defmodule GitHub.Team.DiscussionComment do
  @moduledoc """
  Provides struct and type for TeamDiscussionComment
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          author: GitHub.User.simple() | nil,
          body: String.t(),
          body_html: String.t(),
          body_version: String.t(),
          created_at: String.t(),
          discussion_url: String.t(),
          html_url: String.t(),
          last_edited_at: String.t() | nil,
          node_id: String.t(),
          number: integer,
          reactions: GitHub.Reaction.Rollup.t() | nil,
          updated_at: String.t(),
          url: String.t()
        }

  defstruct [
    :__info__,
    :author,
    :body,
    :body_html,
    :body_version,
    :created_at,
    :discussion_url,
    :html_url,
    :last_edited_at,
    :node_id,
    :number,
    :reactions,
    :updated_at,
    :url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      author: {:nullable, {GitHub.User, :simple}},
      body: :string,
      body_html: :string,
      body_version: :string,
      created_at: :string,
      discussion_url: :string,
      html_url: :string,
      last_edited_at: {:nullable, :string},
      node_id: :string,
      number: :integer,
      reactions: {GitHub.Reaction.Rollup, :t},
      updated_at: :string,
      url: :string
    ]
  end
end
