defmodule GitHub.Actions.Workflow.AccessToRepository do
  @moduledoc """
  Provides struct and type for ActionsWorkflowAccessToRepository
  """

  @type t :: %__MODULE__{access_level: String.t()}

  defstruct [:access_level]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [access_level: :string]
  end
end
