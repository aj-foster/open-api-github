defmodule GitHub.Issue.EventMilestone do
  @moduledoc """
  Provides struct and type for IssueEventMilestone
  """

  @type t :: %__MODULE__{title: String.t()}

  defstruct [:title]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [title: :string]
  end
end
