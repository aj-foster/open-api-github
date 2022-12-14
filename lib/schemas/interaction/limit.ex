defmodule GitHub.Interaction.Limit do
  @moduledoc """
  Provides struct and type for InteractionLimit
  """

  @type t :: %__MODULE__{expiry: String.t() | nil, limit: String.t()}

  defstruct [:expiry, :limit]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [expiry: :string, limit: :string]
  end
end
