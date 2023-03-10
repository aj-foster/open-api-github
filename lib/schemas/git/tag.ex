defmodule GitHub.Git.Tag do
  @moduledoc """
  Provides struct and type for GitTag
  """

  @type t :: %__MODULE__{
          message: String.t(),
          node_id: String.t(),
          object: map,
          sha: String.t(),
          tag: String.t(),
          tagger: map,
          url: String.t(),
          verification: GitHub.Verification.t() | nil
        }

  defstruct [:message, :node_id, :object, :sha, :tag, :tagger, :url, :verification]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      message: :string,
      node_id: :string,
      object: :map,
      sha: :string,
      tag: :string,
      tagger: :map,
      url: :string,
      verification: {GitHub.Verification, :t}
    ]
  end
end
