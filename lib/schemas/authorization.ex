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
          installation: GitHub.ScopedInstallation.nullable() | nil,
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
      expires_at: :string,
      fingerprint: :string,
      hashed_token: :string,
      id: :integer,
      installation: {GitHub.ScopedInstallation, :nullable},
      note: :string,
      note_url: :string,
      scopes: {:array, :string},
      token: :string,
      token_last_eight: :string,
      updated_at: :string,
      url: :string,
      user: {GitHub.User, :simple}
    ]
  end
end
