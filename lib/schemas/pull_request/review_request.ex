defmodule GitHub.PullRequest.ReviewRequest do
  @moduledoc """
  Provides struct and type for PullRequestReviewRequest
  """

  @type t :: %__MODULE__{teams: [GitHub.Team.t()], users: [GitHub.User.simple()]}

  defstruct [:teams, :users]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [teams: {:array, {GitHub.Team, :t}}, users: {:array, {GitHub.User, :simple}}]
  end
end
