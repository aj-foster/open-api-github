defmodule GitHub.Hook.DeliveryItem do
  @moduledoc """
  Provides struct and type for HookDeliveryItem
  """

  @type t :: %__MODULE__{
          action: String.t() | nil,
          delivered_at: String.t(),
          duration: number,
          event: String.t(),
          guid: String.t(),
          id: integer,
          installation_id: integer | nil,
          redelivery: boolean,
          repository_id: integer | nil,
          status: String.t(),
          status_code: integer
        }

  defstruct [
    :action,
    :delivered_at,
    :duration,
    :event,
    :guid,
    :id,
    :installation_id,
    :redelivery,
    :repository_id,
    :status,
    :status_code
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      action: {:nullable, :string},
      delivered_at: :string,
      duration: :number,
      event: :string,
      guid: :string,
      id: :integer,
      installation_id: {:nullable, :integer},
      redelivery: :boolean,
      repository_id: {:nullable, :integer},
      status: :string,
      status_code: :integer
    ]
  end
end
