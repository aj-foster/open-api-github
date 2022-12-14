defmodule GitHub.Milestone do
  @moduledoc """
  Provides struct and types for Milestone, NullableMilestone
  """

  @type t :: %__MODULE__{
          closed_at: String.t() | nil,
          closed_issues: integer,
          created_at: String.t(),
          creator: GitHub.User.simple() | nil,
          description: String.t() | nil,
          due_on: String.t() | nil,
          html_url: String.t(),
          id: integer,
          labels_url: String.t(),
          node_id: String.t(),
          number: integer,
          open_issues: integer,
          state: String.t(),
          title: String.t(),
          updated_at: String.t(),
          url: String.t()
        }

  defstruct [
    :closed_at,
    :closed_issues,
    :created_at,
    :creator,
    :description,
    :due_on,
    :html_url,
    :id,
    :labels_url,
    :node_id,
    :number,
    :open_issues,
    :state,
    :title,
    :updated_at,
    :url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      closed_at: :string,
      closed_issues: :integer,
      created_at: :string,
      creator: {GitHub.User, :simple},
      description: :string,
      due_on: :string,
      html_url: :string,
      id: :integer,
      labels_url: :string,
      node_id: :string,
      number: :integer,
      open_issues: :integer,
      state: :string,
      title: :string,
      updated_at: :string,
      url: :string
    ]
  end
end
