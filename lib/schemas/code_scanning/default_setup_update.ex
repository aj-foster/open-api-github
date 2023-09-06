defmodule GitHub.CodeScanning.DefaultSetupUpdate do
  @moduledoc """
  Provides struct and type for CodeScanningDefaultSetupUpdate
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          languages: [String.t()] | nil,
          query_suite: String.t() | nil,
          state: String.t()
        }

  defstruct [:__info__, :languages, :query_suite, :state]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [languages: {:array, :string}, query_suite: :string, state: :string]
  end
end
