defmodule GitHub.Deployment.BranchPolicy do
  @moduledoc """
  Provides struct and type for DeploymentBranchPolicy
  """

  @type t :: %__MODULE__{id: integer | nil, name: String.t() | nil, node_id: String.t() | nil}

  defstruct [:id, :name, :node_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [id: :integer, name: :string, node_id: :string]
  end
end
