defmodule GitHub.Actions.ReviewCustomGates.CommentRequired do
  @moduledoc """
  Provides struct and type for ReviewCustomGatesCommentRequired
  """

  @type t :: %__MODULE__{comment: String.t(), environment_name: String.t()}

  defstruct [:comment, :environment_name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [comment: :string, environment_name: :string]
  end
end
