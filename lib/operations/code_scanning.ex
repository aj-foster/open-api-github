defmodule GitHub.CodeScanning do
  @moduledoc """
  Provides API endpoints related to code scanning
  """

  @default_client GitHub.Client

  @doc """
  Delete a code scanning analysis from a repository

  ## Options

    * `confirm_delete` (String.t() | nil): Allow deletion if the specified analysis is the last in a set. If you attempt to delete the final analysis in a set without setting this parameter to `true`, you'll get a 400 response with the message: `Analysis is last of its type and deletion may result in the loss of historical alert data. Please specify confirm_delete.`

  ## Resources

    * [API method documentation](https://docs.github.com/rest/code-scanning/code-scanning#delete-a-code-scanning-analysis-from-a-repository)

  """
  @spec delete_analysis(String.t(), String.t(), integer, keyword) ::
          {:ok, GitHub.CodeScanning.AnalysisDeletion.t()} | {:error, GitHub.Error.t()}
  def delete_analysis(owner, repo, analysis_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:confirm_delete])

    client.request(%{
      args: [owner: owner, repo: repo, analysis_id: analysis_id],
      call: {GitHub.CodeScanning, :delete_analysis},
      url: "/repos/#{owner}/#{repo}/code-scanning/analyses/#{analysis_id}",
      method: :delete,
      query: query,
      response: [
        {200, {GitHub.CodeScanning.AnalysisDeletion, :t}},
        {400, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {503, :map}
      ],
      opts: opts
    })
  end

  @doc """
  Get a code scanning alert

  ## Resources

    * [API method documentation](https://docs.github.com/rest/code-scanning/code-scanning#get-a-code-scanning-alert)

  """
  @spec get_alert(String.t(), String.t(), integer, keyword) ::
          {:ok, GitHub.CodeScanning.Alert.t()} | {:error, GitHub.Error.t()}
  def get_alert(owner, repo, alert_number, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, alert_number: alert_number],
      call: {GitHub.CodeScanning, :get_alert},
      url: "/repos/#{owner}/#{repo}/code-scanning/alerts/#{alert_number}",
      method: :get,
      response: [
        {200, {GitHub.CodeScanning.Alert, :t}},
        {304, nil},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {503, :map}
      ],
      opts: opts
    })
  end

  @doc """
  Get a code scanning analysis for a repository

  ## Resources

    * [API method documentation](https://docs.github.com/rest/code-scanning/code-scanning#get-a-code-scanning-analysis-for-a-repository)

  """
  @spec get_analysis(String.t(), String.t(), integer, keyword) ::
          {:ok, GitHub.CodeScanning.Analysis.t()} | {:error, GitHub.Error.t()}
  def get_analysis(owner, repo, analysis_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, analysis_id: analysis_id],
      call: {GitHub.CodeScanning, :get_analysis},
      url: "/repos/#{owner}/#{repo}/code-scanning/analyses/#{analysis_id}",
      method: :get,
      response: [
        {200, {GitHub.CodeScanning.Analysis, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {503, :map}
      ],
      opts: opts
    })
  end

  @doc """
  Get a CodeQL database for a repository

  ## Resources

    * [API method documentation](https://docs.github.com/rest/code-scanning/code-scanning#get-a-codeql-database-for-a-repository)

  """
  @spec get_codeql_database(String.t(), String.t(), String.t(), keyword) ::
          {:ok, GitHub.CodeScanning.CodeqlDatabase.t()} | {:error, GitHub.Error.t()}
  def get_codeql_database(owner, repo, language, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, language: language],
      call: {GitHub.CodeScanning, :get_codeql_database},
      url: "/repos/#{owner}/#{repo}/code-scanning/codeql/databases/#{language}",
      method: :get,
      response: [
        {200, {GitHub.CodeScanning.CodeqlDatabase, :t}},
        {302, nil},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {503, :map}
      ],
      opts: opts
    })
  end

  @doc """
  Get a code scanning default setup configuration

  ## Resources

    * [API method documentation](https://docs.github.com/rest/code-scanning/code-scanning#get-a-code-scanning-default-setup-configuration)

  """
  @spec get_default_setup(String.t(), String.t(), keyword) ::
          {:ok, GitHub.CodeScanning.DefaultSetup.t()} | {:error, GitHub.Error.t()}
  def get_default_setup(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.CodeScanning, :get_default_setup},
      url: "/repos/#{owner}/#{repo}/code-scanning/default-setup",
      method: :get,
      response: [
        {200, {GitHub.CodeScanning.DefaultSetup, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {503, :map}
      ],
      opts: opts
    })
  end

  @doc """
  Get information about a SARIF upload

  ## Resources

    * [API method documentation](https://docs.github.com/rest/code-scanning/code-scanning#get-information-about-a-sarif-upload)

  """
  @spec get_sarif(String.t(), String.t(), String.t(), keyword) ::
          {:ok, GitHub.CodeScanning.SarifsStatus.t()} | {:error, GitHub.Error.t()}
  def get_sarif(owner, repo, sarif_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, sarif_id: sarif_id],
      call: {GitHub.CodeScanning, :get_sarif},
      url: "/repos/#{owner}/#{repo}/code-scanning/sarifs/#{sarif_id}",
      method: :get,
      response: [
        {200, {GitHub.CodeScanning.SarifsStatus, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, nil},
        {503, :map}
      ],
      opts: opts
    })
  end

  @doc """
  List instances of a code scanning alert

  ## Options

    * `page` (integer): Page number of the results to fetch.
    * `per_page` (integer): The number of results per page (max 100).
    * `ref` (String.t()): The Git reference for the results you want to list. The `ref` for a branch can be formatted either as `refs/heads/<branch name>` or simply `<branch name>`. To reference a pull request use `refs/pull/<number>/merge`.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/code-scanning/code-scanning#list-instances-of-a-code-scanning-alert)

  """
  @spec list_alert_instances(String.t(), String.t(), integer, keyword) ::
          {:ok, [GitHub.CodeScanning.AlertInstance.t()]} | {:error, GitHub.Error.t()}
  def list_alert_instances(owner, repo, alert_number, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page, :ref])

    client.request(%{
      args: [owner: owner, repo: repo, alert_number: alert_number],
      call: {GitHub.CodeScanning, :list_alert_instances},
      url: "/repos/#{owner}/#{repo}/code-scanning/alerts/#{alert_number}/instances",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.CodeScanning.AlertInstance, :t}}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {503, :map}
      ],
      opts: opts
    })
  end

  @doc """
  List code scanning alerts for an organization

  ## Options

    * `tool_name` (String.t()): The name of a code scanning tool. Only results by this tool will be listed. You can specify the tool by using either `tool_name` or `tool_guid`, but not both.
    * `tool_guid` (String.t() | nil): The GUID of a code scanning tool. Only results by this tool will be listed. Note that some code scanning tools may not include a GUID in their analysis data. You can specify the tool by using either `tool_guid` or `tool_name`, but not both.
    * `before` (String.t()): A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for results before this cursor.
    * `after` (String.t()): A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for results after this cursor.
    * `page` (integer): Page number of the results to fetch.
    * `per_page` (integer): The number of results per page (max 100).
    * `direction` (String.t()): The direction to sort the results by.
    * `state` (String.t()): If specified, only code scanning alerts with this state will be returned.
    * `sort` (String.t()): The property by which to sort the results.
    * `severity` (String.t()): If specified, only code scanning alerts with this severity will be returned.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/code-scanning/code-scanning#list-code-scanning-alerts-for-an-organization)

  """
  @spec list_alerts_for_org(String.t(), keyword) ::
          {:ok, [GitHub.CodeScanning.OrganizationAlertItems.t()]} | {:error, GitHub.Error.t()}
  def list_alerts_for_org(org, opts \\ []) do
    client = opts[:client] || @default_client

    query =
      Keyword.take(opts, [
        :after,
        :before,
        :direction,
        :page,
        :per_page,
        :severity,
        :sort,
        :state,
        :tool_guid,
        :tool_name
      ])

    client.request(%{
      args: [org: org],
      call: {GitHub.CodeScanning, :list_alerts_for_org},
      url: "/orgs/#{org}/code-scanning/alerts",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.CodeScanning.OrganizationAlertItems, :t}}},
        {404, {GitHub.BasicError, :t}},
        {503, :map}
      ],
      opts: opts
    })
  end

  @doc """
  List code scanning alerts for a repository

  ## Options

    * `tool_name` (String.t()): The name of a code scanning tool. Only results by this tool will be listed. You can specify the tool by using either `tool_name` or `tool_guid`, but not both.
    * `tool_guid` (String.t() | nil): The GUID of a code scanning tool. Only results by this tool will be listed. Note that some code scanning tools may not include a GUID in their analysis data. You can specify the tool by using either `tool_guid` or `tool_name`, but not both.
    * `page` (integer): Page number of the results to fetch.
    * `per_page` (integer): The number of results per page (max 100).
    * `ref` (String.t()): The Git reference for the results you want to list. The `ref` for a branch can be formatted either as `refs/heads/<branch name>` or simply `<branch name>`. To reference a pull request use `refs/pull/<number>/merge`.
    * `direction` (String.t()): The direction to sort the results by.
    * `sort` (String.t()): The property by which to sort the results.
    * `state` (String.t()): If specified, only code scanning alerts with this state will be returned.
    * `severity` (String.t()): If specified, only code scanning alerts with this severity will be returned.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/code-scanning/code-scanning#list-code-scanning-alerts-for-a-repository)

  """
  @spec list_alerts_for_repo(String.t(), String.t(), keyword) ::
          {:ok, [GitHub.CodeScanning.AlertItems.t()]} | {:error, GitHub.Error.t()}
  def list_alerts_for_repo(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    query =
      Keyword.take(opts, [
        :direction,
        :page,
        :per_page,
        :ref,
        :severity,
        :sort,
        :state,
        :tool_guid,
        :tool_name
      ])

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.CodeScanning, :list_alerts_for_repo},
      url: "/repos/#{owner}/#{repo}/code-scanning/alerts",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.CodeScanning.AlertItems, :t}}},
        {304, nil},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {503, :map}
      ],
      opts: opts
    })
  end

  @doc """
  List CodeQL databases for a repository

  ## Resources

    * [API method documentation](https://docs.github.com/rest/code-scanning/code-scanning#list-codeql-databases-for-a-repository)

  """
  @spec list_codeql_databases(String.t(), String.t(), keyword) ::
          {:ok, [GitHub.CodeScanning.CodeqlDatabase.t()]} | {:error, GitHub.Error.t()}
  def list_codeql_databases(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.CodeScanning, :list_codeql_databases},
      url: "/repos/#{owner}/#{repo}/code-scanning/codeql/databases",
      method: :get,
      response: [
        {200, {:array, {GitHub.CodeScanning.CodeqlDatabase, :t}}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {503, :map}
      ],
      opts: opts
    })
  end

  @doc """
  List code scanning analyses for a repository

  ## Options

    * `tool_name` (String.t()): The name of a code scanning tool. Only results by this tool will be listed. You can specify the tool by using either `tool_name` or `tool_guid`, but not both.
    * `tool_guid` (String.t() | nil): The GUID of a code scanning tool. Only results by this tool will be listed. Note that some code scanning tools may not include a GUID in their analysis data. You can specify the tool by using either `tool_guid` or `tool_name`, but not both.
    * `page` (integer): Page number of the results to fetch.
    * `per_page` (integer): The number of results per page (max 100).
    * `ref` (String.t()): The Git reference for the analyses you want to list. The `ref` for a branch can be formatted either as `refs/heads/<branch name>` or simply `<branch name>`. To reference a pull request use `refs/pull/<number>/merge`.
    * `sarif_id` (String.t()): Filter analyses belonging to the same SARIF upload.
    * `direction` (String.t()): The direction to sort the results by.
    * `sort` (String.t()): The property by which to sort the results.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/code-scanning/code-scanning#list-code-scanning-analyses-for-a-repository)

  """
  @spec list_recent_analyses(String.t(), String.t(), keyword) ::
          {:ok, [GitHub.CodeScanning.Analysis.t()]} | {:error, GitHub.Error.t()}
  def list_recent_analyses(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    query =
      Keyword.take(opts, [
        :direction,
        :page,
        :per_page,
        :ref,
        :sarif_id,
        :sort,
        :tool_guid,
        :tool_name
      ])

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.CodeScanning, :list_recent_analyses},
      url: "/repos/#{owner}/#{repo}/code-scanning/analyses",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.CodeScanning.Analysis, :t}}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {503, :map}
      ],
      opts: opts
    })
  end

  @doc """
  Update a code scanning alert

  ## Resources

    * [API method documentation](https://docs.github.com/rest/code-scanning/code-scanning#update-a-code-scanning-alert)

  """
  @spec update_alert(String.t(), String.t(), integer, map, keyword) ::
          {:ok, GitHub.CodeScanning.Alert.t()} | {:error, GitHub.Error.t()}
  def update_alert(owner, repo, alert_number, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, alert_number: alert_number, body: body],
      call: {GitHub.CodeScanning, :update_alert},
      url: "/repos/#{owner}/#{repo}/code-scanning/alerts/#{alert_number}",
      body: body,
      method: :patch,
      request: [{"application/json", :map}],
      response: [
        {200, {GitHub.CodeScanning.Alert, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {503, :map}
      ],
      opts: opts
    })
  end

  @doc """
  Update a code scanning default setup configuration

  ## Resources

    * [API method documentation](https://docs.github.com/rest/code-scanning/code-scanning#update-a-code-scanning-default-setup-configuration)

  """
  @spec update_default_setup(
          String.t(),
          String.t(),
          GitHub.CodeScanning.DefaultSetupUpdate.t(),
          keyword
        ) ::
          {:ok, GitHub.CodeScanning.DefaultSetupUpdateResponse.t() | GitHub.EmptyObject.t()}
          | {:error, GitHub.Error.t()}
  def update_default_setup(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, body: body],
      call: {GitHub.CodeScanning, :update_default_setup},
      url: "/repos/#{owner}/#{repo}/code-scanning/default-setup",
      body: body,
      method: :patch,
      request: [{"application/json", {GitHub.CodeScanning.DefaultSetupUpdate, :t}}],
      response: [
        {200, {GitHub.EmptyObject, :t}},
        {202, {GitHub.CodeScanning.DefaultSetupUpdateResponse, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {409, {GitHub.BasicError, :t}},
        {503, :map}
      ],
      opts: opts
    })
  end

  @doc """
  Upload an analysis as SARIF data

  ## Resources

    * [API method documentation](https://docs.github.com/rest/code-scanning/code-scanning#upload-an-analysis-as-sarif-data)

  """
  @spec upload_sarif(String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.CodeScanning.SarifsReceipt.t()} | {:error, GitHub.Error.t()}
  def upload_sarif(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, body: body],
      call: {GitHub.CodeScanning, :upload_sarif},
      url: "/repos/#{owner}/#{repo}/code-scanning/sarifs",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {202, {GitHub.CodeScanning.SarifsReceipt, :t}},
        {400, nil},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {413, nil},
        {503, :map}
      ],
      opts: opts
    })
  end
end
