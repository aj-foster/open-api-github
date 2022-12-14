defmodule GitHub.Dependabot.PublicKey do
  @moduledoc """
  Provides struct and type for DependabotPublicKey
  """

  @type t :: %__MODULE__{key: String.t(), key_id: String.t()}

  defstruct [:key, :key_id]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [key: :string, key_id: :string]
  end
end
