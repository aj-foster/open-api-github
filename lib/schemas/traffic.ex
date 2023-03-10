defmodule GitHub.Traffic do
  @moduledoc """
  Provides struct and type for Traffic
  """

  @type t :: %__MODULE__{count: integer, timestamp: String.t(), uniques: integer}

  defstruct [:count, :timestamp, :uniques]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [count: :integer, timestamp: :string, uniques: :integer]
  end
end
