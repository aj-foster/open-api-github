defmodule GitHub.Git.Commit do
  @moduledoc """
  Provides struct and type for GitCommit
  """

  @type t :: %__MODULE__{
          author: map,
          committer: map,
          html_url: String.t(),
          message: String.t(),
          node_id: String.t(),
          parents: [map],
          sha: String.t(),
          tree: map,
          url: String.t(),
          verification: map
        }

  defstruct [
    :author,
    :committer,
    :html_url,
    :message,
    :node_id,
    :parents,
    :sha,
    :tree,
    :url,
    :verification
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      author: :map,
      committer: :map,
      html_url: :string,
      message: :string,
      node_id: :string,
      parents: {:array, :map},
      sha: :string,
      tree: :map,
      url: :string,
      verification: :map
    ]
  end
end
