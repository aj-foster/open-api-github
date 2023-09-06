defmodule GitHub.Codespace.PublicKey do
  @moduledoc """
  Provides struct and type for CodespacesPublicKey
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          created_at: String.t() | nil,
          id: integer | nil,
          key: String.t(),
          key_id: String.t(),
          title: String.t() | nil,
          url: String.t() | nil
        }

  defstruct [:__info__, :created_at, :id, :key, :key_id, :title, :url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      created_at: :string,
      id: :integer,
      key: :string,
      key_id: :string,
      title: :string,
      url: :string
    ]
  end
end
