defmodule GitHub.ReviewComment do
  @moduledoc """
  Provides struct and type for ReviewComment
  """

  @type t :: %__MODULE__{
          __info__: map,
          _links: map,
          author_association: String.t(),
          body: String.t(),
          body_html: String.t() | nil,
          body_text: String.t() | nil,
          commit_id: String.t(),
          created_at: String.t(),
          diff_hunk: String.t(),
          html_url: String.t(),
          id: integer,
          in_reply_to_id: integer | nil,
          line: integer | nil,
          node_id: String.t(),
          original_commit_id: String.t(),
          original_line: integer | nil,
          original_position: integer,
          original_start_line: integer | nil,
          path: String.t(),
          position: integer | nil,
          pull_request_review_id: integer | nil,
          pull_request_url: String.t(),
          reactions: GitHub.Reaction.Rollup.t() | nil,
          side: String.t() | nil,
          start_line: integer | nil,
          start_side: String.t() | nil,
          updated_at: String.t(),
          url: String.t(),
          user: GitHub.User.simple() | nil
        }

  defstruct [
    :__info__,
    :_links,
    :author_association,
    :body,
    :body_html,
    :body_text,
    :commit_id,
    :created_at,
    :diff_hunk,
    :html_url,
    :id,
    :in_reply_to_id,
    :line,
    :node_id,
    :original_commit_id,
    :original_line,
    :original_position,
    :original_start_line,
    :path,
    :position,
    :pull_request_review_id,
    :pull_request_url,
    :reactions,
    :side,
    :start_line,
    :start_side,
    :updated_at,
    :url,
    :user
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      _links: :map,
      author_association: :string,
      body: :string,
      body_html: :string,
      body_text: :string,
      commit_id: :string,
      created_at: :string,
      diff_hunk: :string,
      html_url: :string,
      id: :integer,
      in_reply_to_id: :integer,
      line: :integer,
      node_id: :string,
      original_commit_id: :string,
      original_line: :integer,
      original_position: :integer,
      original_start_line: {:nullable, :integer},
      path: :string,
      position: {:nullable, :integer},
      pull_request_review_id: {:nullable, :integer},
      pull_request_url: :string,
      reactions: {GitHub.Reaction.Rollup, :t},
      side: :string,
      start_line: {:nullable, :integer},
      start_side: {:nullable, :string},
      updated_at: :string,
      url: :string,
      user: {:nullable, {GitHub.User, :simple}}
    ]
  end
end
