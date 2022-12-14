defmodule GitHub.SecretScanning.LocationIssueBody do
  @moduledoc """
  Provides struct and type for SecretScanningLocationIssueBody
  """

  @type t :: %__MODULE__{issue_body_url: String.t()}

  defstruct [:issue_body_url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [issue_body_url: :string]
  end
end
