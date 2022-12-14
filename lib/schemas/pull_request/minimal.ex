defmodule GitHub.PullRequest.Minimal do
  @moduledoc """
  Provides struct and type for PullRequestMinimal
  """

  @type t :: %__MODULE__{base: map, head: map, id: integer, number: integer, url: String.t()}

  defstruct [:base, :head, :id, :number, :url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [base: :map, head: :map, id: :integer, number: :integer, url: :string]
  end
end
