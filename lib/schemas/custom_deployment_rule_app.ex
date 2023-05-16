defmodule GitHub.CustomDeploymentRuleApp do
  @moduledoc """
  Provides struct and type for CustomDeploymentRuleApp
  """

  @type t :: %__MODULE__{
          id: integer,
          integration_url: String.t(),
          node_id: String.t(),
          slug: String.t()
        }

  defstruct [:id, :integration_url, :node_id, :slug]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [id: :integer, integration_url: :string, node_id: :string, slug: :string]
  end
end