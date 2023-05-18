defmodule GitHub.DeployKey do
  @moduledoc """
  Provides struct and type for DeployKey
  """

  @type t :: %__MODULE__{
          __info__: map,
          added_by: String.t() | nil,
          created_at: String.t(),
          id: integer,
          key: String.t(),
          last_used: String.t() | nil,
          read_only: boolean,
          title: String.t(),
          url: String.t(),
          verified: boolean
        }

  defstruct [
    :__info__,
    :added_by,
    :created_at,
    :id,
    :key,
    :last_used,
    :read_only,
    :title,
    :url,
    :verified
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      added_by: {:nullable, :string},
      created_at: :string,
      id: :integer,
      key: :string,
      last_used: {:nullable, :string},
      read_only: :boolean,
      title: :string,
      url: :string,
      verified: :boolean
    ]
  end
end
