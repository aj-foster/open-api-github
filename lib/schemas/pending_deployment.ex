defmodule GitHub.PendingDeployment do
  @moduledoc """
  Provides struct and type for PendingDeployment
  """

  @type t :: %__MODULE__{
          current_user_can_approve: boolean,
          environment: map,
          reviewers: [map],
          wait_timer: integer,
          wait_timer_started_at: String.t() | nil
        }

  defstruct [
    :current_user_can_approve,
    :environment,
    :reviewers,
    :wait_timer,
    :wait_timer_started_at
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      current_user_can_approve: :boolean,
      environment: :map,
      reviewers: {:array, :map},
      wait_timer: :integer,
      wait_timer_started_at: :string
    ]
  end
end
