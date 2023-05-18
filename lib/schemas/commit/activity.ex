defmodule GitHub.Commit.Activity do
  @moduledoc """
  Provides struct and type for CommitActivity
  """

  @type t :: %__MODULE__{__info__: map, days: [integer], total: integer, week: integer}

  defstruct [:__info__, :days, :total, :week]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [days: {:array, :integer}, total: :integer, week: :integer]
  end
end
