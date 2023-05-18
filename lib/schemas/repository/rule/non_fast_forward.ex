defmodule GitHub.Repository.Rule.NonFastForward do
  @moduledoc """
  Provides struct and type for RepositoryRuleNonFastForward
  """

  @type t :: %__MODULE__{__info__: map, type: String.t()}

  defstruct [:__info__, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [type: :string]
  end
end