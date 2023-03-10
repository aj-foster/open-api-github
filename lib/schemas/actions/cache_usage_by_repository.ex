defmodule GitHub.Actions.CacheUsageByRepository do
  @moduledoc """
  Provides struct and type for ActionsCacheUsageByRepository
  """

  @type t :: %__MODULE__{
          active_caches_count: integer,
          active_caches_size_in_bytes: integer,
          full_name: String.t()
        }

  defstruct [:active_caches_count, :active_caches_size_in_bytes, :full_name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [active_caches_count: :integer, active_caches_size_in_bytes: :integer, full_name: :string]
  end
end
