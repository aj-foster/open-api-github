defmodule GitHub.Job do
  @moduledoc """
  Provides struct and type for Job
  """

  @type t :: %__MODULE__{
          check_run_url: String.t(),
          completed_at: String.t() | nil,
          conclusion: String.t() | nil,
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
          url: String.t()
        }

  defstruct [
    :check_run_url,
    :completed_at,
    :conclusion,
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
    :url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      check_run_url: :string,
      completed_at: :string,
      conclusion: :string,
      head_sha: :string,
      html_url: :string,
      id: :integer,
      labels: {:array, :string},
      name: :string,
      node_id: :string,
      run_attempt: :integer,
      run_id: :integer,
      run_url: :string,
      runner_group_id: :integer,
      runner_group_name: :string,
      runner_id: :integer,
      runner_name: :string,
      started_at: :string,
      status: :string,
      steps: {:array, :map},
      url: :string
    ]
  end
end
