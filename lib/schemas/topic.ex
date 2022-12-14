defmodule GitHub.Topic do
  @moduledoc """
  Provides struct and type for Topic
  """

  @type t :: %__MODULE__{names: [String.t()]}

  defstruct [:names]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [names: {:array, :string}]
  end
end
