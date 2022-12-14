defmodule GitHub.Git.Ref do
  @moduledoc """
  Provides struct and type for GitRef
  """

  @type t :: %__MODULE__{node_id: String.t(), object: map, ref: String.t(), url: String.t()}

  defstruct [:node_id, :object, :ref, :url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [node_id: :string, object: :map, ref: :string, url: :string]
  end
end
