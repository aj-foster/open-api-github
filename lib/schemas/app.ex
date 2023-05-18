defmodule GitHub.App do
  @moduledoc """
  Provides struct and type for Integration
  """

  @type t :: %__MODULE__{
          __info__: map,
          client_id: String.t() | nil,
          client_secret: String.t() | nil,
          created_at: String.t(),
          description: String.t() | nil,
          events: [String.t()],
          external_url: String.t(),
          html_url: String.t(),
          id: integer,
          installations_count: integer | nil,
          name: String.t(),
          node_id: String.t(),
          owner: GitHub.User.simple() | nil,
          pem: String.t() | nil,
          permissions: map,
          slug: String.t() | nil,
          updated_at: String.t(),
          webhook_secret: String.t() | nil
        }

  defstruct [
    :__info__,
    :client_id,
    :client_secret,
    :created_at,
    :description,
    :events,
    :external_url,
    :html_url,
    :id,
    :installations_count,
    :name,
    :node_id,
    :owner,
    :pem,
    :permissions,
    :slug,
    :updated_at,
    :webhook_secret
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      client_id: :string,
      client_secret: :string,
      created_at: :string,
      description: {:nullable, :string},
      events: {:array, :string},
      external_url: :string,
      html_url: :string,
      id: :integer,
      installations_count: :integer,
      name: :string,
      node_id: :string,
      owner: {:nullable, {GitHub.User, :simple}},
      pem: :string,
      permissions: :map,
      slug: :string,
      updated_at: :string,
      webhook_secret: {:nullable, :string}
    ]
  end
end
