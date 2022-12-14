defmodule GitHub.Timeline.LineCommentedEvent do
  @moduledoc """
  Provides struct and type for TimelineLineCommentedEvent
  """

  @type t :: %__MODULE__{
          comments: [GitHub.PullRequest.ReviewComment.t()] | nil,
          event: String.t() | nil,
          node_id: String.t() | nil
        }

  defstruct [:comments, :event, :node_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [comments: {:array, {GitHub.PullRequest.ReviewComment, :t}}, event: :string, node_id: :string]
  end
end
