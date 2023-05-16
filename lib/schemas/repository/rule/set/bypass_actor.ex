defmodule GitHub.Repository.Rule.Set.BypassActor do
  @moduledoc """
  Provides struct and type for RepositoryRulesetBypassActor
  """

  @type t :: %__MODULE__{actor_id: integer | nil, actor_type: String.t() | nil}

  defstruct [:actor_id, :actor_type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [actor_id: :integer, actor_type: :string]
  end
end
