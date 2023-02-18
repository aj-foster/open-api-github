defmodule GitHub.Verification do
  @moduledoc """
  Provides struct and type for Verification
  """

  @type t :: %__MODULE__{
          payload: String.t() | nil,
          reason: String.t(),
          signature: String.t() | nil,
          verified: boolean
        }

  defstruct [:payload, :reason, :signature, :verified]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      payload: {:nullable, :string},
      reason: :string,
      signature: {:nullable, :string},
      verified: :boolean
    ]
  end
end
