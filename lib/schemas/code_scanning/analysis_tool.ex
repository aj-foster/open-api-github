defmodule GitHub.CodeScanning.AnalysisTool do
  @moduledoc """
  Provides struct and type for CodeScanningAnalysisTool
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          guid: String.t() | nil,
          name: String.t() | nil,
          version: String.t() | nil
        }

  defstruct [:__info__, :guid, :name, :version]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [guid: {:nullable, :string}, name: :string, version: {:nullable, :string}]
  end
end
