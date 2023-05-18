defmodule GitHub.ReviewRequestRemovedIssueEvent do
  @moduledoc """
  Provides struct and type for ReviewRequestRemovedIssueEvent
  """

  @type t :: %__MODULE__{
          __info__: map,
          actor: GitHub.User.simple(),
          commit_id: String.t() | nil,
          commit_url: String.t() | nil,
          created_at: String.t(),
          event: String.t(),
          id: integer,
          node_id: String.t(),
          performed_via_github_app: GitHub.App.t() | nil,
          requested_reviewer: GitHub.User.simple() | nil,
          requested_team: GitHub.Team.t() | nil,
          review_requester: GitHub.User.simple(),
          url: String.t()
        }

  defstruct [
    :__info__,
    :actor,
    :commit_id,
    :commit_url,
    :created_at,
    :event,
    :id,
    :node_id,
    :performed_via_github_app,
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
      commit_id: {:nullable, :string},
      commit_url: {:nullable, :string},
      created_at: :string,
      event: :string,
      id: :integer,
      node_id: :string,
      performed_via_github_app: {:nullable, {GitHub.App, :t}},
      requested_reviewer: {GitHub.User, :simple},
      requested_team: {GitHub.Team, :t},
      review_requester: {GitHub.User, :simple},
      url: :string
    ]
  end
end
