defmodule GitHub.Issue.EventDismissedReview do
  @moduledoc """
  Provides struct and type for IssueEventDismissedReview
  """

  @type t :: %__MODULE__{
          __info__: map,
          dismissal_commit_id: String.t() | nil,
          dismissal_message: String.t() | nil,
          review_id: integer,
          state: String.t()
        }

  defstruct [:__info__, :dismissal_commit_id, :dismissal_message, :review_id, :state]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      dismissal_commit_id: {:nullable, :string},
      dismissal_message: {:nullable, :string},
      review_id: :integer,
      state: :string
    ]
  end
end
