defmodule GitHub.Check.Run do
  @moduledoc """
  Provides struct and type for CheckRun
  """

  @type t :: %__MODULE__{
          app: GitHub.Integration.t() | nil,
          check_suite: map | nil,
          completed_at: String.t() | nil,
          conclusion: String.t() | nil,
          deployment: GitHub.Deployment.simple() | nil,
          details_url: String.t() | nil,
          external_id: String.t() | nil,
          head_sha: String.t(),
          html_url: String.t() | nil,
          id: integer,
          name: String.t(),
          node_id: String.t(),
          output: map,
          pull_requests: [GitHub.PullRequest.minimal()],
          started_at: String.t() | nil,
          status: String.t(),
          url: String.t()
        }

  defstruct [
    :app,
    :check_suite,
    :completed_at,
    :conclusion,
    :deployment,
    :details_url,
    :external_id,
    :head_sha,
    :html_url,
    :id,
    :name,
    :node_id,
    :output,
    :pull_requests,
    :started_at,
    :status,
    :url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      app: {:nullable, {GitHub.Integration, :t}},
      check_suite: {:nullable, :map},
      completed_at: {:nullable, :string},
      conclusion: {:nullable, :string},
      deployment: {GitHub.Deployment, :simple},
      details_url: {:nullable, :string},
      external_id: {:nullable, :string},
      head_sha: :string,
      html_url: {:nullable, :string},
      id: :integer,
      name: :string,
      node_id: :string,
      output: :map,
      pull_requests: {:array, {GitHub.PullRequest, :minimal}},
      started_at: {:nullable, :string},
      status: :string,
      url: :string
    ]
  end
end
