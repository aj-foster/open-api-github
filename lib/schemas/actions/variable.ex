defmodule GitHub.Actions.Variable do
  @moduledoc """
  Provides struct and type for ActionsVariable
  """

  @type t :: %__MODULE__{
          created_at: String.t(),
          name: String.t(),
          updated_at: String.t(),
          value: String.t()
        }

  defstruct [:created_at, :name, :updated_at, :value]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [created_at: :string, name: :string, updated_at: :string, value: :string]
  end
end
