defmodule GitHub.CodeScanning.SarifsStatus do
  @moduledoc """
  Provides struct and type for CodeScanningSarifsStatus
  """

  @type t :: %__MODULE__{
          analyses_url: String.t() | nil,
          errors: [String.t()] | nil,
          processing_status: String.t() | nil
        }

  defstruct [:analyses_url, :errors, :processing_status]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [analyses_url: :string, errors: {:array, :string}, processing_status: :string]
  end
end
