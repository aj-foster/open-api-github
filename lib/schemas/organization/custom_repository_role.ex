defmodule GitHub.Organization.CustomRepositoryRole do
  @moduledoc """
  Provides struct and type for OrganizationCustomRepositoryRole
  """

  @type t :: %__MODULE__{
          base_role: String.t() | nil,
          created_at: String.t() | nil,
          description: String.t() | nil,
          id: integer,
          name: String.t(),
          organization: GitHub.User.simple() | nil,
          permissions: [String.t()] | nil,
          updated_at: String.t() | nil
        }

  defstruct [
    :base_role,
    :created_at,
    :description,
    :id,
    :name,
    :organization,
    :permissions,
    :updated_at
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      base_role: :string,
      created_at: :string,
      description: {:nullable, :string},
      id: :integer,
      name: :string,
      organization: {GitHub.User, :simple},
      permissions: {:array, :string},
      updated_at: :string
    ]
  end
end
