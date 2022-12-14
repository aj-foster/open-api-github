defmodule GitHub.AdvancedSecurity.ActiveCommittersRepository do
  @moduledoc """
  Provides struct and type for AdvancedSecurityActiveCommittersRepository
  """

  @type t :: %__MODULE__{
          advanced_security_committers: integer,
          advanced_security_committers_breakdown: [
            GitHub.AdvancedSecurity.ActiveCommittersUser.t()
          ],
          name: String.t()
        }

  defstruct [:advanced_security_committers, :advanced_security_committers_breakdown, :name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      advanced_security_committers: :integer,
      advanced_security_committers_breakdown:
        {:array, {GitHub.AdvancedSecurity.ActiveCommittersUser, :t}},
      name: :string
    ]
  end
end
