defmodule GitHub.Commit.Comparison do
  @moduledoc """
  Provides struct and type for CommitComparison
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          ahead_by: integer,
          base_commit: GitHub.Commit.t(),
          behind_by: integer,
          commits: [GitHub.Commit.t()],
          diff_url: String.t(),
          files: [GitHub.DiffEntry.t()] | nil,
          html_url: String.t(),
          merge_base_commit: GitHub.Commit.t(),
          patch_url: String.t(),
          permalink_url: String.t(),
          status: String.t(),
          total_commits: integer,
          url: String.t()
        }

  defstruct [
    :__info__,
    :ahead_by,
    :base_commit,
    :behind_by,
    :commits,
    :diff_url,
    :files,
    :html_url,
    :merge_base_commit,
    :patch_url,
    :permalink_url,
    :status,
    :total_commits,
    :url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      ahead_by: :integer,
      base_commit: {GitHub.Commit, :t},
      behind_by: :integer,
      commits: {:array, {GitHub.Commit, :t}},
      diff_url: :string,
      files: {:array, {GitHub.DiffEntry, :t}},
      html_url: :string,
      merge_base_commit: {GitHub.Commit, :t},
      patch_url: :string,
      permalink_url: :string,
      status: :string,
      total_commits: :integer,
      url: :string
    ]
  end
end
