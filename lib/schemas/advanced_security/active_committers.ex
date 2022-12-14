defmodule GitHub.AdvancedSecurity.ActiveCommitters do
  @moduledoc """
  Provides struct and type for AdvancedSecurityActiveCommitters
  """

  @type t :: %__MODULE__{
          repositories: [GitHub.AdvancedSecurity.ActiveCommittersRepository.t()],
          total_advanced_security_committers: integer | nil,
          total_count: integer | nil
        }

  defstruct [:repositories, :total_advanced_security_committers, :total_count]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      repositories: {:array, {GitHub.AdvancedSecurity.ActiveCommittersRepository, :t}},
      total_advanced_security_committers: :integer,
      total_count: :integer
    ]
  end
end
