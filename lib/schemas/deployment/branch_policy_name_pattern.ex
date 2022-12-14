defmodule GitHub.Deployment.BranchPolicyNamePattern do
  @moduledoc """
  Provides struct and type for DeploymentBranchPolicyNamePattern
  """

  @type t :: %__MODULE__{name: String.t()}

  defstruct [:name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [name: :string]
  end
end
