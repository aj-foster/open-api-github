defmodule GitHub.ProtectedBranch do
  @moduledoc """
  Provides struct and type for a ProtectedBranch
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          allow_deletions: map | nil,
          allow_force_pushes: map | nil,
          allow_fork_syncing: map | nil,
          block_creations: map | nil,
          enforce_admins: map | nil,
          lock_branch: map | nil,
          required_conversation_resolution: map | nil,
          required_linear_history: map | nil,
          required_pull_request_reviews: map | nil,
          required_signatures: map | nil,
          required_status_checks: GitHub.StatusCheckPolicy.t() | nil,
          restrictions: GitHub.Branch.RestrictionPolicy.t() | nil,
          url: String.t()
        }

  defstruct [
    :__info__,
    :allow_deletions,
    :allow_force_pushes,
    :allow_fork_syncing,
    :block_creations,
    :enforce_admins,
    :lock_branch,
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
      enforce_admins: :map,
      lock_branch: :map,
      required_conversation_resolution: :map,
      required_linear_history: :map,
      required_pull_request_reviews: :map,
      required_signatures: :map,
      required_status_checks: {GitHub.StatusCheckPolicy, :t},
      restrictions: {GitHub.Branch.RestrictionPolicy, :t},
      url: {:string, :uri}
    ]
  end
end
