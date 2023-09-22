defmodule GitHub.SecretScanning.Location do
  @moduledoc """
  Provides struct and type for a SecretScanning.Location
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{__info__: map, details: map, type: String.t()}

  defstruct [:__info__, :details, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [details: :map, type: {:enum, ["commit", "issue_title", "issue_body", "issue_comment"]}]
  end
end
