defmodule GitHub.Actions.Workflow.Usage do
  @moduledoc """
  Provides struct and type for WorkflowUsage
  """

  @type t :: %__MODULE__{__info__: map, billable: map}

  defstruct [:__info__, :billable]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [billable: :map]
  end
end
