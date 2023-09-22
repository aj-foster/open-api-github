defmodule GitHub.Repository.Advisory.Create do
  @moduledoc """
  Provides struct and type for a Repository.Advisory.Create
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
      credits: {:union, [[:map], :null]},
      cve_id: {:union, [{:string, :generic}, :null]},
      cvss_vector_string: {:union, [{:string, :generic}, :null]},
      cwe_ids: {:union, [[string: :generic], :null]},
      description: {:string, :generic},
      severity: {:enum, ["critical", "high", "medium", "low", nil]},
      summary: {:string, :generic},
      vulnerabilities: [:map]
    ]
  end
end
