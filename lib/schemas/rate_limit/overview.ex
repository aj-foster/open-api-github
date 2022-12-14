defmodule GitHub.RateLimit.Overview do
  @moduledoc """
  Provides struct and type for RateLimitOverview
  """

  @type t :: %__MODULE__{rate: GitHub.RateLimit.t(), resources: map}

  defstruct [:rate, :resources]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [rate: {GitHub.RateLimit, :t}, resources: :map]
  end
end
