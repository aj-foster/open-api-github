defmodule GitHub.CloneTraffic do
  @moduledoc """
  Provides struct and type for CloneTraffic
  """

  @type t :: %__MODULE__{clones: [GitHub.Traffic.t()], count: integer, uniques: integer}

  defstruct [:clones, :count, :uniques]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [clones: {:array, {GitHub.Traffic, :t}}, count: :integer, uniques: :integer]
  end
end
