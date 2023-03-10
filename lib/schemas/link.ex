defmodule GitHub.Link do
  @moduledoc """
  Provides struct and type for Link
  """

  @type t :: %__MODULE__{href: String.t()}

  defstruct [:href]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [href: :string]
  end
end
