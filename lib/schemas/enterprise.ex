defmodule GitHub.Enterprise do
  @moduledoc """
  Provides struct and type for Enterprise
  """

  @type t :: %__MODULE__{
          __info__: map,
          avatar_url: String.t(),
          created_at: String.t() | nil,
          description: String.t() | nil,
          html_url: String.t(),
          id: integer,
          name: String.t(),
          node_id: String.t(),
          slug: String.t(),
          updated_at: String.t() | nil,
          website_url: String.t() | nil
        }

  defstruct [
    :__info__,
    :avatar_url,
    :created_at,
    :description,
    :html_url,
    :id,
    :name,
    :node_id,
    :slug,
    :updated_at,
    :website_url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      avatar_url: :string,
      created_at: {:nullable, :string},
      description: {:nullable, :string},
      html_url: :string,
      id: :integer,
      name: :string,
      node_id: :string,
      slug: :string,
      updated_at: {:nullable, :string},
      website_url: {:nullable, :string}
    ]
  end
end
