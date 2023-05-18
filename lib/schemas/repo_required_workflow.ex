defmodule GitHub.RepoRequiredWorkflow do
  @moduledoc """
  Provides struct and type for RepoRequiredWorkflow
  """

  @type t :: %__MODULE__{
          __info__: map,
          badge_url: String.t(),
          created_at: String.t(),
          html_url: String.t(),
          id: integer,
          name: String.t(),
          node_id: String.t(),
          path: String.t(),
          source_repository: GitHub.Repository.minimal(),
          state: String.t(),
          updated_at: String.t(),
          url: String.t()
        }

  defstruct [
    :__info__,
    :badge_url,
    :created_at,
    :html_url,
    :id,
    :name,
    :node_id,
    :path,
    :source_repository,
    :state,
    :updated_at,
    :url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      badge_url: :string,
      created_at: :string,
      html_url: :string,
      id: :integer,
      name: :string,
      node_id: :string,
      path: :string,
      source_repository: {GitHub.Repository, :minimal},
      state: :string,
      updated_at: :string,
      url: :string
    ]
  end
end
