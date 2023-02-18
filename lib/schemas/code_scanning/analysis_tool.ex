defmodule GitHub.CodeScanning.AnalysisTool do
  @moduledoc """
  Provides struct and type for CodeScanningAnalysisTool
  """

  @type t :: %__MODULE__{
          guid: String.t() | nil,
          name: String.t() | nil,
          version: String.t() | nil
        }

  defstruct [:guid, :name, :version]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [guid: {:nullable, :string}, name: :string, version: {:nullable, :string}]
  end
end
