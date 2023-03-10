defmodule GitHub.ReferrerTraffic do
  @moduledoc """
  Provides struct and type for ReferrerTraffic
  """

  @type t :: %__MODULE__{count: integer, referrer: String.t(), uniques: integer}

  defstruct [:count, :referrer, :uniques]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [count: :integer, referrer: :string, uniques: :integer]
  end
end
