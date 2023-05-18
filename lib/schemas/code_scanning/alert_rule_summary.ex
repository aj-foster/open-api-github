defmodule GitHub.CodeScanning.AlertRuleSummary do
  @moduledoc """
  Provides struct and type for CodeScanningAlertRuleSummary
  """

  @type t :: %__MODULE__{
          __info__: map,
          description: String.t() | nil,
          id: String.t() | nil,
          name: String.t() | nil,
          severity: String.t() | nil,
          tags: [String.t()] | nil
        }

  defstruct [:__info__, :description, :id, :name, :severity, :tags]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      description: :string,
      id: {:nullable, :string},
      name: :string,
      severity: {:nullable, :string},
      tags: {:nullable, {:array, :string}}
    ]
  end
end
