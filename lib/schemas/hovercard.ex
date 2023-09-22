defmodule GitHub.Hovercard do
  @moduledoc """
  Provides struct and type for a Hovercard
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{__info__: map, contexts: [map]}

  defstruct [:__info__, :contexts]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [contexts: [:map]]
  end
end
