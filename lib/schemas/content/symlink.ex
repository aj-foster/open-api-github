defmodule GitHub.Content.Symlink do
  @moduledoc """
  Provides struct and type for ContentSymlink
  """

  @type t :: %__MODULE__{
          _links: map,
          download_url: String.t() | nil,
          git_url: String.t() | nil,
          html_url: String.t() | nil,
          name: String.t(),
          path: String.t(),
          sha: String.t(),
          size: integer,
          target: String.t(),
          type: String.t(),
          url: String.t()
        }

  defstruct [
    :_links,
    :download_url,
    :git_url,
    :html_url,
    :name,
    :path,
    :sha,
    :size,
    :target,
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
      git_url: {:nullable, :string},
      html_url: {:nullable, :string},
      name: :string,
      path: :string,
      sha: :string,
      size: :integer,
      target: :string,
      type: :string,
      url: :string
    ]
  end
end
