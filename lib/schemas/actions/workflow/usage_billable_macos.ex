defmodule GitHub.Actions.Workflow.UsageBillableMACOS do
  @moduledoc """
  Provides struct and type for a Actions.Workflow.UsageBillableMACOS
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{__info__: map, total_ms: integer | nil}

  defstruct [:__info__, :total_ms]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [total_ms: :integer]
  end
end
