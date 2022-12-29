defmodule GitHub.Codespaces do
  @moduledoc """
  Provides API endpoints related to codespaces
  """

  @default_client GitHub.Client

  @doc """
  Add a selected repository to a user secret

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/codespaces#add-a-selected-repository-to-a-user-secret)

  """
  @spec add_repository_for_secret_for_authenticated_user(String.t(), integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def add_repository_for_secret_for_authenticated_user(secret_name, repository_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/user/codespaces/secrets/#{secret_name}/repositories/#{repository_id}",
      method: :put,
      response: [
        {204, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Add selected repository to an organization secret

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/codespaces#add-selected-repository-to-an-organization-secret)

  """
  @spec add_selected_repo_to_org_secret(String.t(), String.t(), integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def add_selected_repo_to_org_secret(org, secret_name, repository_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/orgs/#{org}/codespaces/secrets/#{secret_name}/repositories/#{repository_id}",
      method: :put,
      response: [
        {204, nil},
        {404, {GitHub.BasicError, :t}},
        {409, nil},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List machine types for a codespace

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/codespaces#list-machine-types-for-a-codespace)

  """
  @spec codespace_machines_for_authenticated_user(String.t(), keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def codespace_machines_for_authenticated_user(codespace_name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/user/codespaces/#{codespace_name}/machines",
      method: :get,
      response: [
        {200, :map},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Create a codespace for the authenticated user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/codespaces#create-a-codespace-for-the-authenticated-user)

  """
  @spec create_for_authenticated_user(map, keyword) ::
          {:ok, GitHub.Codespace.t()} | {:error, GitHub.Error.t()}
  def create_for_authenticated_user(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/user/codespaces",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {201, {GitHub.Codespace, :t}},
        {202, {GitHub.Codespace, :t}},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {503, :map}
      ],
      opts: opts
    })
  end

  @doc """
  Create or update an organization secret

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/codespaces#create-or-update-an-organization-secret)

  """
  @spec create_or_update_org_secret(String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.EmptyObject.t()} | {:error, GitHub.Error.t()}
  def create_or_update_org_secret(org, secret_name, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/orgs/#{org}/codespaces/secrets/#{secret_name}",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [
        {201, {GitHub.EmptyObject, :t}},
        {204, nil},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Create or update a repository secret

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/codespaces#create-or-update-a-repository-secret)

  """
  @spec create_or_update_repo_secret(String.t(), String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.EmptyObject.t()} | {:error, GitHub.Error.t()}
  def create_or_update_repo_secret(owner, repo, secret_name, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/repos/#{owner}/#{repo}/codespaces/secrets/#{secret_name}",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [{201, {GitHub.EmptyObject, :t}}, {204, nil}],
      opts: opts
    })
  end

  @doc """
  Create or update a secret for the authenticated user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/codespaces#create-or-update-a-secret-for-the-authenticated-user)

  """
  @spec create_or_update_secret_for_authenticated_user(String.t(), map, keyword) ::
          {:ok, GitHub.EmptyObject.t()} | {:error, GitHub.Error.t()}
  def create_or_update_secret_for_authenticated_user(secret_name, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/user/codespaces/secrets/#{secret_name}",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [
        {201, {GitHub.EmptyObject, :t}},
        {204, nil},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Create a codespace from a pull request

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/codespaces#create-a-codespace-from-a-pull-request)

  """
  @spec create_with_pr_for_authenticated_user(String.t(), String.t(), integer, map, keyword) ::
          {:ok, GitHub.Codespace.t()} | {:error, GitHub.Error.t()}
  def create_with_pr_for_authenticated_user(owner, repo, pull_number, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/repos/#{owner}/#{repo}/pulls/#{pull_number}/codespaces",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {201, {GitHub.Codespace, :t}},
        {202, {GitHub.Codespace, :t}},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {503, :map}
      ],
      opts: opts
    })
  end

  @doc """
  Create a codespace in a repository

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/codespaces#create-a-codespace-in-a-repository)

  """
  @spec create_with_repo_for_authenticated_user(String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.Codespace.t()} | {:error, GitHub.Error.t()}
  def create_with_repo_for_authenticated_user(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/repos/#{owner}/#{repo}/codespaces",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {201, {GitHub.Codespace, :t}},
        {202, {GitHub.Codespace, :t}},
        {400, {GitHub.BasicError, :t}},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {503, :map}
      ],
      opts: opts
    })
  end

  @doc """
  Delete a codespace for the authenticated user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/codespaces#delete-a-codespace-for-the-authenticated-user)

  """
  @spec delete_for_authenticated_user(String.t(), keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def delete_for_authenticated_user(codespace_name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/user/codespaces/#{codespace_name}",
      method: :delete,
      response: [
        {202, :map},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Delete a codespace from the organization

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/codespaces)

  """
  @spec delete_from_organization(String.t(), String.t(), String.t(), keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def delete_from_organization(org, username, codespace_name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/orgs/#{org}/members/#{username}/codespaces/#{codespace_name}",
      method: :delete,
      response: [
        {202, :map},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Delete an organization secret

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/codespaces#delete-an-organization-secret)

  """
  @spec delete_org_secret(String.t(), String.t(), keyword) :: :ok | {:error, GitHub.Error.t()}
  def delete_org_secret(org, secret_name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/orgs/#{org}/codespaces/secrets/#{secret_name}",
      method: :delete,
      response: [{204, nil}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Delete a repository secret

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/codespaces#delete-a-repository-secret)

  """
  @spec delete_repo_secret(String.t(), String.t(), String.t(), keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def delete_repo_secret(owner, repo, secret_name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/repos/#{owner}/#{repo}/codespaces/secrets/#{secret_name}",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Delete a secret for the authenticated user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/codespaces#delete-a-secret-for-the-authenticated-user)

  """
  @spec delete_secret_for_authenticated_user(String.t(), keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def delete_secret_for_authenticated_user(secret_name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/user/codespaces/secrets/#{secret_name}",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Export a codespace for the authenticated user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/codespaces/codespaces#export-a-codespace-for-the-authenticated-user)

  """
  @spec export_for_authenticated_user(String.t(), keyword) ::
          {:ok, GitHub.Codespace.ExportDetails.t()} | {:error, GitHub.Error.t()}
  def export_for_authenticated_user(codespace_name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/user/codespaces/#{codespace_name}/exports",
      method: :post,
      response: [
        {202, {GitHub.Codespace.ExportDetails, :t}},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List codespaces for a user in organization

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/codespaces#get-codespaces-for-user-in-org)

  """
  @spec get_codespaces_for_user_in_org(String.t(), String.t(), keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def get_codespaces_for_user_in_org(org, username, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      url: "/orgs/#{org}/members/#{username}/codespaces",
      method: :get,
      query: query,
      response: [
        {200, :map},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get details about a codespace export

  ## Resources

    * [API method documentation](https://docs.github.com/rest/codespaces/codespaces#get-details-about-a-codespace-export)

  """
  @spec get_export_details_for_authenticated_user(String.t(), String.t(), keyword) ::
          {:ok, GitHub.Codespace.ExportDetails.t()} | {:error, GitHub.Error.t()}
  def get_export_details_for_authenticated_user(codespace_name, export_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/user/codespaces/#{codespace_name}/exports/#{export_id}",
      method: :get,
      response: [{200, {GitHub.Codespace.ExportDetails, :t}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a codespace for the authenticated user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/codespaces#get-a-codespace-for-the-authenticated-user)

  """
  @spec get_for_authenticated_user(String.t(), keyword) ::
          {:ok, GitHub.Codespace.t()} | {:error, GitHub.Error.t()}
  def get_for_authenticated_user(codespace_name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/user/codespaces/#{codespace_name}",
      method: :get,
      response: [
        {200, {GitHub.Codespace, :t}},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get an organization public key

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/codespaces#get-an-organization-public-key)

  """
  @spec get_org_public_key(String.t(), keyword) ::
          {:ok, GitHub.Codespace.PublicKey.t()} | {:error, GitHub.Error.t()}
  def get_org_public_key(org, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/orgs/#{org}/codespaces/secrets/public-key",
      method: :get,
      response: [{200, {GitHub.Codespace.PublicKey, :t}}],
      opts: opts
    })
  end

  @doc """
  Get an organization secret

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/codespaces#get-an-organization-secret)

  """
  @spec get_org_secret(String.t(), String.t(), keyword) ::
          {:ok, GitHub.Codespace.OrgSecret.t()} | {:error, GitHub.Error.t()}
  def get_org_secret(org, secret_name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/orgs/#{org}/codespaces/secrets/#{secret_name}",
      method: :get,
      response: [{200, {GitHub.Codespace.OrgSecret, :t}}],
      opts: opts
    })
  end

  @doc """
  Get public key for the authenticated user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/codespaces#get-public-key-for-the-authenticated-user)

  """
  @spec get_public_key_for_authenticated_user(keyword) ::
          {:ok, GitHub.Codespace.UserPublicKey.t()} | {:error, GitHub.Error.t()}
  def get_public_key_for_authenticated_user(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/user/codespaces/secrets/public-key",
      method: :get,
      response: [{200, {GitHub.Codespace.UserPublicKey, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a repository public key

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/codespaces#get-a-repository-public-key)

  """
  @spec get_repo_public_key(String.t(), String.t(), keyword) ::
          {:ok, GitHub.Codespace.PublicKey.t()} | {:error, GitHub.Error.t()}
  def get_repo_public_key(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/repos/#{owner}/#{repo}/codespaces/secrets/public-key",
      method: :get,
      response: [{200, {GitHub.Codespace.PublicKey, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a repository secret

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/codespaces#get-a-repository-secret)

  """
  @spec get_repo_secret(String.t(), String.t(), String.t(), keyword) ::
          {:ok, GitHub.RepoCodespacesSecret.t()} | {:error, GitHub.Error.t()}
  def get_repo_secret(owner, repo, secret_name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/repos/#{owner}/#{repo}/codespaces/secrets/#{secret_name}",
      method: :get,
      response: [{200, {GitHub.RepoCodespacesSecret, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a secret for the authenticated user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/codespaces#get-a-secret-for-the-authenticated-user)

  """
  @spec get_secret_for_authenticated_user(String.t(), keyword) ::
          {:ok, GitHub.Codespace.Secret.t()} | {:error, GitHub.Error.t()}
  def get_secret_for_authenticated_user(secret_name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/user/codespaces/secrets/#{secret_name}",
      method: :get,
      response: [{200, {GitHub.Codespace.Secret, :t}}],
      opts: opts
    })
  end

  @doc """
  List devcontainer configurations in a repository for the authenticated user

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/codespaces#list-devcontainers-in-a-repository-for-the-authenticated-user)

  """
  @spec list_devcontainers_in_repository_for_authenticated_user(String.t(), String.t(), keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def list_devcontainers_in_repository_for_authenticated_user(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      url: "/repos/#{owner}/#{repo}/codespaces/devcontainers",
      method: :get,
      query: query,
      response: [
        {200, :map},
        {400, {GitHub.BasicError, :t}},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List codespaces for the authenticated user

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.
    * `repository_id` (integer): ID of the Repository to filter on

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/codespaces#list-codespaces-for-the-authenticated-user)

  """
  @spec list_for_authenticated_user(keyword) :: {:ok, map} | {:error, GitHub.Error.t()}
  def list_for_authenticated_user(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page, :repository_id])

    client.request(%{
      url: "/user/codespaces",
      method: :get,
      query: query,
      response: [
        {200, :map},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List codespaces for the organization

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/codespaces#list-in-organization)

  """
  @spec list_in_organization(String.t(), keyword) :: {:ok, map} | {:error, GitHub.Error.t()}
  def list_in_organization(org, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      url: "/orgs/#{org}/codespaces",
      method: :get,
      query: query,
      response: [
        {200, :map},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List codespaces in a repository for the authenticated user

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/codespaces#list-codespaces-in-a-repository-for-the-authenticated-user)

  """
  @spec list_in_repository_for_authenticated_user(String.t(), String.t(), keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def list_in_repository_for_authenticated_user(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      url: "/repos/#{owner}/#{repo}/codespaces",
      method: :get,
      query: query,
      response: [
        {200, :map},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List organization secrets

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/codespaces#list-organization-secrets)

  """
  @spec list_org_secrets(String.t(), keyword) :: {:ok, map} | {:error, GitHub.Error.t()}
  def list_org_secrets(org, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      url: "/orgs/#{org}/codespaces/secrets",
      method: :get,
      query: query,
      response: [{200, :map}],
      opts: opts
    })
  end

  @doc """
  List repository secrets

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/codespaces#list-repository-secrets)

  """
  @spec list_repo_secrets(String.t(), String.t(), keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def list_repo_secrets(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      url: "/repos/#{owner}/#{repo}/codespaces/secrets",
      method: :get,
      query: query,
      response: [{200, :map}],
      opts: opts
    })
  end

  @doc """
  List selected repositories for a user secret

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/codespaces#list-selected-repositories-for-a-user-secret)

  """
  @spec list_repositories_for_secret_for_authenticated_user(String.t(), keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def list_repositories_for_secret_for_authenticated_user(secret_name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/user/codespaces/secrets/#{secret_name}/repositories",
      method: :get,
      response: [
        {200, :map},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List secrets for the authenticated user

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/codespaces#list-secrets-for-the-authenticated-user)

  """
  @spec list_secrets_for_authenticated_user(keyword) :: {:ok, map} | {:error, GitHub.Error.t()}
  def list_secrets_for_authenticated_user(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      url: "/user/codespaces/secrets",
      method: :get,
      query: query,
      response: [{200, :map}],
      opts: opts
    })
  end

  @doc """
  List selected repositories for an organization secret

  ## Options

    * `page` (integer): Page number of the results to fetch.
    * `per_page` (integer): The number of results per page (max 100).

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/codespaces#list-selected-repositories-for-an-organization-secret)

  """
  @spec list_selected_repos_for_org_secret(String.t(), String.t(), keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def list_selected_repos_for_org_secret(org, secret_name, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      url: "/orgs/#{org}/codespaces/secrets/#{secret_name}/repositories",
      method: :get,
      query: query,
      response: [{200, :map}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Get default attributes for a codespace

  ## Options

    * `ref` (String.t()): The branch or commit to check for a default devcontainer path. If not specified, the default branch will be checked.
    * `client_ip` (String.t()): An alternative IP for default location auto-detection, such as when proxying a request.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/codespaces#preview-attributes-for-a-new-codespace)

  """
  @spec pre_flight_with_repo_for_authenticated_user(String.t(), String.t(), keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def pre_flight_with_repo_for_authenticated_user(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:client_ip, :ref])

    client.request(%{
      url: "/repos/#{owner}/#{repo}/codespaces/new",
      method: :get,
      query: query,
      response: [
        {200, :map},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Remove a selected repository from a user secret

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/codespaces#remove-a-selected-repository-from-a-user-secret)

  """
  @spec remove_repository_for_secret_for_authenticated_user(String.t(), integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def remove_repository_for_secret_for_authenticated_user(secret_name, repository_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/user/codespaces/secrets/#{secret_name}/repositories/#{repository_id}",
      method: :delete,
      response: [
        {204, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Remove selected repository from an organization secret

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/codespaces#remove-selected-repository-from-an-organization-secret)

  """
  @spec remove_selected_repo_from_org_secret(String.t(), String.t(), integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def remove_selected_repo_from_org_secret(org, secret_name, repository_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/orgs/#{org}/codespaces/secrets/#{secret_name}/repositories/#{repository_id}",
      method: :delete,
      response: [
        {204, nil},
        {404, {GitHub.BasicError, :t}},
        {409, nil},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List available machine types for a repository

  ## Options

    * `location` (String.t()): The location to check for available machines. Assigned by IP if not provided.
    * `client_ip` (String.t()): IP for location auto-detection when proxying a request

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/codespaces#list-available-machine-types-for-a-repository)

  """
  @spec repo_machines_for_authenticated_user(String.t(), String.t(), keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def repo_machines_for_authenticated_user(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:client_ip, :location])

    client.request(%{
      url: "/repos/#{owner}/#{repo}/codespaces/machines",
      method: :get,
      query: query,
      response: [
        {200, :map},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Manage access control for organization codespaces

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/codespaces#set-codespaces-billing)

  """
  @spec set_codespaces_billing(String.t(), map, keyword) :: :ok | {:error, GitHub.Error.t()}
  def set_codespaces_billing(org, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/orgs/#{org}/codespaces/billing",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [
        {204, nil},
        {304, nil},
        {400, nil},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Set selected repositories for a user secret

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/codespaces#set-selected-repositories-for-a-user-secret)

  """
  @spec set_repositories_for_secret_for_authenticated_user(String.t(), map, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def set_repositories_for_secret_for_authenticated_user(secret_name, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/user/codespaces/secrets/#{secret_name}/repositories",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [
        {204, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Set selected repositories for an organization secret

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/codespaces#set-selected-repositories-for-an-organization-secret)

  """
  @spec set_selected_repos_for_org_secret(String.t(), String.t(), map, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def set_selected_repos_for_org_secret(org, secret_name, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/orgs/#{org}/codespaces/secrets/#{secret_name}/repositories",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [{204, nil}, {404, {GitHub.BasicError, :t}}, {409, nil}],
      opts: opts
    })
  end

  @doc """
  Start a codespace for the authenticated user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/codespaces#start-a-codespace-for-the-authenticated-user)

  """
  @spec start_for_authenticated_user(String.t(), keyword) ::
          {:ok, GitHub.Codespace.t()} | {:error, GitHub.Error.t()}
  def start_for_authenticated_user(codespace_name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/user/codespaces/#{codespace_name}/start",
      method: :post,
      response: [
        {200, {GitHub.Codespace, :t}},
        {304, nil},
        {400, {GitHub.BasicError, :t}},
        {401, {GitHub.BasicError, :t}},
        {402, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {409, {GitHub.BasicError, :t}},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Stop a codespace for the authenticated user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/codespaces#stop-a-codespace-for-the-authenticated-user)

  """
  @spec stop_for_authenticated_user(String.t(), keyword) ::
          {:ok, GitHub.Codespace.t()} | {:error, GitHub.Error.t()}
  def stop_for_authenticated_user(codespace_name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/user/codespaces/#{codespace_name}/stop",
      method: :post,
      response: [
        {200, {GitHub.Codespace, :t}},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Stop a codespace for an organization user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/codespaces)

  """
  @spec stop_in_organization(String.t(), String.t(), String.t(), keyword) ::
          {:ok, GitHub.Codespace.t()} | {:error, GitHub.Error.t()}
  def stop_in_organization(org, username, codespace_name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/orgs/#{org}/members/#{username}/codespaces/#{codespace_name}/stop",
      method: :post,
      response: [
        {200, {GitHub.Codespace, :t}},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Update a codespace for the authenticated user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/codespaces#update-a-codespace-for-the-authenticated-user)

  """
  @spec update_for_authenticated_user(String.t(), map, keyword) ::
          {:ok, GitHub.Codespace.t()} | {:error, GitHub.Error.t()}
  def update_for_authenticated_user(codespace_name, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/user/codespaces/#{codespace_name}",
      body: body,
      method: :patch,
      request: [{"application/json", :map}],
      response: [
        {200, {GitHub.Codespace, :t}},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end
end
