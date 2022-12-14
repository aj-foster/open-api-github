defmodule GitHub.User.MarketplacePurchase do
  @moduledoc """
  Provides struct and type for UserMarketplacePurchase
  """

  @type t :: %__MODULE__{
          account: GitHub.Marketplace.Account.t(),
          billing_cycle: String.t(),
          free_trial_ends_on: String.t() | nil,
          next_billing_date: String.t() | nil,
          on_free_trial: boolean,
          plan: GitHub.Marketplace.ListingPlan.t(),
          unit_count: integer | nil,
          updated_at: String.t() | nil
        }

  defstruct [
    :account,
    :billing_cycle,
    :free_trial_ends_on,
    :next_billing_date,
    :on_free_trial,
    :plan,
    :unit_count,
    :updated_at
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      account: {GitHub.Marketplace.Account, :t},
      billing_cycle: :string,
      free_trial_ends_on: :string,
      next_billing_date: :string,
      on_free_trial: :boolean,
      plan: {GitHub.Marketplace.ListingPlan, :t},
      unit_count: :integer,
      updated_at: :string
    ]
  end
end
