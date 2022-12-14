defmodule GitHub.CodeScanning.AnalysisDeletion do
  @moduledoc """
  Provides struct and type for CodeScanningAnalysisDeletion
  """

  @type t :: %__MODULE__{
          confirm_delete_url: String.t() | nil,
          next_analysis_url: String.t() | nil
        }

  defstruct [:confirm_delete_url, :next_analysis_url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [confirm_delete_url: :string, next_analysis_url: :string]
  end
end
