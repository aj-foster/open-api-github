defmodule GitHub.Event do
  @moduledoc """
  Provides struct and type for Event
  """

  @type t :: %__MODULE__{
          actor: GitHub.Actor.t(),
          created_at: String.t() | nil,
          id: String.t(),
          org: GitHub.Actor.t() | nil,
          payload: map,
          public: boolean,
          repo: map,
          type: String.t() | nil
        }

  defstruct [:actor, :created_at, :id, :org, :payload, :public, :repo, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      actor: {GitHub.Actor, :t},
      created_at: {:nullable, :string},
      id: :string,
      org: {GitHub.Actor, :t},
      payload: :map,
      public: :boolean,
      repo: :map,
      type: {:nullable, :string}
    ]
  end
end
