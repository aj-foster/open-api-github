defmodule GitHub.DependencyGraph.SpdxSbom do
  @moduledoc """
  Provides struct and type for DependencyGraphSpdxSbom
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{__info__: map, sbom: map}

  defstruct [:__info__, :sbom]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [sbom: :map]
  end
end
