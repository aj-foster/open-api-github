defmodule GitHub.Authorization do
  @moduledoc """
  Provides struct and type for Authorization
  """

  @type t :: %__MODULE__{
          app: map,
          created_at: String.t(),
          expires_at: String.t() | nil,
          fingerprint: String.t() | nil,
          hashed_token: String.t() | nil,
          id: integer,
          installation: GitHub.ScopedInstallation.t() | nil,
          note: String.t() | nil,
          note_url: String.t() | nil,
          scopes: [String.t()] | nil,
          token: String.t(),
          token_last_eight: String.t() | nil,
          updated_at: String.t(),
          url: String.t(),
          user: GitHub.User.simple() | nil
        }

  defstruct [
    :app,
    :created_at,
    :expires_at,
    :fingerprint,
    :hashed_token,
    :id,
    :installation,
    :note,
    :note_url,
    :scopes,
    :token,
    :token_last_eight,
    :updated_at,
    :url,
    :user
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      app: :map,
      created_at: :string,
      expires_at: {:nullable, :string},
      fingerprint: {:nullable, :string},
      hashed_token: {:nullable, :string},
      id: :integer,
      installation: {:nullable, {GitHub.ScopedInstallation, :t}},
      note: {:nullable, :string},
      note_url: {:nullable, :string},
      scopes: {:nullable, {:array, :string}},
      token: :string,
      token_last_eight: {:nullable, :string},
      updated_at: :string,
      url: :string,
      user: {:nullable, {GitHub.User, :simple}}
    ]
  end
end
