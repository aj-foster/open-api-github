defmodule GitHub.Branch.Protection do
  @moduledoc """
  Provides struct and type for BranchProtection
  """

  @type t :: %__MODULE__{
          allow_deletions: map | nil,
          allow_force_pushes: map | nil,
          allow_fork_syncing: map | nil,
          block_creations: map | nil,
          enabled: boolean | nil,
          enforce_admins: GitHub.ProtectedBranch.AdminEnforced.t() | nil,
          lock_branch: map | nil,
          name: String.t() | nil,
          protection_url: String.t() | nil,
          required_conversation_resolution: map | nil,
          required_linear_history: map | nil,
          required_pull_request_reviews: GitHub.ProtectedBranch.PullRequestReview.t() | nil,
          required_signatures: map | nil,
          required_status_checks: GitHub.ProtectedBranch.RequiredStatusCheck.t() | nil,
          restrictions: GitHub.Branch.RestrictionPolicy.t() | nil,
          url: String.t() | nil
        }

  defstruct [
    :allow_deletions,
    :allow_force_pushes,
    :allow_fork_syncing,
    :block_creations,
    :enabled,
    :enforce_admins,
    :lock_branch,
    :name,
    :protection_url,
    :required_conversation_resolution,
    :required_linear_history,
    :required_pull_request_reviews,
    :required_signatures,
    :required_status_checks,
    :restrictions,
    :url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      allow_deletions: :map,
      allow_force_pushes: :map,
      allow_fork_syncing: :map,
      block_creations: :map,
      enabled: :boolean,
      enforce_admins: {GitHub.ProtectedBranch.AdminEnforced, :t},
      lock_branch: :map,
      name: :string,
      protection_url: :string,
      required_conversation_resolution: :map,
      required_linear_history: :map,
      required_pull_request_reviews: {GitHub.ProtectedBranch.PullRequestReview, :t},
      required_signatures: :map,
      required_status_checks: {GitHub.ProtectedBranch.RequiredStatusCheck, :t},
      restrictions: {GitHub.Branch.RestrictionPolicy, :t},
      url: :string
    ]
  end
end
