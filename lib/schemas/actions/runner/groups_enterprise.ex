defmodule GitHub.Actions.Runner.GroupsEnterprise do
  @moduledoc """
  Provides struct and type for RunnerGroupsEnterprise
  """

  @type t :: %__MODULE__{
          allows_public_repositories: boolean,
          default: boolean,
          id: number,
          name: String.t(),
          restricted_to_workflows: boolean | nil,
          runners_url: String.t(),
          selected_organizations_url: String.t() | nil,
          selected_workflows: [String.t()] | nil,
          visibility: String.t(),
          workflow_restrictions_read_only: boolean | nil
        }

  defstruct [
    :allows_public_repositories,
    :default,
    :id,
    :name,
    :restricted_to_workflows,
    :runners_url,
    :selected_organizations_url,
    :selected_workflows,
    :visibility,
    :workflow_restrictions_read_only
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      allows_public_repositories: :boolean,
      default: :boolean,
      id: :number,
      name: :string,
      restricted_to_workflows: :boolean,
      runners_url: :string,
      selected_organizations_url: :string,
      selected_workflows: {:array, :string},
      visibility: :string,
      workflow_restrictions_read_only: :boolean
    ]
  end
end
