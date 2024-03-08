defmodule GitHub.Hook.DeliveryRequest do
  @moduledoc """
  Provides struct and type for a Hook.DeliveryRequest
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          headers: GitHub.Hook.DeliveryRequestHeaders.t() | nil,
          payload: GitHub.Hook.DeliveryRequestPayload.t() | nil
        }

  defstruct [:__info__, :headers, :payload]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      headers: {:union, [{GitHub.Hook.DeliveryRequestHeaders, :t}, :null]},
      payload: {:union, [{GitHub.Hook.DeliveryRequestPayload, :t}, :null]}
    ]
  end
end
