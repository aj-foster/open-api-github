defmodule GitHub.LockedIssueEvent do
  @moduledoc """
  Provides struct and type for LockedIssueEvent
  """

  @type t :: %__MODULE__{
          __info__: map,
          actor: GitHub.User.simple(),
          commit_id: String.t() | nil,
          commit_url: String.t() | nil,
          created_at: String.t(),
          event: String.t(),
          id: integer,
          lock_reason: String.t() | nil,
          node_id: String.t(),
          performed_via_github_app: GitHub.App.t() | nil,
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
    :lock_reason,
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
      event: :string,
      id: :integer,
      lock_reason: {:nullable, :string},
      node_id: :string,
      performed_via_github_app: {:nullable, {GitHub.App, :t}},
      url: :string
    ]
  end
end
