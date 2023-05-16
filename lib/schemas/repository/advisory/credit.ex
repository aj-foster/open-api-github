defmodule GitHub.Repository.Advisory.Credit do
  @moduledoc """
  Provides struct and type for RepositoryAdvisoryCredit
  """

  @type t :: %__MODULE__{state: String.t(), type: String.t(), user: GitHub.User.simple()}

  defstruct [:state, :type, :user]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [state: :string, type: :string, user: {GitHub.User, :simple}]
  end
end
