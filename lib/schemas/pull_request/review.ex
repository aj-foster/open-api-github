defmodule GitHub.PullRequest.Review do
  @moduledoc """
  Provides struct and type for PullRequestReview
  """

  @type t :: %__MODULE__{
          __info__: map,
          _links: map,
          author_association: String.t(),
          body: String.t(),
          body_html: String.t() | nil,
          body_text: String.t() | nil,
          commit_id: String.t() | nil,
          html_url: String.t(),
          id: integer,
          node_id: String.t(),
          pull_request_url: String.t(),
          state: String.t(),
          submitted_at: String.t() | nil,
          user: GitHub.User.simple() | nil
        }

  defstruct [
    :__info__,
    :_links,
    :author_association,
    :body,
    :body_html,
    :body_text,
    :commit_id,
    :html_url,
    :id,
    :node_id,
    :pull_request_url,
    :state,
    :submitted_at,
    :user
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      _links: :map,
      author_association: :string,
      body: :string,
      body_html: :string,
      body_text: :string,
      commit_id: {:nullable, :string},
      html_url: :string,
      id: :integer,
      node_id: :string,
      pull_request_url: :string,
      state: :string,
      submitted_at: :string,
      user: {:nullable, {GitHub.User, :simple}}
    ]
  end
end
