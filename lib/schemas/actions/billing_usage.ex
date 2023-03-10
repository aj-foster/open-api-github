defmodule GitHub.Actions.BillingUsage do
  @moduledoc """
  Provides struct and type for ActionsBillingUsage
  """

  @type t :: %__MODULE__{
          included_minutes: integer,
          minutes_used_breakdown: map,
          total_minutes_used: integer,
          total_paid_minutes_used: integer
        }

  defstruct [
    :included_minutes,
    :minutes_used_breakdown,
    :total_minutes_used,
    :total_paid_minutes_used
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      included_minutes: :integer,
      minutes_used_breakdown: :map,
      total_minutes_used: :integer,
      total_paid_minutes_used: :integer
    ]
  end
end
