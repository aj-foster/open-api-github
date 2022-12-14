defmodule GitHub.Actions.RepositoryPermissions do
  @moduledoc """
  Provides struct and type for ActionsRepositoryPermissions
  """

  @type t :: %__MODULE__{
          allowed_actions: String.t() | nil,
          enabled: boolean,
          selected_actions_url: String.t() | nil
        }

  defstruct [:allowed_actions, :enabled, :selected_actions_url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [allowed_actions: :string, enabled: :boolean, selected_actions_url: :string]
  end
end
