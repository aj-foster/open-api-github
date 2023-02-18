defmodule GitHub.CodeScanning.AlertInstance do
  @moduledoc """
  Provides struct and type for CodeScanningAlertInstance
  """

  @type t :: %__MODULE__{
          analysis_key: String.t() | nil,
          category: String.t() | nil,
          classifications: [String.t() | nil] | nil,
          commit_sha: String.t() | nil,
          environment: String.t() | nil,
          html_url: String.t() | nil,
          location: GitHub.CodeScanning.AlertLocation.t() | nil,
          message: map | nil,
          ref: String.t() | nil,
          state: String.t() | nil
        }

  defstruct [
    :analysis_key,
    :category,
    :classifications,
    :commit_sha,
    :environment,
    :html_url,
    :location,
    :message,
    :ref,
    :state
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      analysis_key: :string,
      category: :string,
      classifications: {:array, {:nullable, :string}},
      commit_sha: :string,
      environment: :string,
      html_url: :string,
      location: {GitHub.CodeScanning.AlertLocation, :t},
      message: :map,
      ref: :string,
      state: :string
    ]
  end
end
