defmodule GitHub.EnterpriseSecurityAnalysisSettings do
  @moduledoc """
  Provides struct and type for EnterpriseSecurityAnalysisSettings
  """

  @type t :: %__MODULE__{
          advanced_security_enabled_for_new_repositories: boolean,
          secret_scanning_enabled_for_new_repositories: boolean,
          secret_scanning_push_protection_custom_link: String.t() | nil,
          secret_scanning_push_protection_enabled_for_new_repositories: boolean
        }

  defstruct [
    :advanced_security_enabled_for_new_repositories,
    :secret_scanning_enabled_for_new_repositories,
    :secret_scanning_push_protection_custom_link,
    :secret_scanning_push_protection_enabled_for_new_repositories
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      advanced_security_enabled_for_new_repositories: :boolean,
      secret_scanning_enabled_for_new_repositories: :boolean,
      secret_scanning_push_protection_custom_link: :string,
      secret_scanning_push_protection_enabled_for_new_repositories: :boolean
    ]
  end
end
