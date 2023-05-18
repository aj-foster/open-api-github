defmodule GitHub.ContributorActivity do
  @moduledoc """
  Provides struct and type for ContributorActivity
  """

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
    [author: {:nullable, {GitHub.User, :simple}}, total: :integer, weeks: {:array, :map}]
  end
end
