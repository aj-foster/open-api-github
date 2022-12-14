defmodule GitHub.Gist.Commit do
  @moduledoc """
  Provides struct and type for GistCommit
  """

  @type t :: %__MODULE__{
          change_status: map,
          committed_at: String.t(),
          url: String.t(),
          user: GitHub.User.simple() | nil,
          version: String.t()
        }

  defstruct [:change_status, :committed_at, :url, :user, :version]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      change_status: :map,
      committed_at: :string,
      url: :string,
      user: {GitHub.User, :simple},
      version: :string
    ]
  end
end
