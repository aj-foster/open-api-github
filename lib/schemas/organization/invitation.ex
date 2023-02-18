defmodule GitHub.Organization.Invitation do
  @moduledoc """
  Provides struct and type for OrganizationInvitation
  """

  @type t :: %__MODULE__{
          created_at: String.t(),
          email: String.t() | nil,
          failed_at: String.t() | nil,
          failed_reason: String.t() | nil,
          id: integer,
          invitation_teams_url: String.t(),
          inviter: GitHub.User.simple(),
          login: String.t() | nil,
          node_id: String.t(),
          role: String.t(),
          team_count: integer
        }

  defstruct [
    :created_at,
    :email,
    :failed_at,
    :failed_reason,
    :id,
    :invitation_teams_url,
    :inviter,
    :login,
    :node_id,
    :role,
    :team_count
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      created_at: :string,
      email: {:nullable, :string},
      failed_at: {:nullable, :string},
      failed_reason: {:nullable, :string},
      id: :integer,
      invitation_teams_url: :string,
      inviter: {GitHub.User, :simple},
      login: {:nullable, :string},
      node_id: :string,
      role: :string,
      team_count: :integer
    ]
  end
end
