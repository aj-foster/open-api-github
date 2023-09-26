defmodule GitHub.Copilot.OrganizationDetails do
  @moduledoc """
  Provides struct and type for a Copilot.OrganizationDetails
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          public_code_suggestions: String.t(),
          seat_breakdown: GitHub.Copilot.SeatBreakdown.t(),
          seat_management_setting: String.t()
        }

  defstruct [:__info__, :public_code_suggestions, :seat_breakdown, :seat_management_setting]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      public_code_suggestions: {:enum, ["allow", "block", "unconfigured", "unknown"]},
      seat_breakdown: {GitHub.Copilot.SeatBreakdown, :t},
      seat_management_setting:
        {:enum, ["assign_all", "assign_selected", "disabled", "unconfigured"]}
    ]
  end
end