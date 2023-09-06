defmodule GitHub.SecurityAdvisories do
  @moduledoc """
  Provides API endpoints related to security advisories
  """

  @default_client GitHub.Client

  @doc """
  Privately report a security vulnerability

  ## Resources

    * [API method documentation](https://docs.github.com/rest/security-advisories/repository-advisories#privately-report-a-security-vulnerability)

  """
  @spec create_private_vulnerability_report(
          String.t(),
          String.t(),
          GitHub.PrivateVulnerabilityReport.Create.t(),
          keyword
        ) :: {:ok, GitHub.Repository.Advisory.t()} | {:error, GitHub.Error.t()}
  def create_private_vulnerability_report(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, body: body],
      call: {GitHub.SecurityAdvisories, :create_private_vulnerability_report},
      url: "/repos/#{owner}/#{repo}/security-advisories/reports",
      body: body,
      method: :post,
      request: [{"application/json", {GitHub.PrivateVulnerabilityReport.Create, :t}}],
      response: [
        {201, {GitHub.Repository.Advisory, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Create a repository security advisory

  ## Resources

    * [API method documentation](https://docs.github.com/rest/security-advisories/repository-advisories#create-a-repository-security-advisory)

  """
  @spec create_repository_advisory(
          String.t(),
          String.t(),
          GitHub.Repository.Advisory.Create.t(),
          keyword
        ) :: {:ok, GitHub.Repository.Advisory.t()} | {:error, GitHub.Error.t()}
  def create_repository_advisory(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, body: body],
      call: {GitHub.SecurityAdvisories, :create_repository_advisory},
      url: "/repos/#{owner}/#{repo}/security-advisories",
      body: body,
      method: :post,
      request: [{"application/json", {GitHub.Repository.Advisory.Create, :t}}],
      response: [
        {201, {GitHub.Repository.Advisory, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Request a CVE for a repository security advisory

  ## Resources

    * [API method documentation](https://docs.github.com/rest/security-advisories/repository-advisories#request-a-cve-for-a-repository-security-advisory)

  """
  @spec create_repository_advisory_cve_request(String.t(), String.t(), String.t(), keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def create_repository_advisory_cve_request(owner, repo, ghsa_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, ghsa_id: ghsa_id],
      call: {GitHub.SecurityAdvisories, :create_repository_advisory_cve_request},
      url: "/repos/#{owner}/#{repo}/security-advisories/#{ghsa_id}/cve",
      method: :post,
      response: [
        {202, :map},
        {400, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get a global security advisory

  ## Resources

    * [API method documentation](https://docs.github.com/rest/security-advisories/global-advisories#get-a-global-security-advisory)

  """
  @spec get_global_advisory(String.t(), keyword) ::
          {:ok, GitHub.GlobalAdvisory.t()} | {:error, GitHub.Error.t()}
  def get_global_advisory(ghsa_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [ghsa_id: ghsa_id],
      call: {GitHub.SecurityAdvisories, :get_global_advisory},
      url: "/advisories/#{ghsa_id}",
      method: :get,
      response: [{200, {GitHub.GlobalAdvisory, :t}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a repository security advisory

  ## Resources

    * [API method documentation](https://docs.github.com/rest/security-advisories/repository-advisories#get-a-repository-security-advisory)

  """
  @spec get_repository_advisory(String.t(), String.t(), String.t(), keyword) ::
          {:ok, GitHub.Repository.Advisory.t()} | {:error, GitHub.Error.t()}
  def get_repository_advisory(owner, repo, ghsa_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, ghsa_id: ghsa_id],
      call: {GitHub.SecurityAdvisories, :get_repository_advisory},
      url: "/repos/#{owner}/#{repo}/security-advisories/#{ghsa_id}",
      method: :get,
      response: [
        {200, {GitHub.Repository.Advisory, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List global security advisories

  ## Options

    * `ghsa_id` (String.t()): If specified, only advisories with this GHSA (GitHub Security Advisory) identifier will be returned.
    * `type` (String.t()): If specified, only advisories of this type will be returned. By default, a request with no other parameters defined will only return reviewed advisories that are not malware.
    * `cve_id` (String.t()): If specified, only advisories with this CVE (Common Vulnerabilities and Exposures) identifier will be returned.
    * `ecosystem` (String.t()): If specified, only advisories for these ecosystems will be returned.
    * `severity` (String.t()): If specified, only advisories with these severities will be returned.
    * `cwes` (String.t() | [String.t()]): If specified, only advisories with these Common Weakness Enumerations (CWEs) will be returned.

  Example: `cwes=79,284,22` or `cwes[]=79&cwes[]=284&cwes[]=22`
    * `is_withdrawn` (boolean): Whether to only return advisories that have been withdrawn.
    * `affects` (String.t() | [String.t()]): If specified, only return advisories that affect any of `package` or `package@version`. A maximum of 1000 packages can be specified.
  If the query parameter causes the URL to exceed the maximum URL length supported by your client, you must specify fewer packages.

  Example: `affects=package1,package2@1.0.0,package3@^2.0.0` or `affects[]=package1&affects[]=package2@1.0.0`
    * `published` (String.t()): If specified, only return advisories that were published on a date or date range.

  For more information on the syntax of the date range, see "[Understanding the search syntax](https://docs.github.com/search-github/getting-started-with-searching-on-github/understanding-the-search-syntax#query-for-dates)."
    * `updated` (String.t()): If specified, only return advisories that were updated on a date or date range.

  For more information on the syntax of the date range, see "[Understanding the search syntax](https://docs.github.com/search-github/getting-started-with-searching-on-github/understanding-the-search-syntax#query-for-dates)."
    * `modified` (String.t()): If specified, only show advisories that were updated or published on a date or date range.

  For more information on the syntax of the date range, see "[Understanding the search syntax](https://docs.github.com/search-github/getting-started-with-searching-on-github/understanding-the-search-syntax#query-for-dates)."
    * `before` (String.t()): A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for results before this cursor.
    * `after` (String.t()): A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for results after this cursor.
    * `direction` (String.t()): The direction to sort the results by.
    * `per_page` (integer): The number of results per page (max 100).
    * `sort` (String.t()): The property to sort the results by.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/security-advisories/global-advisories#list-global-security-advisories)

  """
  @spec list_global_advisories(keyword) ::
          {:ok, [GitHub.GlobalAdvisory.t()]} | {:error, GitHub.Error.t()}
  def list_global_advisories(opts \\ []) do
    client = opts[:client] || @default_client

    query =
      Keyword.take(opts, [
        :affects,
        :after,
        :before,
        :cve_id,
        :cwes,
        :direction,
        :ecosystem,
        :ghsa_id,
        :is_withdrawn,
        :modified,
        :per_page,
        :published,
        :severity,
        :sort,
        :type,
        :updated
      ])

    client.request(%{
      call: {GitHub.SecurityAdvisories, :list_global_advisories},
      url: "/advisories",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.GlobalAdvisory, :t}}},
        {422, {GitHub.ValidationError, :simple}},
        {429, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List repository security advisories for an organization

  ## Options

    * `direction` (String.t()): The direction to sort the results by.
    * `sort` (String.t()): The property to sort the results by.
    * `before` (String.t()): A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for results before this cursor.
    * `after` (String.t()): A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for results after this cursor.
    * `per_page` (integer): The number of advisories to return per page.
    * `state` (String.t()): Filter by the state of the repository advisories. Only advisories of this state will be returned.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/security-advisories/repository-advisories#list-repository-security-advisories-for-an-organization)

  """
  @spec list_org_repository_advisories(String.t(), keyword) ::
          {:ok, [GitHub.Repository.Advisory.t()]} | {:error, GitHub.Error.t()}
  def list_org_repository_advisories(org, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:after, :before, :direction, :per_page, :sort, :state])

    client.request(%{
      args: [org: org],
      call: {GitHub.SecurityAdvisories, :list_org_repository_advisories},
      url: "/orgs/#{org}/security-advisories",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.Repository.Advisory, :t}}},
        {400, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List repository security advisories

  ## Options

    * `direction` (String.t()): The direction to sort the results by.
    * `sort` (String.t()): The property to sort the results by.
    * `before` (String.t()): A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for results before this cursor.
    * `after` (String.t()): A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for results after this cursor.
    * `per_page` (integer): Number of advisories to return per page.
    * `state` (String.t()): Filter by state of the repository advisories. Only advisories of this state will be returned.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/security-advisories/repository-advisories#list-repository-security-advisories)

  """
  @spec list_repository_advisories(String.t(), String.t(), keyword) ::
          {:ok, [GitHub.Repository.Advisory.t()]} | {:error, GitHub.Error.t()}
  def list_repository_advisories(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:after, :before, :direction, :per_page, :sort, :state])

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.SecurityAdvisories, :list_repository_advisories},
      url: "/repos/#{owner}/#{repo}/security-advisories",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.Repository.Advisory, :t}}},
        {400, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Update a repository security advisory

  ## Resources

    * [API method documentation](https://docs.github.com/rest/security-advisories/repository-advisories#update-a-repository-security-advisory)

  """
  @spec update_repository_advisory(
          String.t(),
          String.t(),
          String.t(),
          GitHub.Repository.Advisory.Update.t(),
          keyword
        ) :: {:ok, GitHub.Repository.Advisory.t()} | {:error, GitHub.Error.t()}
  def update_repository_advisory(owner, repo, ghsa_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, ghsa_id: ghsa_id, body: body],
      call: {GitHub.SecurityAdvisories, :update_repository_advisory},
      url: "/repos/#{owner}/#{repo}/security-advisories/#{ghsa_id}",
      body: body,
      method: :patch,
      request: [{"application/json", {GitHub.Repository.Advisory.Update, :t}}],
      response: [
        {200, {GitHub.Repository.Advisory, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end
end
