defmodule GitHub.CodeSearchResultItem do
  @moduledoc """
  Provides struct and type for CodeSearchResultItem
  """

  @type t :: %__MODULE__{
          __info__: map,
          file_size: integer | nil,
          git_url: String.t(),
          html_url: String.t(),
          language: String.t() | nil,
          last_modified_at: String.t() | nil,
          line_numbers: [String.t()] | nil,
          name: String.t(),
          path: String.t(),
          repository: GitHub.Repository.minimal(),
          score: number,
          sha: String.t(),
          text_matches: [map] | nil,
          url: String.t()
        }

  defstruct [
    :__info__,
    :file_size,
    :git_url,
    :html_url,
    :language,
    :last_modified_at,
    :line_numbers,
    :name,
    :path,
    :repository,
    :score,
    :sha,
    :text_matches,
    :url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      file_size: :integer,
      git_url: :string,
      html_url: :string,
      language: {:nullable, :string},
      last_modified_at: :string,
      line_numbers: {:array, :string},
      name: :string,
      path: :string,
      repository: {GitHub.Repository, :minimal},
      score: :number,
      sha: :string,
      text_matches: {:array, :map},
      url: :string
    ]
  end
end
