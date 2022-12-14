defmodule GitHub.Timeline.CommentEvent do
  @moduledoc """
  Provides struct and type for TimelineCommentEvent
  """

  @type t :: %__MODULE__{
          actor: GitHub.User.simple(),
          author_association: String.t(),
          body: String.t() | nil,
          body_html: String.t() | nil,
          body_text: String.t() | nil,
          created_at: String.t(),
          event: String.t(),
          html_url: String.t(),
          id: integer,
          issue_url: String.t(),
          node_id: String.t(),
          performed_via_github_app: GitHub.Integration.t() | nil,
          reactions: GitHub.Reaction.Rollup.t() | nil,
          updated_at: String.t(),
          url: String.t(),
          user: GitHub.User.simple()
        }

  defstruct [
    :actor,
    :author_association,
    :body,
    :body_html,
    :body_text,
    :created_at,
    :event,
    :html_url,
    :id,
    :issue_url,
    :node_id,
    :performed_via_github_app,
    :reactions,
    :updated_at,
    :url,
    :user
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      actor: {GitHub.User, :simple},
      author_association: :string,
      body: :string,
      body_html: :string,
      body_text: :string,
      created_at: :string,
      event: :string,
      html_url: :string,
      id: :integer,
      issue_url: :string,
      node_id: :string,
      performed_via_github_app: {GitHub.Integration, :t},
      reactions: {GitHub.Reaction.Rollup, :t},
      updated_at: :string,
      url: :string,
      user: {GitHub.User, :simple}
    ]
  end
end
