defmodule GitHub.Content.File do
  @moduledoc """
  Provides struct and type for ContentFile
  """

  @type t :: %__MODULE__{
          _links: map,
          content: String.t(),
          download_url: String.t() | nil,
          encoding: String.t(),
          git_url: String.t() | nil,
          html_url: String.t() | nil,
          name: String.t(),
          path: String.t(),
          sha: String.t(),
          size: integer,
          submodule_git_url: String.t() | nil,
          target: String.t() | nil,
          type: String.t(),
          url: String.t()
        }

  defstruct [
    :_links,
    :content,
    :download_url,
    :encoding,
    :git_url,
    :html_url,
    :name,
    :path,
    :sha,
    :size,
    :submodule_git_url,
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
      content: :string,
      download_url: {:nullable, :string},
      encoding: :string,
      git_url: {:nullable, :string},
      html_url: {:nullable, :string},
      name: :string,
      path: :string,
      sha: :string,
      size: :integer,
      submodule_git_url: :string,
      target: :string,
      type: :string,
      url: :string
    ]
  end
end
