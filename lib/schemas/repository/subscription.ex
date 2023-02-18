defmodule GitHub.Repository.Subscription do
  @moduledoc """
  Provides struct and type for RepositorySubscription
  """

  @type t :: %__MODULE__{
          created_at: String.t(),
          ignored: boolean,
          reason: String.t() | nil,
          repository_url: String.t(),
          subscribed: boolean,
          url: String.t()
        }

  defstruct [:created_at, :ignored, :reason, :repository_url, :subscribed, :url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      created_at: :string,
      ignored: :boolean,
      reason: {:nullable, :string},
      repository_url: :string,
      subscribed: :boolean,
      url: :string
    ]
  end
end
