defmodule GitHub.Hook.Delivery do
  @moduledoc """
  Provides struct and type for HookDelivery
  """

  @type t :: %__MODULE__{
          __info__: map,
          action: String.t() | nil,
          delivered_at: String.t(),
          duration: number,
          event: String.t(),
          guid: String.t(),
          id: integer,
          installation_id: integer | nil,
          redelivery: boolean,
          repository_id: integer | nil,
          request: map,
          response: map,
          status: String.t(),
          status_code: integer,
          url: String.t() | nil
        }

  defstruct [
    :__info__,
    :action,
    :delivered_at,
    :duration,
    :event,
    :guid,
    :id,
    :installation_id,
    :redelivery,
    :repository_id,
    :request,
    :response,
    :status,
    :status_code,
    :url
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
      request: :map,
      response: :map,
      status: :string,
      status_code: :integer,
      url: :string
    ]
  end
end
