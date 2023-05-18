defmodule GitHub.SecurityAndAnalysis do
  @moduledoc """
  Provides struct and type for SecurityAndAnalysis
  """

  @type t :: %__MODULE__{
          __info__: map,
          advanced_security: map | nil,
          secret_scanning: map | nil,
          secret_scanning_push_protection: map | nil
        }

  defstruct [:__info__, :advanced_security, :secret_scanning, :secret_scanning_push_protection]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [advanced_security: :map, secret_scanning: :map, secret_scanning_push_protection: :map]
  end
end
