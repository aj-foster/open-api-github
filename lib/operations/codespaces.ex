defmodule GitHub.Codespaces do
  @moduledoc """
  Provides API endpoints related to codespaces
  """

  @default_client GitHub.Client

  @doc """
  Add a selected repository to a user secret

  Adds a repository to the selected repositories for a user's codespace secret.
  You must authenticate using an access token with the `codespace` or `codespace:secrets` scope to use this endpoint. User must have Codespaces access to use this endpoint.
  GitHub Apps must have write access to the `codespaces_user_secrets` user permission and write access to the `codespaces_secrets` repository permission on the referenced repository to use this endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/codespaces/secrets#add-a-selected-repository-to-a-user-secret)

  """
  @spec add_repository_for_secret_for_authenticated_user(String.t(), integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def add_repository_for_secret_for_authenticated_user(secret_name, repository_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [secret_name: secret_name, repository_id: repository_id],
      call: {GitHub.Codespaces, :add_repository_for_secret_for_authenticated_user},
      url: "/user/codespaces/secrets/#{secret_name}/repositories/#{repository_id}",
      method: :put,
      response: [
        {204, :null},
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

  Adds a repository to an organization secret when the `visibility` for repository access is set to `selected`. The visibility is set when you [Create or update an organization secret](https://docs.github.com/rest/codespaces/organization-secrets#create-or-update-an-organization-secret). You must authenticate using an access token with the `admin:org` scope to use this endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/codespaces/organization-secrets#add-selected-repository-to-an-organization-secret)

  """
  @spec add_selected_repo_to_org_secret(String.t(), String.t(), integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def add_selected_repo_to_org_secret(org, secret_name, repository_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, secret_name: secret_name, repository_id: repository_id],
      call: {GitHub.Codespaces, :add_selected_repo_to_org_secret},
      url: "/orgs/#{org}/codespaces/secrets/#{secret_name}/repositories/#{repository_id}",
      method: :put,
      response: [
        {204, :null},
        {404, {GitHub.BasicError, :t}},
        {409, :null},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List machine types for a codespace

  List the machine types a codespace can transition to use.

  You must authenticate using an access token with the `codespace` scope to use this endpoint.

  GitHub Apps must have read access to the `codespaces_metadata` repository permission to use this endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/codespaces/machines#list-machine-types-for-a-codespace)

  """
  @spec codespace_machines_for_authenticated_user(String.t(), keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def codespace_machines_for_authenticated_user(codespace_name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [codespace_name: codespace_name],
      call: {GitHub.Codespaces, :codespace_machines_for_authenticated_user},
      url: "/user/codespaces/#{codespace_name}/machines",
      method: :get,
      response: [
        {200, :map},
        {304, :null},
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

  Creates a new codespace, owned by the authenticated user.

  This endpoint requires either a `repository_id` OR a `pull_request` but not both.

  You must authenticate using an access token with the `codespace` scope to use this endpoint.

  GitHub Apps must have write access to the `codespaces` repository permission to use this endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/codespaces/codespaces#create-a-codespace-for-the-authenticated-user)

  """
  @spec create_for_authenticated_user(map, keyword) ::
          {:ok, GitHub.Codespace.t()} | {:error, GitHub.Error.t()}
  def create_for_authenticated_user(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {GitHub.Codespaces, :create_for_authenticated_user},
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

  Creates or updates an organization secret with an encrypted value. Encrypt your secret using
  [LibSodium](https://libsodium.gitbook.io/doc/bindings_for_other_languages). For more information, see "[Encrypting secrets for the REST API](https://docs.github.com/rest/guides/encrypting-secrets-for-the-rest-api)."

  You must authenticate using an access
  token with the `admin:org` scope to use this endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/codespaces/organization-secrets#create-or-update-an-organization-secret)

  """
  @spec create_or_update_org_secret(String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.EmptyObject.t()} | {:error, GitHub.Error.t()}
  def create_or_update_org_secret(org, secret_name, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, secret_name: secret_name, body: body],
      call: {GitHub.Codespaces, :create_or_update_org_secret},
      url: "/orgs/#{org}/codespaces/secrets/#{secret_name}",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [
        {201, {GitHub.EmptyObject, :t}},
        {204, :null},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Create or update a repository secret

  Creates or updates a repository secret with an encrypted value. Encrypt your secret using
  [LibSodium](https://libsodium.gitbook.io/doc/bindings_for_other_languages). For more information, see "[Encrypting secrets for the REST API](https://docs.github.com/rest/guides/encrypting-secrets-for-the-rest-api)."

  You must authenticate using an access
  token with the `repo` scope to use this endpoint. GitHub Apps must have write access to the `codespaces_secrets`
  repository permission to use this endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/codespaces/repository-secrets#create-or-update-a-repository-secret)

  """
  @spec create_or_update_repo_secret(String.t(), String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.EmptyObject.t()} | {:error, GitHub.Error.t()}
  def create_or_update_repo_secret(owner, repo, secret_name, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, secret_name: secret_name, body: body],
      call: {GitHub.Codespaces, :create_or_update_repo_secret},
      url: "/repos/#{owner}/#{repo}/codespaces/secrets/#{secret_name}",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [{201, {GitHub.EmptyObject, :t}}, {204, :null}],
      opts: opts
    })
  end

  @doc """
  Create or update a secret for the authenticated user

  Creates or updates a secret for a user's codespace with an encrypted value. Encrypt your secret using
  [LibSodium](https://libsodium.gitbook.io/doc/bindings_for_other_languages). For more information, see "[Encrypting secrets for the REST API](https://docs.github.com/rest/guides/encrypting-secrets-for-the-rest-api)."

  You must authenticate using an access token with the `codespace` or `codespace:secrets` scope to use this endpoint. User must also have Codespaces access to use this endpoint.

  GitHub Apps must have write access to the `codespaces_user_secrets` user permission and `codespaces_secrets` repository permission on all referenced repositories to use this endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/codespaces/secrets#create-or-update-a-secret-for-the-authenticated-user)

  """
  @spec create_or_update_secret_for_authenticated_user(String.t(), map, keyword) ::
          {:ok, GitHub.EmptyObject.t()} | {:error, GitHub.Error.t()}
  def create_or_update_secret_for_authenticated_user(secret_name, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [secret_name: secret_name, body: body],
      call: {GitHub.Codespaces, :create_or_update_secret_for_authenticated_user},
      url: "/user/codespaces/secrets/#{secret_name}",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [
        {201, {GitHub.EmptyObject, :t}},
        {204, :null},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Create a codespace from a pull request

  Creates a codespace owned by the authenticated user for the specified pull request.

  You must authenticate using an access token with the `codespace` scope to use this endpoint.

  GitHub Apps must have write access to the `codespaces` repository permission to use this endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/codespaces/codespaces#create-a-codespace-from-a-pull-request)

  """
  @spec create_with_pr_for_authenticated_user(String.t(), String.t(), integer, map | nil, keyword) ::
          {:ok, GitHub.Codespace.t()} | {:error, GitHub.Error.t()}
  def create_with_pr_for_authenticated_user(owner, repo, pull_number, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, pull_number: pull_number, body: body],
      call: {GitHub.Codespaces, :create_with_pr_for_authenticated_user},
      url: "/repos/#{owner}/#{repo}/pulls/#{pull_number}/codespaces",
      body: body,
      method: :post,
      request: [{"application/json", {:union, [:map, :null]}}],
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

  Creates a codespace owned by the authenticated user in the specified repository.

  You must authenticate using an access token with the `codespace` scope to use this endpoint.

  GitHub Apps must have write access to the `codespaces` repository permission to use this endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/codespaces/codespaces#create-a-codespace-in-a-repository)

  """
  @spec create_with_repo_for_authenticated_user(String.t(), String.t(), map | nil, keyword) ::
          {:ok, GitHub.Codespace.t()} | {:error, GitHub.Error.t()}
  def create_with_repo_for_authenticated_user(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, body: body],
      call: {GitHub.Codespaces, :create_with_repo_for_authenticated_user},
      url: "/repos/#{owner}/#{repo}/codespaces",
      body: body,
      method: :post,
      request: [{"application/json", {:union, [:map, :null]}}],
      response: [
        {201, {GitHub.Codespace, :t}},
        {202, {GitHub.Codespace, :t}},
        {400, {:union, [{GitHub.BasicError, :t}, {GitHub.SCIM.Error, :t}]}},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {503, :map}
      ],
      opts: opts
    })
  end

  @doc """
  Remove users from Codespaces access for an organization

  Codespaces for the specified users will no longer be billed to the organization.

  To use this endpoint, the access settings for the organization must be set to `selected_members`.
  For information on how to change this setting, see "[Manage access control for organization codespaces](https://docs.github.com/rest/codespaces/organizations#manage-access-control-for-organization-codespaces)."

  You must authenticate using an access token with the `admin:org` scope to use this endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/codespaces/organizations#remove-users-from-codespaces-access-for-an-organization)

  """
  @spec delete_codespaces_access_users(String.t(), map, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def delete_codespaces_access_users(org, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, body: body],
      call: {GitHub.Codespaces, :delete_codespaces_access_users},
      url: "/orgs/#{org}/codespaces/access/selected_users",
      body: body,
      method: :delete,
      request: [{"application/json", :map}],
      response: [
        {204, :null},
        {304, :null},
        {400, :null},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Delete a codespace for the authenticated user

  Deletes a user's codespace.

  You must authenticate using an access token with the `codespace` scope to use this endpoint.

  GitHub Apps must have write access to the `codespaces` repository permission to use this endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/codespaces/codespaces#delete-a-codespace-for-the-authenticated-user)

  """
  @spec delete_for_authenticated_user(String.t(), keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def delete_for_authenticated_user(codespace_name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [codespace_name: codespace_name],
      call: {GitHub.Codespaces, :delete_for_authenticated_user},
      url: "/user/codespaces/#{codespace_name}",
      method: :delete,
      response: [
        {202, :map},
        {304, :null},
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

  Deletes a user's codespace.

  You must authenticate using an access token with the `admin:org` scope to use this endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/codespaces/organizations#delete-a-codespace-from-the-organization)

  """
  @spec delete_from_organization(String.t(), String.t(), String.t(), keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def delete_from_organization(org, username, codespace_name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, username: username, codespace_name: codespace_name],
      call: {GitHub.Codespaces, :delete_from_organization},
      url: "/orgs/#{org}/members/#{username}/codespaces/#{codespace_name}",
      method: :delete,
      response: [
        {202, :map},
        {304, :null},
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

  Deletes an organization secret using the secret name. You must authenticate using an access token with the `admin:org` scope to use this endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/codespaces/organization-secrets#delete-an-organization-secret)

  """
  @spec delete_org_secret(String.t(), String.t(), keyword) :: :ok | {:error, GitHub.Error.t()}
  def delete_org_secret(org, secret_name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, secret_name: secret_name],
      call: {GitHub.Codespaces, :delete_org_secret},
      url: "/orgs/#{org}/codespaces/secrets/#{secret_name}",
      method: :delete,
      response: [{204, :null}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Delete a repository secret

  Deletes a secret in a repository using the secret name. You must authenticate using an access token with the `repo` scope to use this endpoint. GitHub Apps must have write access to the `codespaces_secrets` repository permission to use this endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/codespaces/repository-secrets#delete-a-repository-secret)

  """
  @spec delete_repo_secret(String.t(), String.t(), String.t(), keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def delete_repo_secret(owner, repo, secret_name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, secret_name: secret_name],
      call: {GitHub.Codespaces, :delete_repo_secret},
      url: "/repos/#{owner}/#{repo}/codespaces/secrets/#{secret_name}",
      method: :delete,
      response: [{204, :null}],
      opts: opts
    })
  end

  @doc """
  Delete a secret for the authenticated user

  Deletes a secret from a user's codespaces using the secret name. Deleting the secret will remove access from all codespaces that were allowed to access the secret.

  You must authenticate using an access token with the `codespace` or `codespace:secrets` scope to use this endpoint. User must have Codespaces access to use this endpoint.

  GitHub Apps must have write access to the `codespaces_user_secrets` user permission to use this endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/codespaces/secrets#delete-a-secret-for-the-authenticated-user)

  """
  @spec delete_secret_for_authenticated_user(String.t(), keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def delete_secret_for_authenticated_user(secret_name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [secret_name: secret_name],
      call: {GitHub.Codespaces, :delete_secret_for_authenticated_user},
      url: "/user/codespaces/secrets/#{secret_name}",
      method: :delete,
      response: [{204, :null}],
      opts: opts
    })
  end

  @doc """
  Export a codespace for the authenticated user

  Triggers an export of the specified codespace and returns a URL and ID where the status of the export can be monitored.

  If changes cannot be pushed to the codespace's repository, they will be pushed to a new or previously-existing fork instead.

  You must authenticate using a personal access token with the `codespace` scope to use this endpoint.

  GitHub Apps must have write access to the `codespaces_lifecycle_admin` repository permission to use this endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/codespaces/codespaces#export-a-codespace-for-the-authenticated-user)

  """
  @spec export_for_authenticated_user(String.t(), keyword) ::
          {:ok, GitHub.Codespace.ExportDetails.t()} | {:error, GitHub.Error.t()}
  def export_for_authenticated_user(codespace_name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [codespace_name: codespace_name],
      call: {GitHub.Codespaces, :export_for_authenticated_user},
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

  Lists the codespaces that a member of an organization has for repositories in that organization.

  You must authenticate using an access token with the `admin:org` scope to use this endpoint.

  ## Options

    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/codespaces/organizations#list-codespaces-for-a-user-in-organization)

  """
  @spec get_codespaces_for_user_in_org(String.t(), String.t(), keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def get_codespaces_for_user_in_org(org, username, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [org: org, username: username],
      call: {GitHub.Codespaces, :get_codespaces_for_user_in_org},
      url: "/orgs/#{org}/members/#{username}/codespaces",
      method: :get,
      query: query,
      response: [
        {200, :map},
        {304, :null},
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

  Gets information about an export of a codespace.

  You must authenticate using a personal access token with the `codespace` scope to use this endpoint.

  GitHub Apps must have read access to the `codespaces_lifecycle_admin` repository permission to use this endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/codespaces/codespaces#get-details-about-a-codespace-export)

  """
  @spec get_export_details_for_authenticated_user(String.t(), String.t(), keyword) ::
          {:ok, GitHub.Codespace.ExportDetails.t()} | {:error, GitHub.Error.t()}
  def get_export_details_for_authenticated_user(codespace_name, export_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [codespace_name: codespace_name, export_id: export_id],
      call: {GitHub.Codespaces, :get_export_details_for_authenticated_user},
      url: "/user/codespaces/#{codespace_name}/exports/#{export_id}",
      method: :get,
      response: [{200, {GitHub.Codespace.ExportDetails, :t}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a codespace for the authenticated user

  Gets information about a user's codespace.

  You must authenticate using an access token with the `codespace` scope to use this endpoint.

  GitHub Apps must have read access to the `codespaces` repository permission to use this endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/codespaces/codespaces#get-a-codespace-for-the-authenticated-user)

  """
  @spec get_for_authenticated_user(String.t(), keyword) ::
          {:ok, GitHub.Codespace.t()} | {:error, GitHub.Error.t()}
  def get_for_authenticated_user(codespace_name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [codespace_name: codespace_name],
      call: {GitHub.Codespaces, :get_for_authenticated_user},
      url: "/user/codespaces/#{codespace_name}",
      method: :get,
      response: [
        {200, {GitHub.Codespace, :t}},
        {304, :null},
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

  Gets a public key for an organization, which is required in order to encrypt secrets. You need to encrypt the value of a secret before you can create or update secrets. You must authenticate using an access token with the `admin:org` scope to use this endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/codespaces/organization-secrets#get-an-organization-public-key)

  """
  @spec get_org_public_key(String.t(), keyword) ::
          {:ok, GitHub.Codespace.PublicKey.t()} | {:error, GitHub.Error.t()}
  def get_org_public_key(org, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org],
      call: {GitHub.Codespaces, :get_org_public_key},
      url: "/orgs/#{org}/codespaces/secrets/public-key",
      method: :get,
      response: [{200, {GitHub.Codespace.PublicKey, :t}}],
      opts: opts
    })
  end

  @doc """
  Get an organization secret

  Gets an organization secret without revealing its encrypted value.
  You must authenticate using an access token with the `admin:org` scope to use this endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/codespaces/organization-secrets#get-an-organization-secret)

  """
  @spec get_org_secret(String.t(), String.t(), keyword) ::
          {:ok, GitHub.Codespace.OrgSecret.t()} | {:error, GitHub.Error.t()}
  def get_org_secret(org, secret_name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, secret_name: secret_name],
      call: {GitHub.Codespaces, :get_org_secret},
      url: "/orgs/#{org}/codespaces/secrets/#{secret_name}",
      method: :get,
      response: [{200, {GitHub.Codespace.OrgSecret, :t}}],
      opts: opts
    })
  end

  @doc """
  Get public key for the authenticated user

  Gets your public key, which you need to encrypt secrets. You need to encrypt a secret before you can create or update secrets.

  You must authenticate using an access token with the `codespace` or `codespace:secrets` scope to use this endpoint. User must have Codespaces access to use this endpoint.

  GitHub Apps must have read access to the `codespaces_user_secrets` user permission to use this endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/codespaces/secrets#get-public-key-for-the-authenticated-user)

  """
  @spec get_public_key_for_authenticated_user(keyword) ::
          {:ok, GitHub.Codespace.UserPublicKey.t()} | {:error, GitHub.Error.t()}
  def get_public_key_for_authenticated_user(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [],
      call: {GitHub.Codespaces, :get_public_key_for_authenticated_user},
      url: "/user/codespaces/secrets/public-key",
      method: :get,
      response: [{200, {GitHub.Codespace.UserPublicKey, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a repository public key

  Gets your public key, which you need to encrypt secrets. You need to encrypt a secret before you can create or update secrets. Anyone with read access to the repository can use this endpoint. If the repository is private you must use an access token with the `repo` scope. GitHub Apps must have write access to the `codespaces_secrets` repository permission to use this endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/codespaces/repository-secrets#get-a-repository-public-key)

  """
  @spec get_repo_public_key(String.t(), String.t(), keyword) ::
          {:ok, GitHub.Codespace.PublicKey.t()} | {:error, GitHub.Error.t()}
  def get_repo_public_key(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Codespaces, :get_repo_public_key},
      url: "/repos/#{owner}/#{repo}/codespaces/secrets/public-key",
      method: :get,
      response: [{200, {GitHub.Codespace.PublicKey, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a repository secret

  Gets a single repository secret without revealing its encrypted value. You must authenticate using an access token with the `repo` scope to use this endpoint. GitHub Apps must have write access to the `codespaces_secrets` repository permission to use this endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/codespaces/repository-secrets#get-a-repository-secret)

  """
  @spec get_repo_secret(String.t(), String.t(), String.t(), keyword) ::
          {:ok, GitHub.RepoCodespacesSecret.t()} | {:error, GitHub.Error.t()}
  def get_repo_secret(owner, repo, secret_name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, secret_name: secret_name],
      call: {GitHub.Codespaces, :get_repo_secret},
      url: "/repos/#{owner}/#{repo}/codespaces/secrets/#{secret_name}",
      method: :get,
      response: [{200, {GitHub.RepoCodespacesSecret, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a secret for the authenticated user

  Gets a secret available to a user's codespaces without revealing its encrypted value.

  You must authenticate using an access token with the `codespace` or `codespace:secrets` scope to use this endpoint. User must have Codespaces access to use this endpoint.

  GitHub Apps must have read access to the `codespaces_user_secrets` user permission to use this endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/codespaces/secrets#get-a-secret-for-the-authenticated-user)

  """
  @spec get_secret_for_authenticated_user(String.t(), keyword) ::
          {:ok, GitHub.Codespace.Secret.t()} | {:error, GitHub.Error.t()}
  def get_secret_for_authenticated_user(secret_name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [secret_name: secret_name],
      call: {GitHub.Codespaces, :get_secret_for_authenticated_user},
      url: "/user/codespaces/secrets/#{secret_name}",
      method: :get,
      response: [{200, {GitHub.Codespace.Secret, :t}}],
      opts: opts
    })
  end

  @doc """
  List devcontainer configurations in a repository for the authenticated user

  Lists the devcontainer.json files associated with a specified repository and the authenticated user. These files
  specify launchpoint configurations for codespaces created within the repository.

  You must authenticate using an access token with the `codespace` scope to use this endpoint.

  GitHub Apps must have read access to the `codespaces_metadata` repository permission to use this endpoint.

  ## Options

    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/codespaces/codespaces#list-devcontainer-configurations-in-a-repository-for-the-authenticated-user)

  """
  @spec list_devcontainers_in_repository_for_authenticated_user(String.t(), String.t(), keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def list_devcontainers_in_repository_for_authenticated_user(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Codespaces, :list_devcontainers_in_repository_for_authenticated_user},
      url: "/repos/#{owner}/#{repo}/codespaces/devcontainers",
      method: :get,
      query: query,
      response: [
        {200, :map},
        {400, {:union, [{GitHub.BasicError, :t}, {GitHub.SCIM.Error, :t}]}},
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

  Lists the authenticated user's codespaces.

  You must authenticate using an access token with the `codespace` scope to use this endpoint.

  GitHub Apps must have read access to the `codespaces` repository permission to use this endpoint.

  ## Options

    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.
    * `repository_id`: ID of the Repository to filter on

  ## Resources

    * [API method documentation](https://docs.github.com/rest/codespaces/codespaces#list-codespaces-for-the-authenticated-user)

  """
  @spec list_for_authenticated_user(keyword) :: {:ok, map} | {:error, GitHub.Error.t()}
  def list_for_authenticated_user(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page, :repository_id])

    client.request(%{
      args: [],
      call: {GitHub.Codespaces, :list_for_authenticated_user},
      url: "/user/codespaces",
      method: :get,
      query: query,
      response: [
        {200, :map},
        {304, :null},
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

  Lists the codespaces associated to a specified organization.

  You must authenticate using an access token with the `admin:org` scope to use this endpoint.

  ## Options

    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/codespaces/organizations#list-codespaces-for-the-organization)

  """
  @spec list_in_organization(String.t(), keyword) :: {:ok, map} | {:error, GitHub.Error.t()}
  def list_in_organization(org, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [org: org],
      call: {GitHub.Codespaces, :list_in_organization},
      url: "/orgs/#{org}/codespaces",
      method: :get,
      query: query,
      response: [
        {200, :map},
        {304, :null},
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

  Lists the codespaces associated to a specified repository and the authenticated user.

  You must authenticate using an access token with the `codespace` scope to use this endpoint.

  GitHub Apps must have read access to the `codespaces` repository permission to use this endpoint.

  ## Options

    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/codespaces/codespaces#list-codespaces-in-a-repository-for-the-authenticated-user)

  """
  @spec list_in_repository_for_authenticated_user(String.t(), String.t(), keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def list_in_repository_for_authenticated_user(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Codespaces, :list_in_repository_for_authenticated_user},
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

  Lists all Codespaces secrets available at the organization-level without revealing their encrypted values.
  You must authenticate using an access token with the `admin:org` scope to use this endpoint.

  ## Options

    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/codespaces/organization-secrets#list-organization-secrets)

  """
  @spec list_org_secrets(String.t(), keyword) :: {:ok, map} | {:error, GitHub.Error.t()}
  def list_org_secrets(org, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [org: org],
      call: {GitHub.Codespaces, :list_org_secrets},
      url: "/orgs/#{org}/codespaces/secrets",
      method: :get,
      query: query,
      response: [{200, :map}],
      opts: opts
    })
  end

  @doc """
  List repository secrets

  Lists all secrets available in a repository without revealing their encrypted values. You must authenticate using an access token with the `repo` scope to use this endpoint. GitHub Apps must have write access to the `codespaces_secrets` repository permission to use this endpoint.

  ## Options

    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/codespaces/repository-secrets#list-repository-secrets)

  """
  @spec list_repo_secrets(String.t(), String.t(), keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def list_repo_secrets(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Codespaces, :list_repo_secrets},
      url: "/repos/#{owner}/#{repo}/codespaces/secrets",
      method: :get,
      query: query,
      response: [{200, :map}],
      opts: opts
    })
  end

  @doc """
  List selected repositories for a user secret

  List the repositories that have been granted the ability to use a user's codespace secret.

  You must authenticate using an access token with the `codespace` or `codespace:secrets` scope to use this endpoint. User must have Codespaces access to use this endpoint.

  GitHub Apps must have read access to the `codespaces_user_secrets` user permission and write access to the `codespaces_secrets` repository permission on all referenced repositories to use this endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/codespaces/secrets#list-selected-repositories-for-a-user-secret)

  """
  @spec list_repositories_for_secret_for_authenticated_user(String.t(), keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def list_repositories_for_secret_for_authenticated_user(secret_name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [secret_name: secret_name],
      call: {GitHub.Codespaces, :list_repositories_for_secret_for_authenticated_user},
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

  Lists all secrets available for a user's Codespaces without revealing their
  encrypted values.

  You must authenticate using an access token with the `codespace` or `codespace:secrets` scope to use this endpoint. User must have Codespaces access to use this endpoint.

  GitHub Apps must have read access to the `codespaces_user_secrets` user permission to use this endpoint.

  ## Options

    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/codespaces/secrets#list-secrets-for-the-authenticated-user)

  """
  @spec list_secrets_for_authenticated_user(keyword) :: {:ok, map} | {:error, GitHub.Error.t()}
  def list_secrets_for_authenticated_user(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [],
      call: {GitHub.Codespaces, :list_secrets_for_authenticated_user},
      url: "/user/codespaces/secrets",
      method: :get,
      query: query,
      response: [{200, :map}],
      opts: opts
    })
  end

  @doc """
  List selected repositories for an organization secret

  Lists all repositories that have been selected when the `visibility` for repository access to a secret is set to `selected`. You must authenticate using an access token with the `admin:org` scope to use this endpoint.

  ## Options

    * `page`: Page number of the results to fetch.
    * `per_page`: The number of results per page (max 100).

  ## Resources

    * [API method documentation](https://docs.github.com/rest/codespaces/organization-secrets#list-selected-repositories-for-an-organization-secret)

  """
  @spec list_selected_repos_for_org_secret(String.t(), String.t(), keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def list_selected_repos_for_org_secret(org, secret_name, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [org: org, secret_name: secret_name],
      call: {GitHub.Codespaces, :list_selected_repos_for_org_secret},
      url: "/orgs/#{org}/codespaces/secrets/#{secret_name}/repositories",
      method: :get,
      query: query,
      response: [{200, :map}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Get default attributes for a codespace

  Gets the default attributes for codespaces created by the user with the repository.

  You must authenticate using an access token with the `codespace` scope to use this endpoint.

  GitHub Apps must have write access to the `codespaces` repository permission to use this endpoint.

  ## Options

    * `ref`: The branch or commit to check for a default devcontainer path. If not specified, the default branch will be checked.
    * `client_ip`: An alternative IP for default location auto-detection, such as when proxying a request.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/codespaces/codespaces#get-default-attributes-for-a-codespace)

  """
  @spec pre_flight_with_repo_for_authenticated_user(String.t(), String.t(), keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def pre_flight_with_repo_for_authenticated_user(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:client_ip, :ref])

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Codespaces, :pre_flight_with_repo_for_authenticated_user},
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
  Create a repository from an unpublished codespace

  Publishes an unpublished codespace, creating a new repository and assigning it to the codespace.

  The codespace's token is granted write permissions to the repository, allowing the user to push their changes.

  This will fail for a codespace that is already published, meaning it has an associated repository.

  You must authenticate using a personal access token with the `codespace` scope to use this endpoint.

  GitHub Apps must have write access to the `codespaces` repository permission to use this endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/codespaces/codespaces#create-a-repository-from-an-unpublished-codespace)

  """
  @spec publish_for_authenticated_user(String.t(), map, keyword) ::
          {:ok, GitHub.Codespace.WithFullRepository.t()} | {:error, GitHub.Error.t()}
  def publish_for_authenticated_user(codespace_name, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [codespace_name: codespace_name, body: body],
      call: {GitHub.Codespaces, :publish_for_authenticated_user},
      url: "/user/codespaces/#{codespace_name}/publish",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {201, {GitHub.Codespace.WithFullRepository, :t}},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Remove a selected repository from a user secret

  Removes a repository from the selected repositories for a user's codespace secret.
  You must authenticate using an access token with the `codespace` or `codespace:secrets` scope to use this endpoint. User must have Codespaces access to use this endpoint.
  GitHub Apps must have write access to the `codespaces_user_secrets` user permission to use this endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/codespaces/secrets#remove-a-selected-repository-from-a-user-secret)

  """
  @spec remove_repository_for_secret_for_authenticated_user(String.t(), integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def remove_repository_for_secret_for_authenticated_user(secret_name, repository_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [secret_name: secret_name, repository_id: repository_id],
      call: {GitHub.Codespaces, :remove_repository_for_secret_for_authenticated_user},
      url: "/user/codespaces/secrets/#{secret_name}/repositories/#{repository_id}",
      method: :delete,
      response: [
        {204, :null},
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

  Removes a repository from an organization secret when the `visibility` for repository access is set to `selected`. The visibility is set when you [Create or update an organization secret](https://docs.github.com/rest/codespaces/organization-secrets#create-or-update-an-organization-secret). You must authenticate using an access token with the `admin:org` scope to use this endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/codespaces/organization-secrets#remove-selected-repository-from-an-organization-secret)

  """
  @spec remove_selected_repo_from_org_secret(String.t(), String.t(), integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def remove_selected_repo_from_org_secret(org, secret_name, repository_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, secret_name: secret_name, repository_id: repository_id],
      call: {GitHub.Codespaces, :remove_selected_repo_from_org_secret},
      url: "/orgs/#{org}/codespaces/secrets/#{secret_name}/repositories/#{repository_id}",
      method: :delete,
      response: [
        {204, :null},
        {404, {GitHub.BasicError, :t}},
        {409, :null},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List available machine types for a repository

  List the machine types available for a given repository based on its configuration.

  You must authenticate using an access token with the `codespace` scope to use this endpoint.

  GitHub Apps must have write access to the `codespaces_metadata` repository permission to use this endpoint.

  ## Options

    * `location`: The location to check for available machines. Assigned by IP if not provided.
    * `client_ip`: IP for location auto-detection when proxying a request
    * `ref`: The branch or commit to check for prebuild availability and devcontainer restrictions.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/codespaces/machines#list-available-machine-types-for-a-repository)

  """
  @spec repo_machines_for_authenticated_user(String.t(), String.t(), keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def repo_machines_for_authenticated_user(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:client_ip, :location, :ref])

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Codespaces, :repo_machines_for_authenticated_user},
      url: "/repos/#{owner}/#{repo}/codespaces/machines",
      method: :get,
      query: query,
      response: [
        {200, :map},
        {304, :null},
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

  Sets which users can access codespaces in an organization. This is synonymous with granting or revoking codespaces access permissions for users according to the visibility.
  You must authenticate using an access token with the `admin:org` scope to use this endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/codespaces/organizations#manage-access-control-for-organization-codespaces)

  """
  @spec set_codespaces_access(String.t(), map, keyword) :: :ok | {:error, GitHub.Error.t()}
  def set_codespaces_access(org, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, body: body],
      call: {GitHub.Codespaces, :set_codespaces_access},
      url: "/orgs/#{org}/codespaces/access",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [
        {204, :null},
        {304, :null},
        {400, :null},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Add users to Codespaces access for an organization

  Codespaces for the specified users will be billed to the organization.

  To use this endpoint, the access settings for the organization must be set to `selected_members`.
  For information on how to change this setting, see "[Manage access control for organization codespaces](https://docs.github.com/rest/codespaces/organizations#manage-access-control-for-organization-codespaces)."

  You must authenticate using an access token with the `admin:org` scope to use this endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/codespaces/organizations#add-users-to-codespaces-access-for-an-organization)

  """
  @spec set_codespaces_access_users(String.t(), map, keyword) :: :ok | {:error, GitHub.Error.t()}
  def set_codespaces_access_users(org, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, body: body],
      call: {GitHub.Codespaces, :set_codespaces_access_users},
      url: "/orgs/#{org}/codespaces/access/selected_users",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {204, :null},
        {304, :null},
        {400, :null},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Set selected repositories for a user secret

  Select the repositories that will use a user's codespace secret.

  You must authenticate using an access token with the `codespace` or `codespace:secrets` scope to use this endpoint. User must have Codespaces access to use this endpoint.

  GitHub Apps must have write access to the `codespaces_user_secrets` user permission and write access to the `codespaces_secrets` repository permission on all referenced repositories to use this endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/codespaces/secrets#set-selected-repositories-for-a-user-secret)

  """
  @spec set_repositories_for_secret_for_authenticated_user(String.t(), map, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def set_repositories_for_secret_for_authenticated_user(secret_name, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [secret_name: secret_name, body: body],
      call: {GitHub.Codespaces, :set_repositories_for_secret_for_authenticated_user},
      url: "/user/codespaces/secrets/#{secret_name}/repositories",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [
        {204, :null},
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

  Replaces all repositories for an organization secret when the `visibility` for repository access is set to `selected`. The visibility is set when you [Create or update an organization secret](https://docs.github.com/rest/codespaces/organization-secrets#create-or-update-an-organization-secret). You must authenticate using an access token with the `admin:org` scope to use this endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/codespaces/organization-secrets#set-selected-repositories-for-an-organization-secret)

  """
  @spec set_selected_repos_for_org_secret(String.t(), String.t(), map, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def set_selected_repos_for_org_secret(org, secret_name, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, secret_name: secret_name, body: body],
      call: {GitHub.Codespaces, :set_selected_repos_for_org_secret},
      url: "/orgs/#{org}/codespaces/secrets/#{secret_name}/repositories",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [{204, :null}, {404, {GitHub.BasicError, :t}}, {409, :null}],
      opts: opts
    })
  end

  @doc """
  Start a codespace for the authenticated user

  Starts a user's codespace.

  You must authenticate using an access token with the `codespace` scope to use this endpoint.

  GitHub Apps must have write access to the `codespaces_lifecycle_admin` repository permission to use this endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/codespaces/codespaces#start-a-codespace-for-the-authenticated-user)

  """
  @spec start_for_authenticated_user(String.t(), keyword) ::
          {:ok, GitHub.Codespace.t()} | {:error, GitHub.Error.t()}
  def start_for_authenticated_user(codespace_name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [codespace_name: codespace_name],
      call: {GitHub.Codespaces, :start_for_authenticated_user},
      url: "/user/codespaces/#{codespace_name}/start",
      method: :post,
      response: [
        {200, {GitHub.Codespace, :t}},
        {304, :null},
        {400, {:union, [{GitHub.BasicError, :t}, {GitHub.SCIM.Error, :t}]}},
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

  Stops a user's codespace.

  You must authenticate using an access token with the `codespace` scope to use this endpoint.

  GitHub Apps must have write access to the `codespaces_lifecycle_admin` repository permission to use this endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/codespaces/codespaces#stop-a-codespace-for-the-authenticated-user)

  """
  @spec stop_for_authenticated_user(String.t(), keyword) ::
          {:ok, GitHub.Codespace.t()} | {:error, GitHub.Error.t()}
  def stop_for_authenticated_user(codespace_name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [codespace_name: codespace_name],
      call: {GitHub.Codespaces, :stop_for_authenticated_user},
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

  Stops a user's codespace.

  You must authenticate using an access token with the `admin:org` scope to use this endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/codespaces/organizations#stop-a-codespace-for-an-organization-user)

  """
  @spec stop_in_organization(String.t(), String.t(), String.t(), keyword) ::
          {:ok, GitHub.Codespace.t()} | {:error, GitHub.Error.t()}
  def stop_in_organization(org, username, codespace_name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, username: username, codespace_name: codespace_name],
      call: {GitHub.Codespaces, :stop_in_organization},
      url: "/orgs/#{org}/members/#{username}/codespaces/#{codespace_name}/stop",
      method: :post,
      response: [
        {200, {GitHub.Codespace, :t}},
        {304, :null},
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

  Updates a codespace owned by the authenticated user. Currently only the codespace's machine type and recent folders can be modified using this endpoint.

  If you specify a new machine type it will be applied the next time your codespace is started.

  You must authenticate using an access token with the `codespace` scope to use this endpoint.

  GitHub Apps must have write access to the `codespaces` repository permission to use this endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/codespaces/codespaces#update-a-codespace-for-the-authenticated-user)

  """
  @spec update_for_authenticated_user(String.t(), map, keyword) ::
          {:ok, GitHub.Codespace.t()} | {:error, GitHub.Error.t()}
  def update_for_authenticated_user(codespace_name, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [codespace_name: codespace_name, body: body],
      call: {GitHub.Codespaces, :update_for_authenticated_user},
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
