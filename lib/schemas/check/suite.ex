defmodule GitHub.Check.Suite do
  @moduledoc """
  Provides struct and type for CheckSuite
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          after: String.t() | nil,
          app: GitHub.App.t() | nil,
          before: String.t() | nil,
          check_runs_url: String.t(),
          conclusion: String.t() | nil,
          created_at: String.t() | nil,
          head_branch: String.t() | nil,
          head_commit: GitHub.Commit.simple(),
          head_sha: String.t(),
          id: integer,
          latest_check_runs_count: integer,
          node_id: String.t(),
          pull_requests: [GitHub.PullRequest.minimal()] | nil,
          repository: GitHub.Repository.minimal(),
          rerequestable: boolean | nil,
          runs_rerequestable: boolean | nil,
          status: String.t() | nil,
          updated_at: String.t() | nil,
          url: String.t() | nil
        }

  defstruct [
    :__info__,
    :after,
    :app,
    :before,
    :check_runs_url,
    :conclusion,
    :created_at,
    :head_branch,
    :head_commit,
    :head_sha,
    :id,
    :latest_check_runs_count,
    :node_id,
    :pull_requests,
    :repository,
    :rerequestable,
    :runs_rerequestable,
    :status,
    :updated_at,
    :url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      after: {:nullable, :string},
      app: {:nullable, {GitHub.App, :t}},
      before: {:nullable, :string},
      check_runs_url: :string,
      conclusion: {:nullable, :string},
      created_at: {:nullable, :string},
      head_branch: {:nullable, :string},
      head_commit: {GitHub.Commit, :simple},
      head_sha: :string,
      id: :integer,
      latest_check_runs_count: :integer,
      node_id: :string,
      pull_requests: {:nullable, {:array, {GitHub.PullRequest, :minimal}}},
      repository: {GitHub.Repository, :minimal},
      rerequestable: :boolean,
      runs_rerequestable: :boolean,
      status: {:nullable, :string},
      updated_at: {:nullable, :string},
      url: {:nullable, :string}
    ]
  end
end
