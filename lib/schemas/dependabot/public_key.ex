defmodule GitHub.Dependabot.PublicKey do
  @moduledoc """
  Provides struct and type for DependabotPublicKey
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{__info__: map, key: String.t(), key_id: String.t()}

  defstruct [:__info__, :key, :key_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [key: :string, key_id: :string]
  end
end
