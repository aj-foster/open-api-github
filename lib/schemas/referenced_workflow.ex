defmodule GitHub.ReferencedWorkflow do
  @moduledoc """
  Provides struct and type for ReferencedWorkflow
  """

  @type t :: %__MODULE__{path: String.t(), ref: String.t() | nil, sha: String.t()}

  defstruct [:path, :ref, :sha]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [path: :string, ref: :string, sha: :string]
  end
end
