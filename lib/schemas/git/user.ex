defmodule GitHub.Git.User do
  @moduledoc """
  Provides struct and type for GitUser
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          date: String.t() | nil,
          email: String.t() | nil,
          name: String.t() | nil
        }

  defstruct [:__info__, :date, :email, :name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [date: :string, email: :string, name: :string]
  end
end
