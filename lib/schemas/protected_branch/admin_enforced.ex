defmodule GitHub.ProtectedBranch.AdminEnforced do
  @moduledoc """
  Provides struct and type for ProtectedBranchAdminEnforced
  """

  @type t :: %__MODULE__{enabled: boolean, url: String.t()}

  defstruct [:enabled, :url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [enabled: :boolean, url: :string]
  end
end
