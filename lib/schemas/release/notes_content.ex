defmodule GitHub.Release.NotesContent do
  @moduledoc """
  Provides struct and type for ReleaseNotesContent
  """

  @type t :: %__MODULE__{body: String.t(), name: String.t()}

  defstruct [:body, :name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [body: :string, name: :string]
  end
end
