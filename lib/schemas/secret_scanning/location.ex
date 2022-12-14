defmodule GitHub.SecretScanning.Location do
  @moduledoc """
  Provides struct and type for SecretScanningLocation
  """

  @type t :: %__MODULE__{
          details:
            GitHub.SecretScanning.LocationCommit.t()
            | GitHub.SecretScanning.LocationIssueBody.t()
            | GitHub.SecretScanning.LocationIssueComment.t()
            | GitHub.SecretScanning.LocationIssueTitle.t(),
          type: String.t()
        }

  defstruct [:details, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      details:
        {:union,
         [
           {GitHub.SecretScanning.LocationCommit, :t},
           {GitHub.SecretScanning.LocationIssueTitle, :t},
           {GitHub.SecretScanning.LocationIssueBody, :t},
           {GitHub.SecretScanning.LocationIssueComment, :t}
         ]},
      type: :string
    ]
  end
end
