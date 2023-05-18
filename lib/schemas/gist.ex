defmodule GitHub.Gist do
  @moduledoc """
  Provides struct and type for GistSimple
  """

  @type simple :: %__MODULE__{
          __info__: map,
          comments: integer | nil,
          comments_url: String.t() | nil,
          commits_url: String.t() | nil,
          created_at: String.t() | nil,
          description: String.t() | nil,
          files: map | nil,
          fork_of: map | nil,
          forks: [map] | nil,
          forks_url: String.t() | nil,
          git_pull_url: String.t() | nil,
          git_push_url: String.t() | nil,
          history: [GitHub.Gist.History.t()] | nil,
          html_url: String.t() | nil,
          id: String.t() | nil,
          node_id: String.t() | nil,
          owner: GitHub.User.simple() | nil,
          public: boolean | nil,
          truncated: boolean | nil,
          updated_at: String.t() | nil,
          url: String.t() | nil,
          user: String.t() | nil
        }

  defstruct [
    :__info__,
    :comments,
    :comments_url,
    :commits_url,
    :created_at,
    :description,
    :files,
    :fork_of,
    :forks,
    :forks_url,
    :git_pull_url,
    :git_push_url,
    :history,
    :html_url,
    :id,
    :node_id,
    :owner,
    :public,
    :truncated,
    :updated_at,
    :url,
    :user
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(:simple) do
    [
      comments: :integer,
      comments_url: :string,
      commits_url: :string,
      created_at: :string,
      description: {:nullable, :string},
      files: :map,
      fork_of: {:nullable, :map},
      forks: {:nullable, {:array, :map}},
      forks_url: :string,
      git_pull_url: :string,
      git_push_url: :string,
      history: {:nullable, {:array, {GitHub.Gist.History, :t}}},
      html_url: :string,
      id: :string,
      node_id: :string,
      owner: {GitHub.User, :simple},
      public: :boolean,
      truncated: :boolean,
      updated_at: :string,
      url: :string,
      user: {:nullable, :string}
    ]
  end
end
