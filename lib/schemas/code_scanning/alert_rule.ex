defmodule GitHub.CodeScanning.AlertRule do
  @moduledoc """
  Provides struct and type for CodeScanningAlertRule
  """

  @type t :: %__MODULE__{
          __info__: map,
          description: String.t() | nil,
          full_description: String.t() | nil,
          help: String.t() | nil,
          help_uri: String.t() | nil,
          id: String.t() | nil,
          name: String.t() | nil,
          security_severity_level: String.t() | nil,
          severity: String.t() | nil,
          tags: [String.t()] | nil
        }

  defstruct [
    :__info__,
    :description,
    :full_description,
    :help,
    :help_uri,
    :id,
    :name,
    :security_severity_level,
    :severity,
    :tags
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      description: :string,
      full_description: :string,
      help: {:nullable, :string},
      help_uri: {:nullable, :string},
      id: {:nullable, :string},
      name: :string,
      security_severity_level: {:nullable, :string},
      severity: {:nullable, :string},
      tags: {:nullable, {:array, :string}}
    ]
  end
end
