defmodule GitHub.Marketplace.Account do
  @moduledoc """
  Provides struct and type for MarketplaceAccount
  """

  @type t :: %__MODULE__{
          email: String.t() | nil,
          id: integer,
          login: String.t(),
          node_id: String.t() | nil,
          organization_billing_email: String.t() | nil,
          type: String.t(),
          url: String.t()
        }

  defstruct [:email, :id, :login, :node_id, :organization_billing_email, :type, :url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      email: {:nullable, :string},
      id: :integer,
      login: :string,
      node_id: :string,
      organization_billing_email: {:nullable, :string},
      type: :string,
      url: :string
    ]
  end
end
