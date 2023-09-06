defmodule GitHub.Repository.Ruleset.BypassActor do
  @moduledoc """
  Provides struct and type for RepositoryRulesetBypassActor
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          actor_id: integer,
          actor_type: String.t(),
          bypass_mode: String.t()
        }

  defstruct [:__info__, :actor_id, :actor_type, :bypass_mode]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [actor_id: :integer, actor_type: :string, bypass_mode: :string]
  end
end
