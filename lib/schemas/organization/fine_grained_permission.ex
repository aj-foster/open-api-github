defmodule GitHub.Organization.FineGrainedPermission do
  @moduledoc """
  Provides struct and type for OrganizationFineGrainedPermission
  """

  @type t :: %__MODULE__{description: String.t(), name: String.t()}

  defstruct [:description, :name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [description: :string, name: :string]
  end
end
