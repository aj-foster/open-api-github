defmodule GitHub.GlobalAdvisory do
  @moduledoc """
  Provides struct and type for GlobalAdvisory
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          credits: [map] | nil,
          cve_id: String.t() | nil,
          cvss: map | nil,
          cwes: [map] | nil,
          description: String.t() | nil,
          ghsa_id: String.t(),
          github_reviewed_at: String.t() | nil,
          html_url: String.t(),
          identifiers: [map] | nil,
          nvd_published_at: String.t() | nil,
          published_at: String.t(),
          references: [String.t()] | nil,
          repository_advisory_url: String.t() | nil,
          severity: String.t(),
          source_code_location: String.t() | nil,
          summary: String.t(),
          type: String.t(),
          updated_at: String.t(),
          url: String.t(),
          vulnerabilities: [map] | nil,
          withdrawn_at: String.t() | nil
        }

  defstruct [
    :__info__,
    :credits,
    :cve_id,
    :cvss,
    :cwes,
    :description,
    :ghsa_id,
    :github_reviewed_at,
    :html_url,
    :identifiers,
    :nvd_published_at,
    :published_at,
    :references,
    :repository_advisory_url,
    :severity,
    :source_code_location,
    :summary,
    :type,
    :updated_at,
    :url,
    :vulnerabilities,
    :withdrawn_at
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      credits: {:nullable, {:array, :map}},
      cve_id: {:nullable, :string},
      cvss: {:nullable, :map},
      cwes: {:nullable, {:array, :map}},
      description: {:nullable, :string},
      ghsa_id: :string,
      github_reviewed_at: {:nullable, :string},
      html_url: :string,
      identifiers: {:nullable, {:array, :map}},
      nvd_published_at: {:nullable, :string},
      published_at: :string,
      references: {:nullable, {:array, :string}},
      repository_advisory_url: {:nullable, :string},
      severity: :string,
      source_code_location: {:nullable, :string},
      summary: :string,
      type: :string,
      updated_at: :string,
      url: :string,
      vulnerabilities: {:nullable, {:array, :map}},
      withdrawn_at: {:nullable, :string}
    ]
  end
end
