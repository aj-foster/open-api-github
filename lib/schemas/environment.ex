defmodule GitHub.Environment do
  @moduledoc """
  Provides struct and type for Environment
  """

  @type t :: %__MODULE__{
          __info__: map,
          created_at: String.t(),
          deployment_branch_policy: GitHub.Deployment.BranchPolicySettings.t() | nil,
          html_url: String.t(),
          id: integer,
          name: String.t(),
          node_id: String.t(),
          protection_rules: [map] | nil,
          updated_at: String.t(),
          url: String.t()
        }

  defstruct [
    :__info__,
    :created_at,
    :deployment_branch_policy,
    :html_url,
    :id,
    :name,
    :node_id,
    :protection_rules,
    :updated_at,
    :url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      created_at: :string,
      deployment_branch_policy: {:nullable, {GitHub.Deployment.BranchPolicySettings, :t}},
      html_url: :string,
      id: :integer,
      name: :string,
      node_id: :string,
      protection_rules: {:array, :map},
      updated_at: :string,
      url: :string
    ]
  end
end
