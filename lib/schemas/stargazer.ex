defmodule GitHub.Stargazer do
  @moduledoc """
  Provides struct and type for Stargazer
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{__info__: map, starred_at: String.t(), user: GitHub.User.simple() | nil}

  defstruct [:__info__, :starred_at, :user]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [starred_at: :string, user: {:nullable, {GitHub.User, :simple}}]
  end
end
