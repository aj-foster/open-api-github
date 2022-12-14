defmodule GitHub.Check.SuitePreference do
  @moduledoc """
  Provides struct and type for CheckSuitePreference
  """

  @type t :: %__MODULE__{preferences: map, repository: GitHub.MinimalRepository.t()}

  defstruct [:preferences, :repository]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [preferences: :map, repository: {GitHub.MinimalRepository, :t}]
  end
end
