defmodule GitHub.Pages.Build do
  @moduledoc """
  Provides struct and type for PageBuild
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          commit: String.t(),
          created_at: String.t(),
          duration: integer,
          error: map,
          pusher: GitHub.User.simple() | nil,
          status: String.t(),
          updated_at: String.t(),
          url: String.t()
        }

  defstruct [
    :__info__,
    :commit,
    :created_at,
    :duration,
    :error,
    :pusher,
    :status,
    :updated_at,
    :url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      commit: :string,
      created_at: :string,
      duration: :integer,
      error: :map,
      pusher: {:nullable, {GitHub.User, :simple}},
      status: :string,
      updated_at: :string,
      url: :string
    ]
  end
end
