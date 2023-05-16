defmodule GitHub.DependencyGraph.SpdxSbom do
  @moduledoc """
  Provides struct and type for DependencyGraphSpdxSbom
  """

  @type t :: %__MODULE__{sbom: map}

  defstruct [:sbom]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [sbom: :map]
  end
end
