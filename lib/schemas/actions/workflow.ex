defmodule GitHub.Actions.Workflow do
  @moduledoc """
  Provides struct and type for Workflow
  """

  @type t :: %__MODULE__{
          badge_url: String.t(),
          created_at: String.t(),
          deleted_at: String.t() | nil,
          html_url: String.t(),
          id: integer,
          name: String.t(),
          node_id: String.t(),
          path: String.t(),
          state: String.t(),
          updated_at: String.t(),
          url: String.t()
        }

  defstruct [
    :badge_url,
    :created_at,
    :deleted_at,
    :html_url,
    :id,
    :name,
    :node_id,
    :path,
    :state,
    :updated_at,
    :url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      badge_url: :string,
      created_at: :string,
      deleted_at: :string,
      html_url: :string,
      id: :integer,
      name: :string,
      node_id: :string,
      path: :string,
      state: :string,
      updated_at: :string,
      url: :string
    ]
  end
end
