defmodule GitHub.ParticipationStats do
  @moduledoc """
  Provides struct and type for ParticipationStats
  """

  @type t :: %__MODULE__{all: [integer], owner: [integer]}

  defstruct [:all, :owner]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [all: {:array, :integer}, owner: {:array, :integer}]
  end
end
