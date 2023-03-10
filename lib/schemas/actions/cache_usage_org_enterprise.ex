defmodule GitHub.Actions.CacheUsageOrgEnterprise do
  @moduledoc """
  Provides struct and type for ActionsCacheUsageOrgEnterprise
  """

  @type t :: %__MODULE__{
          total_active_caches_count: integer,
          total_active_caches_size_in_bytes: integer
        }

  defstruct [:total_active_caches_count, :total_active_caches_size_in_bytes]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [total_active_caches_count: :integer, total_active_caches_size_in_bytes: :integer]
  end
end
