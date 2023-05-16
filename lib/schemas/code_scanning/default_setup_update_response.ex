defmodule GitHub.CodeScanning.DefaultSetupUpdateResponse do
  @moduledoc """
  Provides struct and type for CodeScanningDefaultSetupUpdateResponse
  """

  @type t :: %__MODULE__{run_id: integer | nil, run_url: String.t() | nil}

  defstruct [:run_id, :run_url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [run_id: :integer, run_url: :string]
  end
end
