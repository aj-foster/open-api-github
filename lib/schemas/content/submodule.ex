defmodule GitHub.Content.Submodule do
  @moduledoc """
  Provides struct and type for ContentSubmodule
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
          submodule_git_url: String.t(),
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
    :submodule_git_url,
    :type,
    :url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      _links: :map,
      download_url: :string,
      git_url: :string,
      html_url: :string,
      name: :string,
      path: :string,
      sha: :string,
      size: :integer,
      submodule_git_url: :string,
      type: :string,
      url: :string
    ]
  end
end
