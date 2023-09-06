defmodule GitHub.Project.Card do
  @moduledoc """
  Provides struct and type for ProjectCard
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          archived: boolean | nil,
          column_name: String.t() | nil,
          column_url: String.t(),
          content_url: String.t() | nil,
          created_at: String.t(),
          creator: GitHub.User.simple() | nil,
          id: integer,
          node_id: String.t(),
          note: String.t() | nil,
          project_id: String.t() | nil,
          project_url: String.t(),
          updated_at: String.t(),
          url: String.t()
        }

  defstruct [
    :__info__,
    :archived,
    :column_name,
    :column_url,
    :content_url,
    :created_at,
    :creator,
    :id,
    :node_id,
    :note,
    :project_id,
    :project_url,
    :updated_at,
    :url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      archived: :boolean,
      column_name: :string,
      column_url: :string,
      content_url: :string,
      created_at: :string,
      creator: {:nullable, {GitHub.User, :simple}},
      id: :integer,
      node_id: :string,
      note: {:nullable, :string},
      project_id: :string,
      project_url: :string,
      updated_at: :string,
      url: :string
    ]
  end
end
