defmodule GitHub.Repository.Ruleset.ConditionsRepositoryIdTarget do
  @moduledoc """
  Provides struct and type for RepositoryRulesetConditionsRepositoryIdTarget
  """

  @type t :: %__MODULE__{__info__: map, repository_id: map}

  defstruct [:__info__, :repository_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [repository_id: :map]
  end
end
