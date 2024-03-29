defmodule GitHub.FileCommitCommitTree do
  @moduledoc """
  Provides struct and type for a FileCommitCommitTree
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{__info__: map, sha: String.t() | nil, url: String.t() | nil}

  defstruct [:__info__, :sha, :url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [sha: {:string, :generic}, url: {:string, :generic}]
  end
end
