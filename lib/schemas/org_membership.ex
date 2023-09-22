defmodule GitHub.OrgMembership do
  @moduledoc """
  Provides struct and type for a OrgMembership
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          organization: GitHub.Organization.simple(),
          organization_url: String.t(),
          permissions: map | nil,
          role: String.t(),
          state: String.t(),
          url: String.t(),
          user: GitHub.User.simple() | nil
        }

  defstruct [
    :__info__,
    :organization,
    :organization_url,
    :permissions,
    :role,
    :state,
    :url,
    :user
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      organization: {GitHub.Organization, :simple},
      organization_url: {:string, :uri},
      permissions: :map,
      role: {:enum, ["admin", "member", "billing_manager"]},
      state: {:enum, ["active", "pending"]},
      url: {:string, :uri},
      user: {:union, [{GitHub.User, :simple}, :null]}
    ]
  end
end
