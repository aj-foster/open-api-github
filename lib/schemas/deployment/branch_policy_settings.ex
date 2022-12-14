defmodule GitHub.Deployment.BranchPolicySettings do
  @moduledoc """
  Provides struct and type for DeploymentBranchPolicySettings
  """

  @type t :: %__MODULE__{custom_branch_policies: boolean, protected_branches: boolean}

  defstruct [:custom_branch_policies, :protected_branches]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [custom_branch_policies: :boolean, protected_branches: :boolean]
  end
end
