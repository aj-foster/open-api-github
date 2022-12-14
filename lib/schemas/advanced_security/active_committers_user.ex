defmodule GitHub.AdvancedSecurity.ActiveCommittersUser do
  @moduledoc """
  Provides struct and type for AdvancedSecurityActiveCommittersUser
  """

  @type t :: %__MODULE__{last_pushed_date: String.t(), user_login: String.t()}

  defstruct [:last_pushed_date, :user_login]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [last_pushed_date: :string, user_login: :string]
  end
end
