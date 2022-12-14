defmodule GitHub.Branch.RestrictionPolicy do
  @moduledoc """
  Provides struct and type for BranchRestrictionPolicy
  """

  @type t :: %__MODULE__{
          apps: [map],
          apps_url: String.t(),
          teams: [map],
          teams_url: String.t(),
          url: String.t(),
          users: [map],
          users_url: String.t()
        }

  defstruct [:apps, :apps_url, :teams, :teams_url, :url, :users, :users_url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      apps: {:array, :map},
      apps_url: :string,
      teams: {:array, :map},
      teams_url: :string,
      url: :string,
      users: {:array, :map},
      users_url: :string
    ]
  end
end
