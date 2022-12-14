defmodule GitHub.Actions.Runner.GroupsOrg do
  @moduledoc """
  Provides struct and type for RunnerGroupsOrg
  """

  @type t :: %__MODULE__{
          allows_public_repositories: boolean,
          default: boolean,
          id: number,
          inherited: boolean,
          inherited_allows_public_repositories: boolean | nil,
          name: String.t(),
          restricted_to_workflows: boolean | nil,
          runners_url: String.t(),
          selected_repositories_url: String.t() | nil,
          selected_workflows: [String.t()] | nil,
          visibility: String.t(),
          workflow_restrictions_read_only: boolean | nil
        }

  defstruct [
    :allows_public_repositories,
    :default,
    :id,
    :inherited,
    :inherited_allows_public_repositories,
    :name,
    :restricted_to_workflows,
    :runners_url,
    :selected_repositories_url,
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
      inherited: :boolean,
      inherited_allows_public_repositories: :boolean,
      name: :string,
      restricted_to_workflows: :boolean,
      runners_url: :string,
      selected_repositories_url: :string,
      selected_workflows: {:array, :string},
      visibility: :string,
      workflow_restrictions_read_only: :boolean
    ]
  end
end
