defmodule GitHub.Organization do
  @moduledoc """
  Provides struct and type for OrganizationSimple
  """

  @type simple :: %__MODULE__{
          avatar_url: String.t(),
          description: String.t() | nil,
          events_url: String.t(),
          hooks_url: String.t(),
          id: integer,
          issues_url: String.t(),
          login: String.t(),
          members_url: String.t(),
          node_id: String.t(),
          public_members_url: String.t(),
          repos_url: String.t(),
          url: String.t()
        }

  defstruct [
    :avatar_url,
    :description,
    :events_url,
    :hooks_url,
    :id,
    :issues_url,
    :login,
    :members_url,
    :node_id,
    :public_members_url,
    :repos_url,
    :url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(:simple) do
    [
      avatar_url: :string,
      description: :string,
      events_url: :string,
      hooks_url: :string,
      id: :integer,
      issues_url: :string,
      login: :string,
      members_url: :string,
      node_id: :string,
      public_members_url: :string,
      repos_url: :string,
      url: :string
    ]
  end
end
