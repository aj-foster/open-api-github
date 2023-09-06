defmodule GitHub.Repository.Rule.RulesetInfo do
  @moduledoc """
  Provides struct and type for RepositoryRuleRulesetInfo
  """

  @type t :: %__MODULE__{
          __info__: map,
          ruleset_id: integer | nil,
          ruleset_source: String.t() | nil,
          ruleset_source_type: String.t() | nil
        }

  defstruct [:__info__, :ruleset_id, :ruleset_source, :ruleset_source_type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [ruleset_id: :integer, ruleset_source: :string, ruleset_source_type: :string]
  end
end
