defmodule GitHub.ThreadSubscription do
  @moduledoc """
  Provides struct and type for ThreadSubscription
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          created_at: String.t() | nil,
          ignored: boolean,
          reason: String.t() | nil,
          repository_url: String.t() | nil,
          subscribed: boolean,
          thread_url: String.t() | nil,
          url: String.t()
        }

  defstruct [
    :__info__,
    :created_at,
    :ignored,
    :reason,
    :repository_url,
    :subscribed,
    :thread_url,
    :url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      created_at: {:nullable, :string},
      ignored: :boolean,
      reason: {:nullable, :string},
      repository_url: :string,
      subscribed: :boolean,
      thread_url: :string,
      url: :string
    ]
  end
end
