defmodule GitHub.Commit do
  @moduledoc """
  Provides struct and types for Commit, SimpleCommit
  """

  @type simple :: %__MODULE__{
          author: map | nil,
          committer: map | nil,
          id: String.t(),
          message: String.t(),
          timestamp: String.t(),
          tree_id: String.t()
        }

  @type t :: %__MODULE__{
          author: GitHub.User.simple() | nil,
          comments_url: String.t(),
          commit: map,
          committer: GitHub.User.simple() | nil,
          files: [GitHub.DiffEntry.t()] | nil,
          html_url: String.t(),
          node_id: String.t(),
          parents: [map],
          sha: String.t(),
          stats: map | nil,
          url: String.t()
        }

  defstruct [
    :author,
    :comments_url,
    :commit,
    :committer,
    :files,
    :html_url,
    :id,
    :message,
    :node_id,
    :parents,
    :sha,
    :stats,
    :timestamp,
    :tree_id,
    :url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:simple) do
    [
      author: {:nullable, :map},
      committer: {:nullable, :map},
      id: :string,
      message: :string,
      timestamp: :string,
      tree_id: :string
    ]
  end

  def __fields__(:t) do
    [
      author: {:nullable, {GitHub.User, :simple}},
      comments_url: :string,
      commit: :map,
      committer: {:nullable, {GitHub.User, :simple}},
      files: {:array, {GitHub.DiffEntry, :t}},
      html_url: :string,
      node_id: :string,
      parents: {:array, :map},
      sha: :string,
      stats: :map,
      url: :string
    ]
  end
end
