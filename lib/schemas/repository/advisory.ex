defmodule GitHub.Repository.Advisory do
  @moduledoc """
  Provides struct and type for RepositoryAdvisory
  """

  @type t :: %__MODULE__{
          author: nil,
          closed_at: String.t() | nil,
          created_at: String.t() | nil,
          credits: [map] | nil,
          credits_detailed: [GitHub.Repository.AdvisoryCredit.t()] | nil,
          cve_id: String.t() | nil,
          cvss: map | nil,
          cwe_ids: [String.t()] | nil,
          cwes: [map] | nil,
          description: String.t() | nil,
          ghsa_id: String.t(),
          html_url: String.t(),
          identifiers: [map],
          published_at: String.t() | nil,
          publisher: nil,
          severity: String.t() | nil,
          state: String.t(),
          submission: map | nil,
          summary: String.t(),
          updated_at: String.t() | nil,
          url: String.t(),
          vulnerabilities: [GitHub.Repository.AdvisoryVulnerability.t()] | nil,
          withdrawn_at: String.t() | nil
        }

  defstruct [
    :author,
    :closed_at,
    :created_at,
    :credits,
    :credits_detailed,
    :cve_id,
    :cvss,
    :cwe_ids,
    :cwes,
    :description,
    :ghsa_id,
    :html_url,
    :identifiers,
    :published_at,
    :publisher,
    :severity,
    :state,
    :submission,
    :summary,
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
      author: :null,
      closed_at: {:nullable, :string},
      created_at: {:nullable, :string},
      credits: {:nullable, {:array, :map}},
      credits_detailed: {:nullable, {:array, {GitHub.Repository.AdvisoryCredit, :t}}},
      cve_id: {:nullable, :string},
      cvss: {:nullable, :map},
      cwe_ids: {:nullable, {:array, :string}},
      cwes: {:nullable, {:array, :map}},
      description: {:nullable, :string},
      ghsa_id: :string,
      html_url: :string,
      identifiers: {:array, :map},
      published_at: {:nullable, :string},
      publisher: :null,
      severity: {:nullable, :string},
      state: :string,
      submission: {:nullable, :map},
      summary: :string,
      updated_at: {:nullable, :string},
      url: :string,
      vulnerabilities: {:nullable, {:array, {GitHub.Repository.AdvisoryVulnerability, :t}}},
      withdrawn_at: {:nullable, :string}
    ]
  end
end
