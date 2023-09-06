defmodule GitHub.Copilot.SeatDetails do
  @moduledoc """
  Provides struct and type for CopilotSeatDetails
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          assignee: map,
          assigning_team: GitHub.Team.t() | nil,
          created_at: String.t(),
          last_activity_at: String.t() | nil,
          last_activity_editor: String.t() | nil,
          pending_cancellation_date: String.t() | nil,
          updated_at: String.t() | nil
        }

  defstruct [
    :__info__,
    :assignee,
    :assigning_team,
    :created_at,
    :last_activity_at,
    :last_activity_editor,
    :pending_cancellation_date,
    :updated_at
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      assignee: :map,
      assigning_team: {:nullable, {GitHub.Team, :t}},
      created_at: :string,
      last_activity_at: {:nullable, :string},
      last_activity_editor: {:nullable, :string},
      pending_cancellation_date: {:nullable, :string},
      updated_at: :string
    ]
  end
end
