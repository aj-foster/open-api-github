defmodule GitHub.Actions.Runner.Label do
  @moduledoc """
  Provides struct and type for RunnerLabel
  """

  @type t :: %__MODULE__{id: integer | nil, name: String.t(), type: String.t() | nil}

  defstruct [:id, :name, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [id: :integer, name: :string, type: :string]
  end
end
