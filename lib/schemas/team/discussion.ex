defmodule GitHub.Team.Discussion do
  @moduledoc """
  Provides struct and type for TeamDiscussion
  """

  @type t :: %__MODULE__{
          author: GitHub.User.simple() | nil,
          body: String.t(),
          body_html: String.t(),
          body_version: String.t(),
          comments_count: integer,
          comments_url: String.t(),
          created_at: String.t(),
          html_url: String.t(),
          last_edited_at: String.t() | nil,
          node_id: String.t(),
          number: integer,
          pinned: boolean,
          private: boolean,
          reactions: GitHub.Reaction.Rollup.t() | nil,
          team_url: String.t(),
          title: String.t(),
          updated_at: String.t(),
          url: String.t()
        }

  defstruct [
    :author,
    :body,
    :body_html,
    :body_version,
    :comments_count,
    :comments_url,
    :created_at,
    :html_url,
    :last_edited_at,
    :node_id,
    :number,
    :pinned,
    :private,
    :reactions,
    :team_url,
    :title,
    :updated_at,
    :url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      author: {GitHub.User, :simple},
      body: :string,
      body_html: :string,
      body_version: :string,
      comments_count: :integer,
      comments_url: :string,
      created_at: :string,
      html_url: :string,
      last_edited_at: :string,
      node_id: :string,
      number: :integer,
      pinned: :boolean,
      private: :boolean,
      reactions: {GitHub.Reaction.Rollup, :t},
      team_url: :string,
      title: :string,
      updated_at: :string,
      url: :string
    ]
  end
end
