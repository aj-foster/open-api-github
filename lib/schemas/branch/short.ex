defmodule GitHub.Branch.Short do
  @moduledoc """
  Provides struct and type for BranchShort
  """

  @type t :: %__MODULE__{commit: map, name: String.t(), protected: boolean}

  defstruct [:commit, :name, :protected]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [commit: :map, name: :string, protected: :boolean]
  end
end
