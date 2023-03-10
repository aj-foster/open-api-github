defmodule GitHub.SecretScanning.LocationIssueComment do
  @moduledoc """
  Provides struct and type for SecretScanningLocationIssueComment
  """

  @type t :: %__MODULE__{issue_comment_url: String.t()}

  defstruct [:issue_comment_url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [issue_comment_url: :string]
  end
end
