defmodule GitHub.ViewTraffic do
  @moduledoc """
  Provides struct and type for ViewTraffic
  """

  @type t :: %__MODULE__{count: integer, uniques: integer, views: [GitHub.Traffic.t()]}

  defstruct [:count, :uniques, :views]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [count: :integer, uniques: :integer, views: {:array, {GitHub.Traffic, :t}}]
  end
end
