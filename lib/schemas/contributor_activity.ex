defmodule GitHub.ContributorActivity do
  @moduledoc """
  Provides struct and type for a ContributorActivity
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          author: GitHub.User.simple() | nil,
          total: integer,
          weeks: [map]
        }

  defstruct [:__info__, :author, :total, :weeks]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [author: {:union, [{GitHub.User, :simple}, :null]}, total: :integer, weeks: [:map]]
  end
end
