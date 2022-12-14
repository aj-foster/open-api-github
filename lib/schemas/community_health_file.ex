defmodule GitHub.CommunityHealthFile do
  @moduledoc """
  Provides struct and type for NullableCommunityHealthFile
  """

  @type nullable :: %__MODULE__{html_url: String.t(), url: String.t()}

  defstruct [:html_url, :url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(:nullable) do
    [html_url: :string, url: :string]
  end
end
