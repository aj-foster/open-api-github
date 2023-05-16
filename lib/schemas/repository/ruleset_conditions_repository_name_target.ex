defmodule GitHub.Repository.RulesetConditionsRepositoryNameTarget do
  @moduledoc """
  Provides struct and type for RepositoryRulesetConditionsRepositoryNameTarget
  """

  @type t :: %__MODULE__{repository_name: map | nil}

  defstruct [:repository_name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [repository_name: :map]
  end
end
