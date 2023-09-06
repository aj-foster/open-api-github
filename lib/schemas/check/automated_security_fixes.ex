defmodule GitHub.Check.AutomatedSecurityFixes do
  @moduledoc """
  Provides struct and type for CheckAutomatedSecurityFixes
  """

  @type t :: %__MODULE__{__info__: map, enabled: boolean, paused: boolean}

  defstruct [:__info__, :enabled, :paused]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [enabled: :boolean, paused: :boolean]
  end
end
