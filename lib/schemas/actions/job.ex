defmodule GitHub.Actions.Job do
  @moduledoc """
  Provides struct and type for Job
  """

  @type t :: %__MODULE__{
          __info__: map,
          check_run_url: String.t(),
          completed_at: String.t() | nil,
          conclusion: String.t() | nil,
          created_at: String.t(),
          head_branch: String.t() | nil,
          head_sha: String.t(),
          html_url: String.t() | nil,
          id: integer,
          labels: [String.t()],
          name: String.t(),
          node_id: String.t(),
          run_attempt: integer | nil,
          run_id: integer,
          run_url: String.t(),
          runner_group_id: integer | nil,
          runner_group_name: String.t() | nil,
          runner_id: integer | nil,
          runner_name: String.t() | nil,
          started_at: String.t(),
          status: String.t(),
          steps: [map] | nil,
          url: String.t(),
          workflow_name: String.t() | nil
        }

  defstruct [
    :__info__,
    :check_run_url,
    :completed_at,
    :conclusion,
    :created_at,
    :head_branch,
    :head_sha,
    :html_url,
    :id,
    :labels,
    :name,
    :node_id,
    :run_attempt,
    :run_id,
    :run_url,
    :runner_group_id,
    :runner_group_name,
    :runner_id,
    :runner_name,
    :started_at,
    :status,
    :steps,
    :url,
    :workflow_name
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      check_run_url: :string,
      completed_at: {:nullable, :string},
      conclusion: {:nullable, :string},
      created_at: :string,
      head_branch: {:nullable, :string},
      head_sha: :string,
      html_url: {:nullable, :string},
      id: :integer,
      labels: {:array, :string},
      name: :string,
      node_id: :string,
      run_attempt: :integer,
      run_id: :integer,
      run_url: :string,
      runner_group_id: {:nullable, :integer},
      runner_group_name: {:nullable, :string},
      runner_id: {:nullable, :integer},
      runner_name: {:nullable, :string},
      started_at: :string,
      status: :string,
      steps: {:array, :map},
      url: :string,
      workflow_name: {:nullable, :string}
    ]
  end
end
