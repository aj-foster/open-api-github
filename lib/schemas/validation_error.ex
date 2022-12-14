defmodule GitHub.ValidationError do
  @moduledoc """
  Provides struct and types for ValidationError, ValidationErrorSimple
  """

  @type simple :: %__MODULE__{
          documentation_url: String.t(),
          errors: [String.t()] | nil,
          message: String.t()
        }

  @type t :: %__MODULE__{documentation_url: String.t(), errors: [map] | nil, message: String.t()}

  defstruct [:documentation_url, :errors, :message]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:simple) do
    [documentation_url: :string, errors: {:array, :string}, message: :string]
  end

  def __fields__(:t) do
    [documentation_url: :string, errors: {:array, :map}, message: :string]
  end
end
