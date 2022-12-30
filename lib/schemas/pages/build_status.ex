defmodule GitHub.Pages.BuildStatus do
  @moduledoc """
  Provides struct and type for PageBuildStatus
  """

  @type t :: %__MODULE__{status: String.t(), url: String.t()}

  defstruct [:status, :url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [status: :string, url: :string]
  end
end
