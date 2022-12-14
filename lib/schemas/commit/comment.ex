defmodule GitHub.Commit.Comment do
  @moduledoc """
  Provides struct and type for CommitComment
  """

  @type t :: %__MODULE__{
          author_association: String.t(),
          body: String.t(),
          commit_id: String.t(),
          created_at: String.t(),
          html_url: String.t(),
          id: integer,
          line: integer | nil,
          node_id: String.t(),
          path: String.t() | nil,
          position: integer | nil,
          reactions: GitHub.Reaction.Rollup.t() | nil,
          updated_at: String.t(),
          url: String.t(),
          user: GitHub.User.simple() | nil
        }

  defstruct [
    :author_association,
    :body,
    :commit_id,
    :created_at,
    :html_url,
    :id,
    :line,
    :node_id,
    :path,
    :position,
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
      author_association: :string,
      body: :string,
      commit_id: :string,
      created_at: :string,
      html_url: :string,
      id: :integer,
      line: :integer,
      node_id: :string,
      path: :string,
      position: :integer,
      reactions: {GitHub.Reaction.Rollup, :t},
      updated_at: :string,
      url: :string,
      user: {GitHub.User, :simple}
    ]
  end
end
