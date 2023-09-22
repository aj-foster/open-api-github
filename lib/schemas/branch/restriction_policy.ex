defmodule GitHub.Branch.RestrictionPolicy do
  @moduledoc """
  Provides struct and type for a Branch.RestrictionPolicy
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          apps: [map],
          apps_url: String.t(),
          teams: [map],
          teams_url: String.t(),
          url: String.t(),
          users: [map],
          users_url: String.t()
        }

  defstruct [:__info__, :apps, :apps_url, :teams, :teams_url, :url, :users, :users_url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      apps: [:map],
      apps_url: {:string, :uri},
      teams: [:map],
      teams_url: {:string, :uri},
      url: {:string, :uri},
      users: [:map],
      users_url: {:string, :uri}
    ]
  end
end
