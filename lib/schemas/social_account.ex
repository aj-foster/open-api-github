defmodule GitHub.SocialAccount do
  @moduledoc """
  Provides struct and type for SocialAccount
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{__info__: map, provider: String.t(), url: String.t()}

  defstruct [:__info__, :provider, :url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [provider: :string, url: :string]
  end
end
