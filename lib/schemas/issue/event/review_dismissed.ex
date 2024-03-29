defmodule GitHub.Issue.Event.ReviewDismissed do
  @moduledoc """
  Provides struct and type for a Issue.Event.ReviewDismissed
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          actor: GitHub.User.simple(),
          commit_id: String.t() | nil,
          commit_url: String.t() | nil,
          created_at: String.t(),
          dismissed_review: GitHub.Issue.Event.ReviewDismissedDismissedReview.t(),
          event: String.t(),
          id: integer,
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
      commit_id: {:union, [{:string, :generic}, :null]},
      commit_url: {:union, [{:string, :generic}, :null]},
      created_at: {:string, :generic},
      dismissed_review: {GitHub.Issue.Event.ReviewDismissedDismissedReview, :t},
      event: {:string, :generic},
      id: :integer,
      node_id: {:string, :generic},
      performed_via_github_app: {:union, [{GitHub.App, :t}, :null]},
      url: {:string, :generic}
    ]
  end
end
