defmodule GitHub.Actions.CacheList do
  @moduledoc """
  Provides struct and type for ActionsCacheList
  """

  @type t :: %__MODULE__{actions_caches: [map], total_count: integer}

  defstruct [:actions_caches, :total_count]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [actions_caches: {:array, :map}, total_count: :integer]
  end
end
