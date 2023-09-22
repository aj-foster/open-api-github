defmodule GitHub.Pages.HealthCheck do
  @moduledoc """
  Provides struct and type for a Pages.HealthCheck
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{__info__: map, alt_domain: map | nil, domain: map | nil}

  defstruct [:__info__, :alt_domain, :domain]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [alt_domain: {:union, [:map, :null]}, domain: :map]
  end
end
