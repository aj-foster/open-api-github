defmodule GitHub.Content.Tree do
  @moduledoc """
  Provides struct and type for ContentTree
  """

  @type t :: %__MODULE__{
          __info__: map,
          _links: map,
          download_url: String.t() | nil,
          entries: [map] | nil,
          git_url: String.t() | nil,
          html_url: String.t() | nil,
          name: String.t(),
          path: String.t(),
          sha: String.t(),
          size: integer,
          type: String.t(),
          url: String.t()
        }

  defstruct [
    :__info__,
    :_links,
    :download_url,
    :entries,
    :git_url,
    :html_url,
    :name,
    :path,
    :sha,
    :size,
    :type,
    :url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      _links: :map,
      download_url: {:nullable, :string},
      entries: {:array, :map},
      git_url: {:nullable, :string},
      html_url: {:nullable, :string},
      name: :string,
      path: :string,
      sha: :string,
      size: :integer,
      type: :string,
      url: :string
    ]
  end
end
