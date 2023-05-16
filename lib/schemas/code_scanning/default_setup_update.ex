defmodule GitHub.CodeScanning.DefaultSetupUpdate do
  @moduledoc """
  Provides struct and type for CodeScanningDefaultSetupUpdate
  """

  @type t :: %__MODULE__{query_suite: String.t() | nil, state: String.t()}

  defstruct [:query_suite, :state]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [query_suite: :string, state: :string]
  end
end
