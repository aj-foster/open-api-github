defmodule GitHub.Git.User do
  @moduledoc """
  Provides struct and type for NullableGitUser
  """

  @type nullable :: %__MODULE__{
          date: String.t() | nil,
          email: String.t() | nil,
          name: String.t() | nil
        }

  defstruct [:date, :email, :name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(:nullable) do
    [date: :string, email: :string, name: :string]
  end
end
