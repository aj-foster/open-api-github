defmodule GitHub.ProtectedBranch.PullRequestReview do
  @moduledoc """
  Provides struct and type for ProtectedBranchPullRequestReview
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          bypass_pull_request_allowances: map | nil,
          dismiss_stale_reviews: boolean,
          dismissal_restrictions: map | nil,
          require_code_owner_reviews: boolean,
          require_last_push_approval: boolean | nil,
          required_approving_review_count: integer | nil,
          url: String.t() | nil
        }

  defstruct [
    :__info__,
    :bypass_pull_request_allowances,
    :dismiss_stale_reviews,
    :dismissal_restrictions,
    :require_code_owner_reviews,
    :require_last_push_approval,
    :required_approving_review_count,
    :url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      bypass_pull_request_allowances: :map,
      dismiss_stale_reviews: :boolean,
      dismissal_restrictions: :map,
      require_code_owner_reviews: :boolean,
      require_last_push_approval: :boolean,
      required_approving_review_count: :integer,
      url: :string
    ]
  end
end
