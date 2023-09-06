defmodule GitHub.GpgKey do
  @moduledoc """
  Provides struct and type for GpgKey
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          can_certify: boolean,
          can_encrypt_comms: boolean,
          can_encrypt_storage: boolean,
          can_sign: boolean,
          created_at: String.t(),
          emails: [map],
          expires_at: String.t() | nil,
          id: integer,
          key_id: String.t(),
          name: String.t() | nil,
          primary_key_id: integer | nil,
          public_key: String.t(),
          raw_key: String.t() | nil,
          revoked: boolean,
          subkeys: [map]
        }

  defstruct [
    :__info__,
    :can_certify,
    :can_encrypt_comms,
    :can_encrypt_storage,
    :can_sign,
    :created_at,
    :emails,
    :expires_at,
    :id,
    :key_id,
    :name,
    :primary_key_id,
    :public_key,
    :raw_key,
    :revoked,
    :subkeys
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      can_certify: :boolean,
      can_encrypt_comms: :boolean,
      can_encrypt_storage: :boolean,
      can_sign: :boolean,
      created_at: :string,
      emails: {:array, :map},
      expires_at: {:nullable, :string},
      id: :integer,
      key_id: :string,
      name: {:nullable, :string},
      primary_key_id: {:nullable, :integer},
      public_key: :string,
      raw_key: {:nullable, :string},
      revoked: :boolean,
      subkeys: {:array, :map}
    ]
  end
end
