defmodule GitHub.CombinedCommitStatus do
  @moduledoc """
  Provides struct and type for CombinedCommitStatus
  """

  @type t :: %__MODULE__{
          commit_url: String.t(),
          repository: GitHub.MinimalRepository.t(),
          sha: String.t(),
          state: String.t(),
          statuses: [GitHub.Commit.Status.simple()],
          total_count: integer,
          url: String.t()
        }

  defstruct [:commit_url, :repository, :sha, :state, :statuses, :total_count, :url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      commit_url: :string,
      repository: {GitHub.MinimalRepository, :t},
      sha: :string,
      state: :string,
      statuses: {:array, {GitHub.Commit.Status, :simple}},
      total_count: :integer,
      url: :string
    ]
  end
end
