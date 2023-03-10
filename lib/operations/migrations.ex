defmodule GitHub.Migrations do
  @moduledoc """
  Provides API endpoints related to migrations
  """

  @default_client GitHub.Client

  @doc """
  Cancel an import

  ## Resources

    * [API method documentation](https://docs.github.com/rest/migrations/source-imports#cancel-an-import)

  """
  @spec cancel_import(String.t(), String.t(), keyword) :: :ok | {:error, GitHub.Error.t()}
  def cancel_import(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      url: "/repos/#{owner}/#{repo}/import",
      method: :delete,
      response: [{204, nil}, {503, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Delete a user migration archive

  ## Resources

    * [API method documentation](https://docs.github.com/rest/migrations/users#delete-a-user-migration-archive)

  """
  @spec delete_archive_for_authenticated_user(integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def delete_archive_for_authenticated_user(migration_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [migration_id: migration_id],
      url: "/user/migrations/#{migration_id}/archive",
      method: :delete,
      response: [
        {204, nil},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Delete an organization migration archive

  ## Resources

    * [API method documentation](https://docs.github.com/rest/migrations/orgs#delete-an-organization-migration-archive)

  """
  @spec delete_archive_for_org(String.t(), integer, keyword) :: :ok | {:error, GitHub.Error.t()}
  def delete_archive_for_org(org, migration_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, migration_id: migration_id],
      url: "/orgs/#{org}/migrations/#{migration_id}/archive",
      method: :delete,
      response: [{204, nil}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Download an organization migration archive

  ## Resources

    * [API method documentation](https://docs.github.com/rest/migrations/orgs#download-an-organization-migration-archive)

  """
  @spec download_archive_for_org(String.t(), integer, keyword) :: :ok | {:error, GitHub.Error.t()}
  def download_archive_for_org(org, migration_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, migration_id: migration_id],
      url: "/orgs/#{org}/migrations/#{migration_id}/archive",
      method: :get,
      response: [{302, nil}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Download a user migration archive

  ## Resources

    * [API method documentation](https://docs.github.com/rest/migrations/users#download-a-user-migration-archive)

  """
  @spec get_archive_for_authenticated_user(integer, keyword) :: :ok | {:error, GitHub.Error.t()}
  def get_archive_for_authenticated_user(migration_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [migration_id: migration_id],
      url: "/user/migrations/#{migration_id}/archive",
      method: :get,
      response: [
        {302, nil},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get commit authors

  ## Options

    * `since` (integer): A user ID. Only return users with an ID greater than this ID.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/migrations/source-imports#get-commit-authors)

  """
  @spec get_commit_authors(String.t(), String.t(), keyword) ::
          {:ok, [GitHub.PorterAuthor.t()]} | {:error, GitHub.Error.t()}
  def get_commit_authors(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:since])

    client.request(%{
      args: [owner: owner, repo: repo],
      url: "/repos/#{owner}/#{repo}/import/authors",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.PorterAuthor, :t}}},
        {404, {GitHub.BasicError, :t}},
        {503, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get an import status

  ## Resources

    * [API method documentation](https://docs.github.com/rest/migrations/source-imports#get-an-import-status)

  """
  @spec get_import_status(String.t(), String.t(), keyword) ::
          {:ok, GitHub.Import.t()} | {:error, GitHub.Error.t()}
  def get_import_status(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      url: "/repos/#{owner}/#{repo}/import",
      method: :get,
      response: [
        {200, {GitHub.Import, :t}},
        {404, {GitHub.BasicError, :t}},
        {503, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get large files

  ## Resources

    * [API method documentation](https://docs.github.com/rest/migrations/source-imports#get-large-files)

  """
  @spec get_large_files(String.t(), String.t(), keyword) ::
          {:ok, [GitHub.PorterLargeFile.t()]} | {:error, GitHub.Error.t()}
  def get_large_files(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      url: "/repos/#{owner}/#{repo}/import/large_files",
      method: :get,
      response: [{200, {:array, {GitHub.PorterLargeFile, :t}}}, {503, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a user migration status

  ## Options

    * `exclude` ([String.t()]): 

  ## Resources

    * [API method documentation](https://docs.github.com/rest/migrations/users#get-a-user-migration-status)

  """
  @spec get_status_for_authenticated_user(integer, keyword) ::
          {:ok, GitHub.Migration.t()} | {:error, GitHub.Error.t()}
  def get_status_for_authenticated_user(migration_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:exclude])

    client.request(%{
      args: [migration_id: migration_id],
      url: "/user/migrations/#{migration_id}",
      method: :get,
      query: query,
      response: [
        {200, {GitHub.Migration, :t}},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get an organization migration status

  ## Options

    * `exclude` ([String.t()]): Exclude attributes from the API response to improve performance

  ## Resources

    * [API method documentation](https://docs.github.com/rest/migrations/orgs#get-an-organization-migration-status)

  """
  @spec get_status_for_org(String.t(), integer, keyword) ::
          {:ok, GitHub.Migration.t()} | {:error, GitHub.Error.t()}
  def get_status_for_org(org, migration_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:exclude])

    client.request(%{
      args: [org: org, migration_id: migration_id],
      url: "/orgs/#{org}/migrations/#{migration_id}",
      method: :get,
      query: query,
      response: [{200, {GitHub.Migration, :t}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  List user migrations

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/migrations/users#list-user-migrations)

  """
  @spec list_for_authenticated_user(keyword) ::
          {:ok, [GitHub.Migration.t()]} | {:error, GitHub.Error.t()}
  def list_for_authenticated_user(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      url: "/user/migrations",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.Migration, :t}}},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List organization migrations

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.
    * `exclude` ([String.t()]): Exclude attributes from the API response to improve performance

  ## Resources

    * [API method documentation](https://docs.github.com/rest/migrations/orgs#list-organization-migrations)

  """
  @spec list_for_org(String.t(), keyword) ::
          {:ok, [GitHub.Migration.t()]} | {:error, GitHub.Error.t()}
  def list_for_org(org, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:exclude, :page, :per_page])

    client.request(%{
      args: [org: org],
      url: "/orgs/#{org}/migrations",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.Migration, :t}}}],
      opts: opts
    })
  end

  @doc """
  List repositories for a user migration

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/migrations/users#list-repositories-for-a-user-migration)

  """
  @spec list_repos_for_authenticated_user(integer, keyword) ::
          {:ok, [GitHub.MinimalRepository.t()]} | {:error, GitHub.Error.t()}
  def list_repos_for_authenticated_user(migration_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [migration_id: migration_id],
      url: "/user/migrations/#{migration_id}/repositories",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.MinimalRepository, :t}}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  List repositories in an organization migration

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/migrations/orgs#list-repositories-in-an-organization-migration)

  """
  @spec list_repos_for_org(String.t(), integer, keyword) ::
          {:ok, [GitHub.MinimalRepository.t()]} | {:error, GitHub.Error.t()}
  def list_repos_for_org(org, migration_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [org: org, migration_id: migration_id],
      url: "/orgs/#{org}/migrations/#{migration_id}/repositories",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.MinimalRepository, :t}}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Map a commit author

  ## Resources

    * [API method documentation](https://docs.github.com/rest/migrations/source-imports#map-a-commit-author)

  """
  @spec map_commit_author(String.t(), String.t(), integer, map, keyword) ::
          {:ok, GitHub.PorterAuthor.t()} | {:error, GitHub.Error.t()}
  def map_commit_author(owner, repo, author_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, author_id: author_id],
      url: "/repos/#{owner}/#{repo}/import/authors/#{author_id}",
      body: body,
      method: :patch,
      request: [{"application/json", :map}],
      response: [
        {200, {GitHub.PorterAuthor, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}},
        {503, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Update Git LFS preference

  ## Resources

    * [API method documentation](https://docs.github.com/rest/migrations/source-imports#update-git-lfs-preference)

  """
  @spec set_lfs_preference(String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.Import.t()} | {:error, GitHub.Error.t()}
  def set_lfs_preference(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      url: "/repos/#{owner}/#{repo}/import/lfs",
      body: body,
      method: :patch,
      request: [{"application/json", :map}],
      response: [
        {200, {GitHub.Import, :t}},
        {422, {GitHub.ValidationError, :t}},
        {503, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Start a user migration

  ## Resources

    * [API method documentation](https://docs.github.com/rest/migrations/users#start-a-user-migration)

  """
  @spec start_for_authenticated_user(map, keyword) ::
          {:ok, GitHub.Migration.t()} | {:error, GitHub.Error.t()}
  def start_for_authenticated_user(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/user/migrations",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {201, {GitHub.Migration, :t}},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Start an organization migration

  ## Resources

    * [API method documentation](https://docs.github.com/rest/migrations/orgs#start-an-organization-migration)

  """
  @spec start_for_org(String.t(), map, keyword) ::
          {:ok, GitHub.Migration.t()} | {:error, GitHub.Error.t()}
  def start_for_org(org, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org],
      url: "/orgs/#{org}/migrations",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {201, {GitHub.Migration, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Start an import

  ## Resources

    * [API method documentation](https://docs.github.com/rest/migrations/source-imports#start-an-import)

  """
  @spec start_import(String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.Import.t()} | {:error, GitHub.Error.t()}
  def start_import(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      url: "/repos/#{owner}/#{repo}/import",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [
        {201, {GitHub.Import, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}},
        {503, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Unlock a user repository

  ## Resources

    * [API method documentation](https://docs.github.com/rest/migrations/users#unlock-a-user-repository)

  """
  @spec unlock_repo_for_authenticated_user(integer, String.t(), keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def unlock_repo_for_authenticated_user(migration_id, repo_name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [migration_id: migration_id, repo_name: repo_name],
      url: "/user/migrations/#{migration_id}/repos/#{repo_name}/lock",
      method: :delete,
      response: [
        {204, nil},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Unlock an organization repository

  ## Resources

    * [API method documentation](https://docs.github.com/rest/migrations/orgs#unlock-an-organization-repository)

  """
  @spec unlock_repo_for_org(String.t(), integer, String.t(), keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def unlock_repo_for_org(org, migration_id, repo_name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, migration_id: migration_id, repo_name: repo_name],
      url: "/orgs/#{org}/migrations/#{migration_id}/repos/#{repo_name}/lock",
      method: :delete,
      response: [{204, nil}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Update an import

  ## Resources

    * [API method documentation](https://docs.github.com/rest/migrations/source-imports#update-an-import)

  """
  @spec update_import(String.t(), String.t(), map | nil, keyword) ::
          {:ok, GitHub.Import.t()} | {:error, GitHub.Error.t()}
  def update_import(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      url: "/repos/#{owner}/#{repo}/import",
      body: body,
      method: :patch,
      request: [{"application/json", {:nullable, :map}}],
      response: [{200, {GitHub.Import, :t}}, {503, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end
end
