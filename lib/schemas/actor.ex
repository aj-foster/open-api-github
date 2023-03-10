defmodule GitHub.Actor do
  @moduledoc """
  Provides struct and type for Actor
  """

  @type t :: %__MODULE__{
          avatar_url: String.t(),
          display_login: String.t() | nil,
          gravatar_id: String.t() | nil,
          id: integer,
          login: String.t(),
          url: String.t()
        }

  defstruct [:avatar_url, :display_login, :gravatar_id, :id, :login, :url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      avatar_url: :string,
      display_login: :string,
      gravatar_id: {:nullable, :string},
      id: :integer,
      login: :string,
      url: :string
    ]
  end
end
