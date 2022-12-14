defmodule GitHub.Dependabot do
  @moduledoc """
  Provides API endpoints related to dependabot
  """

  @default_client GitHub.Client

  @doc """
  Add selected repository to an organization secret

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/dependabot#add-selected-repository-to-an-organization-secret)

  """
  @spec add_selected_repo_to_org_secret(String.t(), String.t(), integer, keyword) :: :ok | :error
  def add_selected_repo_to_org_secret(org, secret_name, repository_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/orgs/#{org}/dependabot/secrets/#{secret_name}/repositories/#{repository_id}",
      method: :put,
      response: [{204, nil}, {409, nil}],
      opts: opts
    })
  end

  @doc """
  Create or update an organization secret

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/dependabot#create-or-update-an-organization-secret)

  """
  @spec create_or_update_org_secret(String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.EmptyObject.t()} | :error
  def create_or_update_org_secret(org, secret_name, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/orgs/#{org}/dependabot/secrets/#{secret_name}",
      body: body,
      method: :put,
      response: [{201, {GitHub.EmptyObject, :t}}, {204, nil}],
      opts: opts
    })
  end

  @doc """
  Create or update a repository secret

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/dependabot#create-or-update-a-repository-secret)

  """
  @spec create_or_update_repo_secret(String.t(), String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.EmptyObject.t()} | :error
  def create_or_update_repo_secret(owner, repo, secret_name, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/repos/#{owner}/#{repo}/dependabot/secrets/#{secret_name}",
      body: body,
      method: :put,
      response: [{201, {GitHub.EmptyObject, :t}}, {204, nil}],
      opts: opts
    })
  end

  @doc """
  Delete an organization secret

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/dependabot#delete-an-organization-secret)

  """
  @spec delete_org_secret(String.t(), String.t(), keyword) :: :ok | :error
  def delete_org_secret(org, secret_name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/orgs/#{org}/dependabot/secrets/#{secret_name}",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Delete a repository secret

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/dependabot#delete-a-repository-secret)

  """
  @spec delete_repo_secret(String.t(), String.t(), String.t(), keyword) :: :ok | :error
  def delete_repo_secret(owner, repo, secret_name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/repos/#{owner}/#{repo}/dependabot/secrets/#{secret_name}",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Get a Dependabot alert

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/dependabot#get-a-dependabot-alert)

  """
  @spec get_alert(String.t(), String.t(), integer, keyword) ::
          {:ok, GitHub.Dependabot.Alert.t()} | {:error, GitHub.BasicError.t()}
  def get_alert(owner, repo, alert_number, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/repos/#{owner}/#{repo}/dependabot/alerts/#{alert_number}",
      method: :get,
      response: [
        {200, {GitHub.Dependabot.Alert, :t}},
        {304, nil},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get an organization public key

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/dependabot#get-an-organization-public-key)

  """
  @spec get_org_public_key(String.t(), keyword) :: {:ok, GitHub.Dependabot.PublicKey.t()} | :error
  def get_org_public_key(org, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/orgs/#{org}/dependabot/secrets/public-key",
      method: :get,
      response: [{200, {GitHub.Dependabot.PublicKey, :t}}],
      opts: opts
    })
  end

  @doc """
  Get an organization secret

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/dependabot#get-an-organization-secret)

  """
  @spec get_org_secret(String.t(), String.t(), keyword) ::
          {:ok, GitHub.Organization.DependabotSecret.t()} | :error
  def get_org_secret(org, secret_name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/orgs/#{org}/dependabot/secrets/#{secret_name}",
      method: :get,
      response: [{200, {GitHub.Organization.DependabotSecret, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a repository public key

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/dependabot#get-a-repository-public-key)

  """
  @spec get_repo_public_key(String.t(), String.t(), keyword) ::
          {:ok, GitHub.Dependabot.PublicKey.t()} | :error
  def get_repo_public_key(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/repos/#{owner}/#{repo}/dependabot/secrets/public-key",
      method: :get,
      response: [{200, {GitHub.Dependabot.PublicKey, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a repository secret

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/dependabot#get-a-repository-secret)

  """
  @spec get_repo_secret(String.t(), String.t(), String.t(), keyword) ::
          {:ok, GitHub.Dependabot.Secret.t()} | :error
  def get_repo_secret(owner, repo, secret_name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/repos/#{owner}/#{repo}/dependabot/secrets/#{secret_name}",
      method: :get,
      response: [{200, {GitHub.Dependabot.Secret, :t}}],
      opts: opts
    })
  end

  @doc """
  List Dependabot alerts for an enterprise

  ## Options

    * `state` (String.t()): A comma-separated list of states. If specified, only alerts with these states will be returned.

  Can be: `dismissed`, `fixed`, `open`
    * `severity` (String.t()): A comma-separated list of severities. If specified, only alerts with these severities will be returned.

  Can be: `low`, `medium`, `high`, `critical`
    * `ecosystem` (String.t()): A comma-separated list of ecosystems. If specified, only alerts for these ecosystems will be returned.

  Can be: `composer`, `go`, `maven`, `npm`, `nuget`, `pip`, `pub`, `rubygems`, `rust`
    * `package` (String.t()): A comma-separated list of package names. If specified, only alerts for these packages will be returned.
    * `scope` (String.t()): The scope of the vulnerable dependency. If specified, only alerts with this scope will be returned.
    * `sort` (String.t()): The property by which to sort the results.
  `created` means when the alert was created.
  `updated` means when the alert's state last changed.
    * `direction` (String.t()): The direction to sort the results by.
    * `before` (String.t()): A cursor, as given in the [Link header](https://docs.github.com/rest/overview/resources-in-the-rest-api#link-header). If specified, the query only searches for results before this cursor.
    * `after` (String.t()): A cursor, as given in the [Link header](https://docs.github.com/rest/overview/resources-in-the-rest-api#link-header). If specified, the query only searches for results after this cursor.
    * `first` (integer): **Deprecated**. The number of results per page (max 100), starting from the first matching result.
  This parameter must not be used in combination with `last`.
  Instead, use `per_page` in combination with `after` to fetch the first page of results.
    * `last` (integer): **Deprecated**. The number of results per page (max 100), starting from the last matching result.
  This parameter must not be used in combination with `first`.
  Instead, use `per_page` in combination with `before` to fetch the last page of results.
    * `per_page` (integer): The number of results per page (max 100).

  ## Resources

    * [API method documentation](https://docs.github.com/rest/dependabot/alerts#list-dependabot-alerts-for-an-enterprise)

  """
  @spec list_alerts_for_enterprise(String.t(), keyword) ::
          {:ok, [GitHub.Dependabot.Alert.WithRepository.t()]}
          | {:error, GitHub.BasicError.t() | GitHub.ValidationError.simple()}
  def list_alerts_for_enterprise(enterprise, opts \\ []) do
    client = opts[:client] || @default_client

    query =
      Keyword.take(opts, [
        :after,
        :before,
        :direction,
        :ecosystem,
        :first,
        :last,
        :package,
        :per_page,
        :scope,
        :severity,
        :sort,
        :state
      ])

    client.request(%{
      url: "/enterprises/#{enterprise}/dependabot/alerts",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.Dependabot.Alert.WithRepository, :t}}},
        {304, nil},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :simple}}
      ],
      opts: opts
    })
  end

  @doc """
  List Dependabot alerts for an organization

  ## Options

    * `state` (String.t()): A comma-separated list of states. If specified, only alerts with these states will be returned.

  Can be: `dismissed`, `fixed`, `open`
    * `severity` (String.t()): A comma-separated list of severities. If specified, only alerts with these severities will be returned.

  Can be: `low`, `medium`, `high`, `critical`
    * `ecosystem` (String.t()): A comma-separated list of ecosystems. If specified, only alerts for these ecosystems will be returned.

  Can be: `composer`, `go`, `maven`, `npm`, `nuget`, `pip`, `pub`, `rubygems`, `rust`
    * `package` (String.t()): A comma-separated list of package names. If specified, only alerts for these packages will be returned.
    * `scope` (String.t()): The scope of the vulnerable dependency. If specified, only alerts with this scope will be returned.
    * `sort` (String.t()): The property by which to sort the results.
  `created` means when the alert was created.
  `updated` means when the alert's state last changed.
    * `direction` (String.t()): The direction to sort the results by.
    * `before` (String.t()): A cursor, as given in the [Link header](https://docs.github.com/rest/overview/resources-in-the-rest-api#link-header). If specified, the query only searches for results before this cursor.
    * `after` (String.t()): A cursor, as given in the [Link header](https://docs.github.com/rest/overview/resources-in-the-rest-api#link-header). If specified, the query only searches for results after this cursor.
    * `first` (integer): **Deprecated**. The number of results per page (max 100), starting from the first matching result.
  This parameter must not be used in combination with `last`.
  Instead, use `per_page` in combination with `after` to fetch the first page of results.
    * `last` (integer): **Deprecated**. The number of results per page (max 100), starting from the last matching result.
  This parameter must not be used in combination with `first`.
  Instead, use `per_page` in combination with `before` to fetch the last page of results.
    * `per_page` (integer): The number of results per page (max 100).

  ## Resources

    * [API method documentation](https://docs.github.com/rest/dependabot/alerts#list-dependabot-alerts-for-an-organization)

  """
  @spec list_alerts_for_org(String.t(), keyword) ::
          {:ok, [GitHub.Dependabot.Alert.WithRepository.t()]}
          | {:error, GitHub.BasicError.t() | GitHub.ValidationError.simple()}
  def list_alerts_for_org(org, opts \\ []) do
    client = opts[:client] || @default_client

    query =
      Keyword.take(opts, [
        :after,
        :before,
        :direction,
        :ecosystem,
        :first,
        :last,
        :package,
        :per_page,
        :scope,
        :severity,
        :sort,
        :state
      ])

    client.request(%{
      url: "/orgs/#{org}/dependabot/alerts",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.Dependabot.Alert.WithRepository, :t}}},
        {304, nil},
        {400, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :simple}}
      ],
      opts: opts
    })
  end

  @doc """
  List Dependabot alerts for a repository

  ## Options

    * `state` (String.t()): A comma-separated list of states. If specified, only alerts with these states will be returned.

  Can be: `dismissed`, `fixed`, `open`
    * `severity` (String.t()): A comma-separated list of severities. If specified, only alerts with these severities will be returned.

  Can be: `low`, `medium`, `high`, `critical`
    * `ecosystem` (String.t()): A comma-separated list of ecosystems. If specified, only alerts for these ecosystems will be returned.

  Can be: `composer`, `go`, `maven`, `npm`, `nuget`, `pip`, `pub`, `rubygems`, `rust`
    * `package` (String.t()): A comma-separated list of package names. If specified, only alerts for these packages will be returned.
    * `manifest` (String.t()): A comma-separated list of full manifest paths. If specified, only alerts for these manifests will be returned.
    * `scope` (String.t()): The scope of the vulnerable dependency. If specified, only alerts with this scope will be returned.
    * `sort` (String.t()): The property by which to sort the results.
  `created` means when the alert was created.
  `updated` means when the alert's state last changed.
    * `direction` (String.t()): The direction to sort the results by.
    * `page` (integer): **Deprecated**. Page number of the results to fetch. Use cursor-based pagination with `before` or `after` instead.
    * `per_page` (integer): The number of results per page (max 100).
    * `before` (String.t()): A cursor, as given in the [Link header](https://docs.github.com/rest/overview/resources-in-the-rest-api#link-header). If specified, the query only searches for results before this cursor.
    * `after` (String.t()): A cursor, as given in the [Link header](https://docs.github.com/rest/overview/resources-in-the-rest-api#link-header). If specified, the query only searches for results after this cursor.
    * `first` (integer): **Deprecated**. The number of results per page (max 100), starting from the first matching result.
  This parameter must not be used in combination with `last`.
  Instead, use `per_page` in combination with `after` to fetch the first page of results.
    * `last` (integer): **Deprecated**. The number of results per page (max 100), starting from the last matching result.
  This parameter must not be used in combination with `first`.
  Instead, use `per_page` in combination with `before` to fetch the last page of results.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/dependabot#list-dependabot-alerts-for-a-repository)

  """
  @spec list_alerts_for_repo(String.t(), String.t(), keyword) ::
          {:ok, [GitHub.Dependabot.Alert.t()]}
          | {:error, GitHub.BasicError.t() | GitHub.ValidationError.simple()}
  def list_alerts_for_repo(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    query =
      Keyword.take(opts, [
        :after,
        :before,
        :direction,
        :ecosystem,
        :first,
        :last,
        :manifest,
        :package,
        :page,
        :per_page,
        :scope,
        :severity,
        :sort,
        :state
      ])

    client.request(%{
      url: "/repos/#{owner}/#{repo}/dependabot/alerts",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.Dependabot.Alert, :t}}},
        {304, nil},
        {400, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :simple}}
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

    * [API method documentation](https://docs.github.com/rest/reference/dependabot#list-organization-secrets)

  """
  @spec list_org_secrets(String.t(), keyword) :: {:ok, map} | :error
  def list_org_secrets(org, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      url: "/orgs/#{org}/dependabot/secrets",
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

    * [API method documentation](https://docs.github.com/rest/reference/dependabot#list-repository-secrets)

  """
  @spec list_repo_secrets(String.t(), String.t(), keyword) :: {:ok, map} | :error
  def list_repo_secrets(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      url: "/repos/#{owner}/#{repo}/dependabot/secrets",
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

    * [API method documentation](https://docs.github.com/rest/reference/dependabot#list-selected-repositories-for-an-organization-secret)

  """
  @spec list_selected_repos_for_org_secret(String.t(), String.t(), keyword) :: {:ok, map} | :error
  def list_selected_repos_for_org_secret(org, secret_name, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      url: "/orgs/#{org}/dependabot/secrets/#{secret_name}/repositories",
      method: :get,
      query: query,
      response: [{200, :map}],
      opts: opts
    })
  end

  @doc """
  Remove selected repository from an organization secret

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/dependabot#remove-selected-repository-from-an-organization-secret)

  """
  @spec remove_selected_repo_from_org_secret(String.t(), String.t(), integer, keyword) ::
          :ok | :error
  def remove_selected_repo_from_org_secret(org, secret_name, repository_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/orgs/#{org}/dependabot/secrets/#{secret_name}/repositories/#{repository_id}",
      method: :delete,
      response: [{204, nil}, {409, nil}],
      opts: opts
    })
  end

  @doc """
  Set selected repositories for an organization secret

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/dependabot#set-selected-repositories-for-an-organization-secret)

  """
  @spec set_selected_repos_for_org_secret(String.t(), String.t(), map, keyword) :: :ok | :error
  def set_selected_repos_for_org_secret(org, secret_name, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/orgs/#{org}/dependabot/secrets/#{secret_name}/repositories",
      body: body,
      method: :put,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Update a Dependabot alert

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/dependabot#update-a-dependabot-alert)

  """
  @spec update_alert(String.t(), String.t(), integer, map, keyword) ::
          {:ok, GitHub.Dependabot.Alert.t()}
          | {:error, GitHub.BasicError.t() | GitHub.ValidationError.simple()}
  def update_alert(owner, repo, alert_number, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/repos/#{owner}/#{repo}/dependabot/alerts/#{alert_number}",
      body: body,
      method: :patch,
      response: [
        {200, {GitHub.Dependabot.Alert, :t}},
        {400, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {409, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :simple}}
      ],
      opts: opts
    })
  end
end
