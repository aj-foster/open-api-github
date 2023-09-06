defmodule GitHub.Dependabot.Alert.SecurityAdvisory do
  @moduledoc """
  Provides struct and type for DependabotAlertSecurityAdvisory
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          cve_id: String.t() | nil,
          cvss: map,
          cwes: [map],
          description: String.t(),
          ghsa_id: String.t(),
          identifiers: [map],
          published_at: String.t(),
          references: [map],
          severity: String.t(),
          summary: String.t(),
          updated_at: String.t(),
          vulnerabilities: [GitHub.Dependabot.Alert.SecurityVulnerability.t()],
          withdrawn_at: String.t() | nil
        }

  defstruct [
    :__info__,
    :cve_id,
    :cvss,
    :cwes,
    :description,
    :ghsa_id,
    :identifiers,
    :published_at,
    :references,
    :severity,
    :summary,
    :updated_at,
    :vulnerabilities,
    :withdrawn_at
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      cve_id: {:nullable, :string},
      cvss: :map,
      cwes: {:array, :map},
      description: :string,
      ghsa_id: :string,
      identifiers: {:array, :map},
      published_at: :string,
      references: {:array, :map},
      severity: :string,
      summary: :string,
      updated_at: :string,
      vulnerabilities: {:array, {GitHub.Dependabot.Alert.SecurityVulnerability, :t}},
      withdrawn_at: {:nullable, :string}
    ]
  end
end
