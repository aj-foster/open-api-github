defmodule GitHub.Dependabot.Alert.Package do
  @moduledoc """
  Provides struct and type for DependabotAlertPackage
  """

  @type t :: %__MODULE__{ecosystem: String.t(), name: String.t()}

  defstruct [:ecosystem, :name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [ecosystem: :string, name: :string]
  end
end
