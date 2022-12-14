defmodule GitHub.Actions.OrganizationPermissions do
  @moduledoc """
  Provides struct and type for ActionsOrganizationPermissions
  """

  @type t :: %__MODULE__{
          allowed_actions: String.t() | nil,
          enabled_repositories: String.t(),
          selected_actions_url: String.t() | nil,
          selected_repositories_url: String.t() | nil
        }

  defstruct [
    :allowed_actions,
    :enabled_repositories,
    :selected_actions_url,
    :selected_repositories_url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      allowed_actions: :string,
      enabled_repositories: :string,
      selected_actions_url: :string,
      selected_repositories_url: :string
    ]
  end
end
