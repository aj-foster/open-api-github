defmodule GitHub.Repository.Ruleset.ConditionsRepositoryNameTarget do
  @moduledoc """
  Provides struct and type for RepositoryRulesetConditionsRepositoryNameTarget
  """

  @type t :: %__MODULE__{__info__: map, repository_name: map}

  defstruct [:__info__, :repository_name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [repository_name: :map]
  end
end
