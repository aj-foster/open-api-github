defmodule GitHub.Manifest do
  @moduledoc """
  Provides struct and type for Manifest
  """

  @type t :: %__MODULE__{
          __info__: map,
          file: map | nil,
          metadata: GitHub.Metadata.t() | nil,
          name: String.t(),
          resolved: map | nil
        }

  defstruct [:__info__, :file, :metadata, :name, :resolved]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [file: :map, metadata: {GitHub.Metadata, :t}, name: :string, resolved: :map]
  end
end
