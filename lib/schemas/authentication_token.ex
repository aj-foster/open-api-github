defmodule GitHub.AuthenticationToken do
  @moduledoc """
  Provides struct and type for AuthenticationToken
  """

  @type t :: %__MODULE__{
          expires_at: String.t(),
          permissions: map | nil,
          repositories: [GitHub.Repository.t()] | nil,
          repository_selection: String.t() | nil,
          single_file: String.t() | nil,
          token: String.t()
        }

  defstruct [
    :expires_at,
    :permissions,
    :repositories,
    :repository_selection,
    :single_file,
    :token
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      expires_at: :string,
      permissions: :map,
      repositories: {:array, {GitHub.Repository, :t}},
      repository_selection: :string,
      single_file: {:nullable, :string},
      token: :string
    ]
  end
end
