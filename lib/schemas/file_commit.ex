defmodule GitHub.FileCommit do
  @moduledoc """
  Provides struct and type for FileCommit
  """

  @type t :: %__MODULE__{commit: map, content: map | nil}

  defstruct [:commit, :content]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [commit: :map, content: {:nullable, :map}]
  end
end
