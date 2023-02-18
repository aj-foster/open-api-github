defmodule GitHub.Issue.EventLabel do
  @moduledoc """
  Provides struct and type for IssueEventLabel
  """

  @type t :: %__MODULE__{color: String.t() | nil, name: String.t() | nil}

  defstruct [:color, :name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [color: {:nullable, :string}, name: {:nullable, :string}]
  end
end
