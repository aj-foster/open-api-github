defmodule GitHub.PullRequest.MergeResult do
  @moduledoc """
  Provides struct and type for PullRequestMergeResult
  """

  @type t :: %__MODULE__{merged: boolean, message: String.t(), sha: String.t()}

  defstruct [:merged, :message, :sha]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [merged: :boolean, message: :string, sha: :string]
  end
end
