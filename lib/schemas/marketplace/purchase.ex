defmodule GitHub.Marketplace.Purchase do
  @moduledoc """
  Provides struct and type for MarketplacePurchase
  """

  @type t :: %__MODULE__{
          email: String.t() | nil,
          id: integer,
          login: String.t(),
          marketplace_pending_change: map | nil,
          marketplace_purchase: map,
          organization_billing_email: String.t() | nil,
          type: String.t(),
          url: String.t()
        }

  defstruct [
    :email,
    :id,
    :login,
    :marketplace_pending_change,
    :marketplace_purchase,
    :organization_billing_email,
    :type,
    :url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      email: {:nullable, :string},
      id: :integer,
      login: :string,
      marketplace_pending_change: {:nullable, :map},
      marketplace_purchase: :map,
      organization_billing_email: :string,
      type: :string,
      url: :string
    ]
  end
end
