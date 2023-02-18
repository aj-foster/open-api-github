defmodule GitHub.Project.CollaboratorPermission do
  @moduledoc """
  Provides struct and type for ProjectCollaboratorPermission
  """

  @type t :: %__MODULE__{permission: String.t(), user: GitHub.User.simple() | nil}

  defstruct [:permission, :user]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [permission: :string, user: {:nullable, {GitHub.User, :simple}}]
  end
end
