defmodule GitHub.BaseGist do
  @moduledoc """
  Provides struct and type for BaseGist
  """

  @type t :: %__MODULE__{
          comments: integer,
          comments_url: String.t(),
          commits_url: String.t(),
          created_at: String.t(),
          description: String.t() | nil,
          files: map,
          forks: [term] | nil,
          forks_url: String.t(),
          git_pull_url: String.t(),
          git_push_url: String.t(),
          history: [term] | nil,
          html_url: String.t(),
          id: String.t(),
          node_id: String.t(),
          owner: GitHub.User.simple() | nil,
          public: boolean,
          truncated: boolean | nil,
          updated_at: String.t(),
          url: String.t(),
          user: GitHub.User.simple() | nil
        }

  defstruct [
    :comments,
    :comments_url,
    :commits_url,
    :created_at,
    :description,
    :files,
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
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      comments: :integer,
      comments_url: :string,
      commits_url: :string,
      created_at: :string,
      description: :string,
      files: :map,
      forks: {:array, :unknown},
      forks_url: :string,
      git_pull_url: :string,
      git_push_url: :string,
      history: {:array, :unknown},
      html_url: :string,
      id: :string,
      node_id: :string,
      owner: {GitHub.User, :simple},
      public: :boolean,
      truncated: :boolean,
      updated_at: :string,
      url: :string,
      user: {GitHub.User, :simple}
    ]
  end
end
