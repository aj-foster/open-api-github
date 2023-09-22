defmodule GitHub.Commit do
  @moduledoc """
  Provides struct and types for a Commit
  """
  use GitHub.Encoder

  @type simple :: %__MODULE__{
          __info__: map,
          author: map | nil,
          committer: map | nil,
          id: String.t(),
          message: String.t(),
          timestamp: DateTime.t(),
          tree_id: String.t()
        }

  @type t :: %__MODULE__{
          __info__: map,
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
    :__info__,
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
      author: {:union, [:map, :null]},
      committer: {:union, [:map, :null]},
      id: {:string, :generic},
      message: {:string, :generic},
      timestamp: {:string, :date_time},
      tree_id: {:string, :generic}
    ]
  end

  def __fields__(:t) do
    [
      author: {:union, [{GitHub.User, :simple}, :null]},
      comments_url: {:string, :uri},
      commit: :map,
      committer: {:union, [{GitHub.User, :simple}, :null]},
      files: [{GitHub.DiffEntry, :t}],
      html_url: {:string, :uri},
      node_id: {:string, :generic},
      parents: [:map],
      sha: {:string, :generic},
      stats: :map,
      url: {:string, :uri}
    ]
  end
end
