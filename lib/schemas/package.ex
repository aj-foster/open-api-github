defmodule GitHub.Package do
  @moduledoc """
  Provides struct and type for Package
  """

  @type t :: %__MODULE__{
          created_at: String.t(),
          html_url: String.t(),
          id: integer,
          name: String.t(),
          owner: GitHub.User.simple() | nil,
          package_type: String.t(),
          repository: GitHub.Repository.minimal() | nil,
          updated_at: String.t(),
          url: String.t(),
          version_count: integer,
          visibility: String.t()
        }

  defstruct [
    :created_at,
    :html_url,
    :id,
    :name,
    :owner,
    :package_type,
    :repository,
    :updated_at,
    :url,
    :version_count,
    :visibility
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      created_at: :string,
      html_url: :string,
      id: :integer,
      name: :string,
      owner: {:nullable, {GitHub.User, :simple}},
      package_type: :string,
      repository: {:nullable, {GitHub.Repository, :minimal}},
      updated_at: :string,
      url: :string,
      version_count: :integer,
      visibility: :string
    ]
  end
end
