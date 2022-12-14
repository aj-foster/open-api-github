defmodule GitHub.StateChangeIssueEvent do
  @moduledoc """
  Provides struct and type for StateChangeIssueEvent
  """

  @type t :: %__MODULE__{
          actor: GitHub.User.simple(),
          commit_id: String.t() | nil,
          commit_url: String.t() | nil,
          created_at: String.t(),
          event: String.t(),
          id: integer,
          node_id: String.t(),
          performed_via_github_app: GitHub.Integration.t() | nil,
          state_reason: String.t() | nil,
          url: String.t()
        }

  defstruct [
    :actor,
    :commit_id,
    :commit_url,
    :created_at,
    :event,
    :id,
    :node_id,
    :performed_via_github_app,
    :state_reason,
    :url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      actor: {GitHub.User, :simple},
      commit_id: :string,
      commit_url: :string,
      created_at: :string,
      event: :string,
      id: :integer,
      node_id: :string,
      performed_via_github_app: {GitHub.Integration, :t},
      state_reason: :string,
      url: :string
    ]
  end
end
