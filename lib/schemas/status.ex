defmodule GitHub.Status do
  @moduledoc """
  Provides struct and type for Status
  """

  @type t :: %__MODULE__{
          avatar_url: String.t() | nil,
          context: String.t(),
          created_at: String.t(),
          creator: GitHub.User.simple() | nil,
          description: String.t() | nil,
          id: integer,
          node_id: String.t(),
          state: String.t(),
          target_url: String.t() | nil,
          updated_at: String.t(),
          url: String.t()
        }

  defstruct [
    :avatar_url,
    :context,
    :created_at,
    :creator,
    :description,
    :id,
    :node_id,
    :state,
    :target_url,
    :updated_at,
    :url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      avatar_url: :string,
      context: :string,
      created_at: :string,
      creator: {GitHub.User, :simple},
      description: :string,
      id: :integer,
      node_id: :string,
      state: :string,
      target_url: :string,
      updated_at: :string,
      url: :string
    ]
  end
end
