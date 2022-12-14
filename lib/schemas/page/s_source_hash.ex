defmodule :"Elixir.GitHub.Page.sSourceHash" do
  @moduledoc """
  Provides struct and type for PagesSourceHash
  """

  @type t :: %__MODULE__{branch: String.t(), path: String.t()}

  defstruct [:branch, :path]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [branch: :string, path: :string]
  end
end
