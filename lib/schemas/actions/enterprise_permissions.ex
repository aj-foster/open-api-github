defmodule GitHub.Actions.EnterprisePermissions do
  @moduledoc """
  Provides struct and type for ActionsEnterprisePermissions
  """

  @type t :: %__MODULE__{
          allowed_actions: String.t() | nil,
          enabled_organizations: String.t(),
          selected_actions_url: String.t() | nil,
          selected_organizations_url: String.t() | nil
        }

  defstruct [
    :allowed_actions,
    :enabled_organizations,
    :selected_actions_url,
    :selected_organizations_url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      allowed_actions: :string,
      enabled_organizations: :string,
      selected_actions_url: :string,
      selected_organizations_url: :string
    ]
  end
end
