defmodule GitHub.Gist.Comment do
  @moduledoc """
  Provides struct and type for GistComment
  """

  @type t :: %__MODULE__{
          author_association: String.t(),
          body: String.t(),
          created_at: String.t(),
          id: integer,
          node_id: String.t(),
          updated_at: String.t(),
          url: String.t(),
          user: GitHub.User.simple() | nil
        }

  defstruct [:author_association, :body, :created_at, :id, :node_id, :updated_at, :url, :user]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      author_association: :string,
      body: :string,
      created_at: :string,
      id: :integer,
      node_id: :string,
      updated_at: :string,
      url: :string,
      user: {:nullable, {GitHub.User, :simple}}
    ]
  end
end
