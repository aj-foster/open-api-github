defmodule GitHub.Commit.SearchResultItem do
  @moduledoc """
  Provides struct and type for a Commit.SearchResultItem
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          author: GitHub.User.simple() | nil,
          comments_url: String.t(),
          commit: map,
          committer: GitHub.Git.User.t() | nil,
          html_url: String.t(),
          node_id: String.t(),
          parents: [map],
          repository: GitHub.Repository.minimal(),
          score: number,
          sha: String.t(),
          text_matches: [map] | nil,
          url: String.t()
        }

  defstruct [
    :__info__,
    :author,
    :comments_url,
    :commit,
    :committer,
    :html_url,
    :node_id,
    :parents,
    :repository,
    :score,
    :sha,
    :text_matches,
    :url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      author: {:union, [{GitHub.User, :simple}, :null]},
      comments_url: {:string, :uri},
      commit: :map,
      committer: {:union, [{GitHub.Git.User, :t}, :null]},
      html_url: {:string, :uri},
      node_id: {:string, :generic},
      parents: [:map],
      repository: {GitHub.Repository, :minimal},
      score: :number,
      sha: {:string, :generic},
      text_matches: [:map],
      url: {:string, :uri}
    ]
  end
end
