defmodule GitHub.SecretScanning do
  @moduledoc """
  Provides API endpoints related to secret scanning
  """

  @default_client GitHub.Client

  @doc """
  Get a secret scanning alert

  Gets a single secret scanning alert detected in an eligible repository.
  To use this endpoint, you must be an administrator for the repository or for the organization that owns the repository, and you must use a personal access token with the `repo` scope or `security_events` scope.
  For public repositories, you may instead use the `public_repo` scope.

  GitHub Apps must have the `secret_scanning_alerts` read permission to use this endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/secret-scanning/secret-scanning#get-a-secret-scanning-alert)

  """
  @spec get_alert(String.t(), String.t(), integer, keyword) ::
          {:ok, GitHub.SecretScanning.Alert.t()} | {:error, GitHub.Error.t()}
  def get_alert(owner, repo, alert_number, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, alert_number: alert_number],
      call: {GitHub.SecretScanning, :get_alert},
      url: "/repos/#{owner}/#{repo}/secret-scanning/alerts/#{alert_number}",
      method: :get,
      response: [
        {200, {GitHub.SecretScanning.Alert, :t}},
        {304, :null},
        {404, :null},
        {503, :map}
      ],
      opts: opts
    })
  end

  @doc """
  List secret scanning alerts for an enterprise

  Lists secret scanning alerts for eligible repositories in an enterprise, from newest to oldest.
  To use this endpoint, you must be a member of the enterprise, and you must use an access token with the `repo` scope or `security_events` scope. Alerts are only returned for organizations in the enterprise for which you are an organization owner or a [security manager](https://docs.github.com/organizations/managing-peoples-access-to-your-organization-with-roles/managing-security-managers-in-your-organization).

  ## Options

    * `state`: Set to `open` or `resolved` to only list secret scanning alerts in a specific state.
    * `secret_type`: A comma-separated list of secret types to return. By default all secret types are returned.
      See "[Secret scanning patterns](https://docs.github.com/code-security/secret-scanning/secret-scanning-patterns#supported-secrets-for-advanced-security)"
      for a complete list of secret types.
    * `resolution`: A comma-separated list of resolutions. Only secret scanning alerts with one of these resolutions are listed. Valid resolutions are `false_positive`, `wont_fix`, `revoked`, `pattern_edited`, `pattern_deleted` or `used_in_tests`.
    * `sort`: The property to sort the results by. `created` means when the alert was created. `updated` means when the alert was updated or resolved.
    * `direction`: The direction to sort the results by.
    * `per_page`: The number of results per page (max 100).
    * `before`: A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for results before this cursor.
    * `after`: A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for results after this cursor.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/secret-scanning/secret-scanning#list-secret-scanning-alerts-for-an-enterprise)

  """
  @spec list_alerts_for_enterprise(String.t(), keyword) ::
          {:ok, [GitHub.Organization.SecretScanningAlert.t()]} | {:error, GitHub.Error.t()}
  def list_alerts_for_enterprise(enterprise, opts \\ []) do
    client = opts[:client] || @default_client

    query =
      Keyword.take(opts, [
        :after,
        :before,
        :direction,
        :per_page,
        :resolution,
        :secret_type,
        :sort,
        :state
      ])

    client.request(%{
      args: [enterprise: enterprise],
      call: {GitHub.SecretScanning, :list_alerts_for_enterprise},
      url: "/enterprises/#{enterprise}/secret-scanning/alerts",
      method: :get,
      query: query,
      response: [
        {200, [{GitHub.Organization.SecretScanningAlert, :t}]},
        {404, {GitHub.BasicError, :t}},
        {503, :map}
      ],
      opts: opts
    })
  end

  @doc """
  List secret scanning alerts for an organization

  Lists secret scanning alerts for eligible repositories in an organization, from newest to oldest.
  To use this endpoint, you must be an administrator or security manager for the organization, and you must use an access token with the `repo` scope or `security_events` scope.
  For public repositories, you may instead use the `public_repo` scope.

  GitHub Apps must have the `secret_scanning_alerts` read permission to use this endpoint.

  ## Options

    * `state`: Set to `open` or `resolved` to only list secret scanning alerts in a specific state.
    * `secret_type`: A comma-separated list of secret types to return. By default all secret types are returned.
      See "[Secret scanning patterns](https://docs.github.com/code-security/secret-scanning/secret-scanning-patterns#supported-secrets-for-advanced-security)"
      for a complete list of secret types.
    * `resolution`: A comma-separated list of resolutions. Only secret scanning alerts with one of these resolutions are listed. Valid resolutions are `false_positive`, `wont_fix`, `revoked`, `pattern_edited`, `pattern_deleted` or `used_in_tests`.
    * `sort`: The property to sort the results by. `created` means when the alert was created. `updated` means when the alert was updated or resolved.
    * `direction`: The direction to sort the results by.
    * `page`: Page number of the results to fetch.
    * `per_page`: The number of results per page (max 100).
    * `before`: A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for events before this cursor. To receive an initial cursor on your first request, include an empty "before" query string.
    * `after`: A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for events after this cursor.  To receive an initial cursor on your first request, include an empty "after" query string.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/secret-scanning/secret-scanning#list-secret-scanning-alerts-for-an-organization)

  """
  @spec list_alerts_for_org(String.t(), keyword) ::
          {:ok, [GitHub.Organization.SecretScanningAlert.t()]} | {:error, GitHub.Error.t()}
  def list_alerts_for_org(org, opts \\ []) do
    client = opts[:client] || @default_client

    query =
      Keyword.take(opts, [
        :after,
        :before,
        :direction,
        :page,
        :per_page,
        :resolution,
        :secret_type,
        :sort,
        :state
      ])

    client.request(%{
      args: [org: org],
      call: {GitHub.SecretScanning, :list_alerts_for_org},
      url: "/orgs/#{org}/secret-scanning/alerts",
      method: :get,
      query: query,
      response: [
        {200, [{GitHub.Organization.SecretScanningAlert, :t}]},
        {404, {GitHub.BasicError, :t}},
        {503, :map}
      ],
      opts: opts
    })
  end

  @doc """
  List secret scanning alerts for a repository

  Lists secret scanning alerts for an eligible repository, from newest to oldest.
  To use this endpoint, you must be an administrator for the repository or for the organization that owns the repository, and you must use a personal access token with the `repo` scope or `security_events` scope.
  For public repositories, you may instead use the `public_repo` scope.

  GitHub Apps must have the `secret_scanning_alerts` read permission to use this endpoint.

  ## Options

    * `state`: Set to `open` or `resolved` to only list secret scanning alerts in a specific state.
    * `secret_type`: A comma-separated list of secret types to return. By default all secret types are returned.
      See "[Secret scanning patterns](https://docs.github.com/code-security/secret-scanning/secret-scanning-patterns#supported-secrets-for-advanced-security)"
      for a complete list of secret types.
    * `resolution`: A comma-separated list of resolutions. Only secret scanning alerts with one of these resolutions are listed. Valid resolutions are `false_positive`, `wont_fix`, `revoked`, `pattern_edited`, `pattern_deleted` or `used_in_tests`.
    * `sort`: The property to sort the results by. `created` means when the alert was created. `updated` means when the alert was updated or resolved.
    * `direction`: The direction to sort the results by.
    * `page`: Page number of the results to fetch.
    * `per_page`: The number of results per page (max 100).
    * `before`: A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for events before this cursor. To receive an initial cursor on your first request, include an empty "before" query string.
    * `after`: A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for events after this cursor.  To receive an initial cursor on your first request, include an empty "after" query string.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/secret-scanning/secret-scanning#list-secret-scanning-alerts-for-a-repository)

  """
  @spec list_alerts_for_repo(String.t(), String.t(), keyword) ::
          {:ok, [GitHub.SecretScanning.Alert.t()]} | {:error, GitHub.Error.t()}
  def list_alerts_for_repo(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    query =
      Keyword.take(opts, [
        :after,
        :before,
        :direction,
        :page,
        :per_page,
        :resolution,
        :secret_type,
        :sort,
        :state
      ])

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.SecretScanning, :list_alerts_for_repo},
      url: "/repos/#{owner}/#{repo}/secret-scanning/alerts",
      method: :get,
      query: query,
      response: [{200, [{GitHub.SecretScanning.Alert, :t}]}, {404, :null}, {503, :map}],
      opts: opts
    })
  end

  @doc """
  List locations for a secret scanning alert

  Lists all locations for a given secret scanning alert for an eligible repository.
  To use this endpoint, you must be an administrator for the repository or for the organization that owns the repository, and you must use a personal access token with the `repo` scope or `security_events` scope.
  For public repositories, you may instead use the `public_repo` scope.

  GitHub Apps must have the `secret_scanning_alerts` read permission to use this endpoint.

  ## Options

    * `page`: Page number of the results to fetch.
    * `per_page`: The number of results per page (max 100).

  ## Resources

    * [API method documentation](https://docs.github.com/rest/secret-scanning/secret-scanning#list-locations-for-a-secret-scanning-alert)

  """
  @spec list_locations_for_alert(String.t(), String.t(), integer, keyword) ::
          {:ok, [GitHub.SecretScanning.Location.t()]} | {:error, GitHub.Error.t()}
  def list_locations_for_alert(owner, repo, alert_number, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [owner: owner, repo: repo, alert_number: alert_number],
      call: {GitHub.SecretScanning, :list_locations_for_alert},
      url: "/repos/#{owner}/#{repo}/secret-scanning/alerts/#{alert_number}/locations",
      method: :get,
      query: query,
      response: [{200, [{GitHub.SecretScanning.Location, :t}]}, {404, :null}, {503, :map}],
      opts: opts
    })
  end

  @doc """
  Update a secret scanning alert

  Updates the status of a secret scanning alert in an eligible repository.
  To use this endpoint, you must be an administrator for the repository or for the organization that owns the repository, and you must use a personal access token with the `repo` scope or `security_events` scope.
  For public repositories, you may instead use the `public_repo` scope.

  GitHub Apps must have the `secret_scanning_alerts` write permission to use this endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/secret-scanning/secret-scanning#update-a-secret-scanning-alert)

  """
  @spec update_alert(String.t(), String.t(), integer, map, keyword) ::
          {:ok, GitHub.SecretScanning.Alert.t()} | {:error, GitHub.Error.t()}
  def update_alert(owner, repo, alert_number, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, alert_number: alert_number, body: body],
      call: {GitHub.SecretScanning, :update_alert},
      url: "/repos/#{owner}/#{repo}/secret-scanning/alerts/#{alert_number}",
      body: body,
      method: :patch,
      request: [{"application/json", :map}],
      response: [
        {200, {GitHub.SecretScanning.Alert, :t}},
        {400, :null},
        {404, :null},
        {422, :null},
        {503, :map}
      ],
      opts: opts
    })
  end
end
