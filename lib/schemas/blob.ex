defmodule GitHub.Blob do
  @moduledoc """
  Provides struct and type for Blob
  """

  @type t :: %__MODULE__{
          content: String.t(),
          encoding: String.t(),
          highlighted_content: String.t() | nil,
          node_id: String.t(),
          sha: String.t(),
          size: integer | nil,
          url: String.t()
        }

  defstruct [:content, :encoding, :highlighted_content, :node_id, :sha, :size, :url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      content: :string,
      encoding: :string,
      highlighted_content: :string,
      node_id: :string,
      sha: :string,
      size: {:nullable, :integer},
      url: :string
    ]
  end
end
