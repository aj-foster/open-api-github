defmodule GitHub.Repository.Advisory.Credit do
  @moduledoc """
  Provides struct and type for RepositoryAdvisoryCredit
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          state: String.t(),
          type: String.t(),
          user: GitHub.User.simple()
        }

  defstruct [:__info__, :state, :type, :user]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [state: :string, type: :string, user: {GitHub.User, :simple}]
  end
end
