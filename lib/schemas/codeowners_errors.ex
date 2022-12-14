defmodule GitHub.CodeownersErrors do
  @moduledoc """
  Provides struct and type for CodeownersErrors
  """

  @type t :: %__MODULE__{errors: [map]}

  defstruct [:errors]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [errors: {:array, :map}]
  end
end
