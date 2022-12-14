defmodule GitHub.Timeline.CommitCommentedEvent do
  @moduledoc """
  Provides struct and type for TimelineCommitCommentedEvent
  """

  @type t :: %__MODULE__{
          comments: [GitHub.Commit.Comment.t()] | nil,
          commit_id: String.t() | nil,
          event: String.t() | nil,
          node_id: String.t() | nil
        }

  defstruct [:comments, :commit_id, :event, :node_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      comments: {:array, {GitHub.Commit.Comment, :t}},
      commit_id: :string,
      event: :string,
      node_id: :string
    ]
  end
end
