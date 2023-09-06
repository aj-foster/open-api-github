defmodule GitHub.Gist.Commit do
  @moduledoc """
  Provides struct and type for GistCommit
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          change_status: map,
          committed_at: String.t(),
          url: String.t(),
          user: GitHub.User.simple() | nil,
          version: String.t()
        }

  defstruct [:__info__, :change_status, :committed_at, :url, :user, :version]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      change_status: :map,
      committed_at: :string,
      url: :string,
      user: {:nullable, {GitHub.User, :simple}},
      version: :string
    ]
  end
end
