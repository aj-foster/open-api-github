defmodule GitHub.Thread do
  @moduledoc """
  Provides struct and type for Thread
  """

  @type t :: %__MODULE__{
          id: String.t(),
          last_read_at: String.t() | nil,
          reason: String.t(),
          repository: GitHub.MinimalRepository.t(),
          subject: map,
          subscription_url: String.t(),
          unread: boolean,
          updated_at: String.t(),
          url: String.t()
        }

  defstruct [
    :id,
    :last_read_at,
    :reason,
    :repository,
    :subject,
    :subscription_url,
    :unread,
    :updated_at,
    :url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      id: :string,
      last_read_at: {:nullable, :string},
      reason: :string,
      repository: {GitHub.MinimalRepository, :t},
      subject: :map,
      subscription_url: :string,
      unread: :boolean,
      updated_at: :string,
      url: :string
    ]
  end
end
