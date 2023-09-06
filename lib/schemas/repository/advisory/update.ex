defmodule GitHub.Repository.Advisory.Update do
  @moduledoc """
  Provides struct and type for RepositoryAdvisoryUpdate
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          collaborating_teams: [String.t()] | nil,
          collaborating_users: [String.t()] | nil,
          credits: [map] | nil,
          cve_id: String.t() | nil,
          cvss_vector_string: String.t() | nil,
          cwe_ids: [String.t()] | nil,
          description: String.t() | nil,
          severity: String.t() | nil,
          state: String.t() | nil,
          summary: String.t() | nil,
          vulnerabilities: [map] | nil
        }

  defstruct [
    :__info__,
    :collaborating_teams,
    :collaborating_users,
    :credits,
    :cve_id,
    :cvss_vector_string,
    :cwe_ids,
    :description,
    :severity,
    :state,
    :summary,
    :vulnerabilities
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      collaborating_teams: {:nullable, {:array, :string}},
      collaborating_users: {:nullable, {:array, :string}},
      credits: {:nullable, {:array, :map}},
      cve_id: {:nullable, :string},
      cvss_vector_string: {:nullable, :string},
      cwe_ids: {:nullable, {:array, :string}},
      description: :string,
      severity: {:nullable, :string},
      state: :string,
      summary: :string,
      vulnerabilities: {:array, :map}
    ]
  end
end
