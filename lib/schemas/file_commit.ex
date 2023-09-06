defmodule GitHub.FileCommit do
  @moduledoc """
  Provides struct and type for FileCommit
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{__info__: map, commit: map, content: map | nil}

  defstruct [:__info__, :commit, :content]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [commit: :map, content: {:nullable, :map}]
  end
end
