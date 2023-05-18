defmodule GitHub.Content.Traffic do
  @moduledoc """
  Provides struct and type for ContentTraffic
  """

  @type t :: %__MODULE__{
          __info__: map,
          count: integer,
          path: String.t(),
          title: String.t(),
          uniques: integer
        }

  defstruct [:__info__, :count, :path, :title, :uniques]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [count: :integer, path: :string, title: :string, uniques: :integer]
  end
end
