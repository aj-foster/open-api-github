defmodule GitHub.Hovercard do
  @moduledoc """
  Provides struct and type for Hovercard
  """

  @type t :: %__MODULE__{__info__: map, contexts: [map]}

  defstruct [:__info__, :contexts]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [contexts: {:array, :map}]
  end
end
