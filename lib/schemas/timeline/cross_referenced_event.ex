defmodule GitHub.Timeline.CrossReferencedEvent do
  @moduledoc """
  Provides struct and type for TimelineCrossReferencedEvent
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          actor: GitHub.User.simple() | nil,
          created_at: String.t(),
          event: String.t(),
          source: map,
          updated_at: String.t()
        }

  defstruct [:__info__, :actor, :created_at, :event, :source, :updated_at]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      actor: {GitHub.User, :simple},
      created_at: :string,
      event: :string,
      source: :map,
      updated_at: :string
    ]
  end
end
