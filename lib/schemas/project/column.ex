defmodule GitHub.Project.Column do
  @moduledoc """
  Provides struct and type for ProjectColumn
  """

  @type t :: %__MODULE__{
          __info__: map,
          cards_url: String.t(),
          created_at: String.t(),
          id: integer,
          name: String.t(),
          node_id: String.t(),
          project_url: String.t(),
          updated_at: String.t(),
          url: String.t()
        }

  defstruct [
    :__info__,
    :cards_url,
    :created_at,
    :id,
    :name,
    :node_id,
    :project_url,
    :updated_at,
    :url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      cards_url: :string,
      created_at: :string,
      id: :integer,
      name: :string,
      node_id: :string,
      project_url: :string,
      updated_at: :string,
      url: :string
    ]
  end
end
