defmodule GitHub.Dependency do
  @moduledoc """
  Provides struct and type for Dependency
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          dependencies: [String.t()] | nil,
          metadata: GitHub.Metadata.t() | nil,
          package_url: String.t() | nil,
          relationship: String.t() | nil,
          scope: String.t() | nil
        }

  defstruct [:__info__, :dependencies, :metadata, :package_url, :relationship, :scope]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      dependencies: {:array, :string},
      metadata: {GitHub.Metadata, :t},
      package_url: :string,
      relationship: :string,
      scope: :string
    ]
  end
end
