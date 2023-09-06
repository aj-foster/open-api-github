defmodule GitHub.Migration do
  @moduledoc """
  Provides struct and type for Migration
  """
  use GitHub.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          archive_url: String.t() | nil,
          created_at: String.t(),
          exclude: [String.t()] | nil,
          exclude_attachments: boolean,
          exclude_git_data: boolean,
          exclude_metadata: boolean,
          exclude_owner_projects: boolean,
          exclude_releases: boolean,
          guid: String.t(),
          id: integer,
          lock_repositories: boolean,
          node_id: String.t(),
          org_metadata_only: boolean,
          owner: GitHub.User.simple() | nil,
          repositories: [GitHub.Repository.t()],
          state: String.t(),
          updated_at: String.t(),
          url: String.t()
        }

  defstruct [
    :__info__,
    :archive_url,
    :created_at,
    :exclude,
    :exclude_attachments,
    :exclude_git_data,
    :exclude_metadata,
    :exclude_owner_projects,
    :exclude_releases,
    :guid,
    :id,
    :lock_repositories,
    :node_id,
    :org_metadata_only,
    :owner,
    :repositories,
    :state,
    :updated_at,
    :url
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      archive_url: :string,
      created_at: :string,
      exclude: {:array, :string},
      exclude_attachments: :boolean,
      exclude_git_data: :boolean,
      exclude_metadata: :boolean,
      exclude_owner_projects: :boolean,
      exclude_releases: :boolean,
      guid: :string,
      id: :integer,
      lock_repositories: :boolean,
      node_id: :string,
      org_metadata_only: :boolean,
      owner: {:nullable, {GitHub.User, :simple}},
      repositories: {:array, {GitHub.Repository, :t}},
      state: :string,
      updated_at: :string,
      url: :string
    ]
  end
end
