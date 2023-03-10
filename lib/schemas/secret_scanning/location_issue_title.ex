defmodule GitHub.SecretScanning.LocationIssueTitle do
  @moduledoc """
  Provides struct and type for SecretScanningLocationIssueTitle
  """

  @type t :: %__MODULE__{issue_title_url: String.t()}

  defstruct [:issue_title_url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [issue_title_url: :string]
  end
end
