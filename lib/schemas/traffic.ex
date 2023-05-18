defmodule GitHub.Traffic do
  @moduledoc """
  Provides struct and type for Traffic
  """

  @type t :: %__MODULE__{__info__: map, count: integer, timestamp: String.t(), uniques: integer}

  defstruct [:__info__, :count, :timestamp, :uniques]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [count: :integer, timestamp: :string, uniques: :integer]
  end
end
