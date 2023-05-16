defmodule GitHub.Repository.RulePullRequest do
  @moduledoc """
  Provides struct and type for RepositoryRulePullRequest
  """

  @type t :: %__MODULE__{parameters: map | nil, type: String.t()}

  defstruct [:parameters, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [parameters: :map, type: :string]
  end
end
