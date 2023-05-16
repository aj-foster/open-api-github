defmodule GitHub.Deployment.ProtectionRule do
  @moduledoc """
  Provides struct and type for DeploymentProtectionRule
  """

  @type t :: %__MODULE__{
          app: GitHub.CustomDeploymentRuleApp.t(),
          enabled: boolean,
          id: integer,
          node_id: String.t()
        }

  defstruct [:app, :enabled, :id, :node_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [app: {GitHub.CustomDeploymentRuleApp, :t}, enabled: :boolean, id: :integer, node_id: :string]
  end
end
