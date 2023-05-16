defmodule GitHub.UnassignedIssueEvent do
  @moduledoc """
  Provides struct and type for UnassignedIssueEvent
  """

  @type t :: %__MODULE__{
          actor: GitHub.User.simple(),
          assignee: GitHub.User.simple(),
          assigner: GitHub.User.simple(),
          commit_id: String.t() | nil,
          commit_url: String.t() | nil,
          created_at: String.t(),
          event: String.t(),
          id: integer,
          node_id: String.t(),
          performed_via_github_app: GitHub.App.t() | nil,
          url: String.t()
        }

  defstruct [
    :actor,
    :assignee,
    :assigner,
    :commit_id,
    :commit_url,
    :created_at,
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
      assignee: {GitHub.User, :simple},
      assigner: {GitHub.User, :simple},
      commit_id: {:nullable, :string},
      commit_url: {:nullable, :string},
      created_at: :string,
      event: :string,
      id: :integer,
      node_id: :string,
      performed_via_github_app: {:nullable, {GitHub.App, :t}},
      url: :string
    ]
  end
end
