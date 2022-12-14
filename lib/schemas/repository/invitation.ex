defmodule GitHub.Repository.Invitation do
  @moduledoc """
  Provides struct and type for RepositoryInvitation
  """

  @type t :: %__MODULE__{
          created_at: String.t(),
          expired: boolean | nil,
          html_url: String.t(),
          id: integer,
          invitee: GitHub.User.simple() | nil,
          inviter: GitHub.User.simple() | nil,
          node_id: String.t(),
          permissions: String.t(),
          repository: GitHub.MinimalRepository.t(),
          url: String.t()
        }

  defstruct [
    :created_at,
    :expired,
    :html_url,
    :id,
    :invitee,
    :inviter,
    :node_id,
    :permissions,
    :repository,
    :url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      created_at: :string,
      expired: :boolean,
      html_url: :string,
      id: :integer,
      invitee: {GitHub.User, :simple},
      inviter: {GitHub.User, :simple},
      node_id: :string,
      permissions: :string,
      repository: {GitHub.MinimalRepository, :t},
      url: :string
    ]
  end
end
