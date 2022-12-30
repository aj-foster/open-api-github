defmodule GitHub.Git.IgnoreTemplate do
  @moduledoc """
  Provides struct and type for GitignoreTemplate
  """

  @type t :: %__MODULE__{name: String.t(), source: String.t()}

  defstruct [:name, :source]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [name: :string, source: :string]
  end
end
