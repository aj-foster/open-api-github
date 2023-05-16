defmodule GitHub.ReviewDismissedIssueEvent do
  @moduledoc """
  Provides struct and type for ReviewDismissedIssueEvent
  """

  @type t :: %__MODULE__{
          actor: GitHub.User.simple(),
          commit_id: String.t() | nil,
          commit_url: String.t() | nil,
          created_at: String.t(),
          dismissed_review: map,
          event: String.t(),
          id: integer,
          node_id: String.t(),
          performed_via_github_app: GitHub.App.t() | nil,
          url: String.t()
        }

  defstruct [
    :actor,
    :commit_id,
    :commit_url,
    :created_at,
    :dismissed_review,
    :event,
    :id,
    :node_id,
    :performed_via_github_app,
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
      dismissed_review: :map,
      event: :string,
      id: :integer,
      node_id: :string,
      performed_via_github_app: {:nullable, {GitHub.App, :t}},
      url: :string
    ]
  end
end
