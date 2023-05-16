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
