defmodule GitHub.Commit.Status do
  @moduledoc """
  Provides struct and type for SimpleCommitStatus
  """

  @type simple :: %__MODULE__{
          avatar_url: String.t() | nil,
          context: String.t(),
          created_at: String.t(),
          description: String.t() | nil,
          id: integer,
          node_id: String.t(),
          required: boolean | nil,
          state: String.t(),
          target_url: String.t() | nil,
          updated_at: String.t(),
          url: String.t()
        }

  defstruct [
    :avatar_url,
    :context,
    :created_at,
    :description,
    :id,
    :node_id,
    :required,
    :state,
    :target_url,
    :updated_at,
    :url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(:simple) do
    [
      avatar_url: {:nullable, :string},
      context: :string,
      created_at: :string,
      description: {:nullable, :string},
      id: :integer,
      node_id: :string,
      required: {:nullable, :boolean},
      state: :string,
      target_url: {:nullable, :string},
      updated_at: :string,
      url: :string
    ]
  end
end
