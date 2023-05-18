defmodule GitHub.Repository.Rule.PullRequest do
  @moduledoc """
  Provides struct and type for RepositoryRulePullRequest
  """

  @type t :: %__MODULE__{__info__: map, parameters: map | nil, type: String.t()}

  defstruct [:__info__, :parameters, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [parameters: :map, type: :string]
  end
end
