defmodule GitHub.Email do
  @moduledoc """
  Provides struct and type for Email
  """

  @type t :: %__MODULE__{
          email: String.t(),
          primary: boolean,
          verified: boolean,
          visibility: String.t() | nil
        }

  defstruct [:email, :primary, :verified, :visibility]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [email: :string, primary: :boolean, verified: :boolean, visibility: :string]
  end
end
