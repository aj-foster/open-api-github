defmodule GitHub.StarredRepository do
  @moduledoc """
  Provides struct and type for StarredRepository
  """

  @type t :: %__MODULE__{repo: GitHub.Repository.t(), starred_at: String.t()}

  defstruct [:repo, :starred_at]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [repo: {GitHub.Repository, :t}, starred_at: :string]
  end
end
