defmodule GitHub.Organization.ProgrammaticAccessGrant do
  @moduledoc """
  Provides struct and type for OrganizationProgrammaticAccessGrant
  """

  @type t :: %__MODULE__{
          __info__: map,
          access_granted_at: String.t(),
          id: integer,
          owner: GitHub.User.simple(),
          permissions: map,
          repositories_url: String.t(),
          repository_selection: String.t(),
          token_expired: boolean,
          token_expires_at: String.t() | nil,
          token_last_used_at: String.t() | nil
        }

  defstruct [
    :__info__,
    :access_granted_at,
    :id,
    :owner,
    :permissions,
    :repositories_url,
    :repository_selection,
    :token_expired,
    :token_expires_at,
    :token_last_used_at
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      access_granted_at: :string,
      id: :integer,
      owner: {GitHub.User, :simple},
      permissions: :map,
      repositories_url: :string,
      repository_selection: :string,
      token_expired: :boolean,
      token_expires_at: {:nullable, :string},
      token_last_used_at: {:nullable, :string}
    ]
  end
end
