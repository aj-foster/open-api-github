defmodule GitHub.Team.Membership do
  @moduledoc """
  Provides struct and type for TeamMembership
  """

  @type t :: %__MODULE__{__info__: map, role: String.t(), state: String.t(), url: String.t()}

  defstruct [:__info__, :role, :state, :url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [role: :string, state: :string, url: :string]
  end
end
