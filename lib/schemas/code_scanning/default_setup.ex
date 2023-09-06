defmodule GitHub.CodeScanning.DefaultSetup do
  @moduledoc """
  Provides struct and type for CodeScanningDefaultSetup
  """

  @type t :: %__MODULE__{
          __info__: map,
          languages: [String.t()] | nil,
          query_suite: String.t() | nil,
          schedule: String.t() | nil,
          state: String.t() | nil,
          updated_at: String.t() | nil
        }

  defstruct [:__info__, :languages, :query_suite, :schedule, :state, :updated_at]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      languages: {:array, :string},
      query_suite: :string,
      schedule: {:nullable, :string},
      state: :string,
      updated_at: {:nullable, :string}
    ]
  end
end
