defmodule GitHub.License.Content do
  @moduledoc """
  Provides struct and type for LicenseContent
  """

  @type t :: %__MODULE__{
          _links: map,
          content: String.t(),
          download_url: String.t() | nil,
          encoding: String.t(),
          git_url: String.t() | nil,
          html_url: String.t() | nil,
          license: GitHub.License.simple() | nil,
          name: String.t(),
          path: String.t(),
          sha: String.t(),
          size: integer,
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
    :license,
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
      content: :string,
      download_url: :string,
      encoding: :string,
      git_url: :string,
      html_url: :string,
      license: {GitHub.License, :simple},
      name: :string,
      path: :string,
      sha: :string,
      size: :integer,
      type: :string,
      url: :string
    ]
  end
end
