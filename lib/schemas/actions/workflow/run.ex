defmodule GitHub.Actions.Workflow.Run do
  @moduledoc """
  Provides struct and type for WorkflowRun
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          actor: GitHub.User.simple() | nil,
          artifacts_url: String.t(),
          cancel_url: String.t(),
          check_suite_id: integer | nil,
          check_suite_node_id: String.t() | nil,
          check_suite_url: String.t(),
          conclusion: String.t() | nil,
          created_at: String.t(),
          display_title: String.t(),
          event: String.t(),
          head_branch: String.t() | nil,
          head_commit: GitHub.Commit.simple() | nil,
          head_repository: GitHub.Repository.minimal(),
          head_repository_id: integer | nil,
          head_sha: String.t(),
          html_url: String.t(),
          id: integer,
          jobs_url: String.t(),
          logs_url: String.t(),
          name: String.t() | nil,
          node_id: String.t(),
          path: String.t(),
          previous_attempt_url: String.t() | nil,
          pull_requests: [GitHub.PullRequest.minimal()] | nil,
          referenced_workflows: [GitHub.ReferencedWorkflow.t()] | nil,
          repository: GitHub.Repository.minimal(),
          rerun_url: String.t(),
          run_attempt: integer | nil,
          run_number: integer,
          run_started_at: String.t() | nil,
          status: String.t() | nil,
          triggering_actor: GitHub.User.simple() | nil,
          updated_at: String.t(),
          url: String.t(),
          workflow_id: integer,
          workflow_url: String.t()
        }

  defstruct [
    :__info__,
    :actor,
    :artifacts_url,
    :cancel_url,
    :check_suite_id,
    :check_suite_node_id,
    :check_suite_url,
    :conclusion,
    :created_at,
    :display_title,
    :event,
    :head_branch,
    :head_commit,
    :head_repository,
    :head_repository_id,
    :head_sha,
    :html_url,
    :id,
    :jobs_url,
    :logs_url,
    :name,
    :node_id,
    :path,
    :previous_attempt_url,
    :pull_requests,
    :referenced_workflows,
    :repository,
    :rerun_url,
    :run_attempt,
    :run_number,
    :run_started_at,
    :status,
    :triggering_actor,
    :updated_at,
    :url,
    :workflow_id,
    :workflow_url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      actor: {GitHub.User, :simple},
      artifacts_url: :string,
      cancel_url: :string,
      check_suite_id: :integer,
      check_suite_node_id: :string,
      check_suite_url: :string,
      conclusion: {:nullable, :string},
      created_at: :string,
      display_title: :string,
      event: :string,
      head_branch: {:nullable, :string},
      head_commit: {:nullable, {GitHub.Commit, :simple}},
      head_repository: {GitHub.Repository, :minimal},
      head_repository_id: :integer,
      head_sha: :string,
      html_url: :string,
      id: :integer,
      jobs_url: :string,
      logs_url: :string,
      name: {:nullable, :string},
      node_id: :string,
      path: :string,
      previous_attempt_url: {:nullable, :string},
      pull_requests: {:nullable, {:array, {GitHub.PullRequest, :minimal}}},
      referenced_workflows: {:nullable, {:array, {GitHub.ReferencedWorkflow, :t}}},
      repository: {GitHub.Repository, :minimal},
      rerun_url: :string,
      run_attempt: :integer,
      run_number: :integer,
      run_started_at: :string,
      status: {:nullable, :string},
      triggering_actor: {GitHub.User, :simple},
      updated_at: :string,
      url: :string,
      workflow_id: :integer,
      workflow_url: :string
    ]
  end
end
