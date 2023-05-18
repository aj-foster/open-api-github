defmodule GitHub.Repository.Ruleset.BypassActor do
  @moduledoc """
  Provides struct and type for RepositoryRulesetBypassActor
  """

  @type t :: %__MODULE__{__info__: map, actor_id: integer | nil, actor_type: String.t() | nil}

  defstruct [:__info__, :actor_id, :actor_type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [actor_id: :integer, actor_type: :string]
  end
end
