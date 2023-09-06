defmodule GitHub.Repository.Advisory.Create do
  @moduledoc """
  Provides struct and type for RepositoryAdvisoryCreate
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          credits: [map] | nil,
          cve_id: String.t() | nil,
          cvss_vector_string: String.t() | nil,
          cwe_ids: [String.t()] | nil,
          description: String.t(),
          severity: String.t() | nil,
          summary: String.t(),
          vulnerabilities: [map]
        }

  defstruct [
    :__info__,
    :credits,
    :cve_id,
    :cvss_vector_string,
    :cwe_ids,
    :description,
    :severity,
    :summary,
    :vulnerabilities
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      credits: {:nullable, {:array, :map}},
      cve_id: {:nullable, :string},
      cvss_vector_string: {:nullable, :string},
      cwe_ids: {:nullable, {:array, :string}},
      description: :string,
      severity: {:nullable, :string},
      summary: :string,
      vulnerabilities: {:array, :map}
    ]
  end
end
