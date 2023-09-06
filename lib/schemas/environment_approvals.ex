defmodule GitHub.EnvironmentApprovals do
  @moduledoc """
  Provides struct and type for EnvironmentApprovals
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          comment: String.t(),
          environments: [map],
          state: String.t(),
          user: GitHub.User.simple()
        }

  defstruct [:__info__, :comment, :environments, :state, :user]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [comment: :string, environments: {:array, :map}, state: :string, user: {GitHub.User, :simple}]
  end
end
