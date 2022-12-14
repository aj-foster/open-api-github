defmodule GitHub.Repository.CollaboratorPermission do
  @moduledoc """
  Provides struct and type for RepositoryCollaboratorPermission
  """

  @type t :: %__MODULE__{
          permission: String.t(),
          role_name: String.t(),
          user: GitHub.Collaborator.t() | nil
        }

  defstruct [:permission, :role_name, :user]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [permission: :string, role_name: :string, user: {GitHub.Collaborator, :t}]
  end
end
