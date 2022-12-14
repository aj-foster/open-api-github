defmodule GitHub.Issue.Event do
  @moduledoc """
  Provides struct and type for IssueEvent
  """

  @type t :: %__MODULE__{
          actor: GitHub.User.simple() | nil,
          assignee: GitHub.User.simple() | nil,
          assigner: GitHub.User.simple() | nil,
          author_association: String.t() | nil,
          commit_id: String.t() | nil,
          commit_url: String.t() | nil,
          created_at: String.t(),
          dismissed_review: GitHub.Issue.EventDismissedReview.t() | nil,
          event: String.t(),
          id: integer,
          issue: GitHub.Issue.t() | nil,
          label: GitHub.Issue.EventLabel.t() | nil,
          lock_reason: String.t() | nil,
          milestone: GitHub.Issue.EventMilestone.t() | nil,
          node_id: String.t(),
          performed_via_github_app: GitHub.Integration.t() | nil,
          project_card: GitHub.Issue.EventProjectCard.t() | nil,
          rename: GitHub.Issue.EventRename.t() | nil,
          requested_reviewer: GitHub.User.simple() | nil,
          requested_team: GitHub.Team.t() | nil,
          review_requester: GitHub.User.simple() | nil,
          url: String.t()
        }

  defstruct [
    :actor,
    :assignee,
    :assigner,
    :author_association,
    :commit_id,
    :commit_url,
    :created_at,
    :dismissed_review,
    :event,
    :id,
    :issue,
    :label,
    :lock_reason,
    :milestone,
    :node_id,
    :performed_via_github_app,
    :project_card,
    :rename,
    :requested_reviewer,
    :requested_team,
    :review_requester,
    :url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      actor: {GitHub.User, :simple},
      assignee: {GitHub.User, :simple},
      assigner: {GitHub.User, :simple},
      author_association: :string,
      commit_id: :string,
      commit_url: :string,
      created_at: :string,
      dismissed_review: {GitHub.Issue.EventDismissedReview, :t},
      event: :string,
      id: :integer,
      issue: {GitHub.Issue, :t},
      label: {GitHub.Issue.EventLabel, :t},
      lock_reason: :string,
      milestone: {GitHub.Issue.EventMilestone, :t},
      node_id: :string,
      performed_via_github_app: {GitHub.Integration, :t},
      project_card: {GitHub.Issue.EventProjectCard, :t},
      rename: {GitHub.Issue.EventRename, :t},
      requested_reviewer: {GitHub.User, :simple},
      requested_team: {GitHub.Team, :t},
      review_requester: {GitHub.User, :simple},
      url: :string
    ]
  end
end
