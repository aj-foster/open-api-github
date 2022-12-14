defmodule GitHub.Actions.Workflow.RunUsage do
  @moduledoc """
  Provides struct and type for WorkflowRunUsage
  """

  @type t :: %__MODULE__{billable: map, run_duration_ms: integer | nil}

  defstruct [:billable, :run_duration_ms]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [billable: :map, run_duration_ms: :integer]
  end
end
