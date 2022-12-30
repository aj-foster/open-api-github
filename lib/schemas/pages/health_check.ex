defmodule GitHub.Pages.HealthCheck do
  @moduledoc """
  Provides struct and type for PagesHealthCheck
  """

  @type t :: %__MODULE__{alt_domain: map | nil, domain: map | nil}

  defstruct [:alt_domain, :domain]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [alt_domain: :map, domain: :map]
  end
end
