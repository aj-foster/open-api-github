defmodule GitHub.OIDCCustomSubRepo do
  @moduledoc """
  Provides struct and type for OidcCustomSubRepo
  """

  @type t :: %__MODULE__{include_claim_keys: [String.t()] | nil, use_default: boolean}

  defstruct [:include_claim_keys, :use_default]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [include_claim_keys: {:array, :string}, use_default: :boolean]
  end
end
