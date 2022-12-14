defmodule GitHub.Reaction do
  @moduledoc """
  Provides struct and type for Reaction
  """

  @type t :: %__MODULE__{
          content: String.t(),
          created_at: String.t(),
          id: integer,
          node_id: String.t(),
          user: GitHub.User.simple() | nil
        }

  defstruct [:content, :created_at, :id, :node_id, :user]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      content: :string,
      created_at: :string,
      id: :integer,
      node_id: :string,
      user: {GitHub.User, :simple}
    ]
  end
end
