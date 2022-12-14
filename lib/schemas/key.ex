defmodule GitHub.Key do
  @moduledoc """
  Provides struct and types for Key, KeySimple
  """

  @type simple :: %__MODULE__{id: integer, key: String.t()}

  @type t :: %__MODULE__{
          created_at: String.t(),
          id: integer,
          key: String.t(),
          read_only: boolean,
          title: String.t(),
          url: String.t(),
          verified: boolean
        }

  defstruct [:created_at, :id, :key, :read_only, :title, :url, :verified]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:simple) do
    [id: :integer, key: :string]
  end

  def __fields__(:t) do
    [
      created_at: :string,
      id: :integer,
      key: :string,
      read_only: :boolean,
      title: :string,
      url: :string,
      verified: :boolean
    ]
  end
end
