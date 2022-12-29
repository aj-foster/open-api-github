defmodule GitHub.Checks do
  @moduledoc """
  Provides API endpoints related to checks
  """

  @default_client GitHub.Client

  @doc """
  Create a check run

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/checks#create-a-check-run)

  """
  @spec create(String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.Check.Run.t()} | {:error, GitHub.Error.t()}
  def create(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/repos/#{owner}/#{repo}/check-runs",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{201, {GitHub.Check.Run, :t}}],
      opts: opts
    })
  end

  @doc """
  Create a check suite

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/checks#create-a-check-suite)

  """
  @spec create_suite(String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.Check.Suite.t()} | {:error, GitHub.Error.t()}
  def create_suite(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/repos/#{owner}/#{repo}/check-suites",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, {GitHub.Check.Suite, :t}}, {201, {GitHub.Check.Suite, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a check run

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/checks#get-a-check-run)

  """
  @spec get(String.t(), String.t(), integer, keyword) ::
          {:ok, GitHub.Check.Run.t()} | {:error, GitHub.Error.t()}
  def get(owner, repo, check_run_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/repos/#{owner}/#{repo}/check-runs/#{check_run_id}",
      method: :get,
      response: [{200, {GitHub.Check.Run, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a check suite

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/checks#get-a-check-suite)

  """
  @spec get_suite(String.t(), String.t(), integer, keyword) ::
          {:ok, GitHub.Check.Suite.t()} | {:error, GitHub.Error.t()}
  def get_suite(owner, repo, check_suite_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/repos/#{owner}/#{repo}/check-suites/#{check_suite_id}",
      method: :get,
      response: [{200, {GitHub.Check.Suite, :t}}],
      opts: opts
    })
  end

  @doc """
  List check run annotations

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/checks#list-check-run-annotations)

  """
  @spec list_annotations(String.t(), String.t(), integer, keyword) ::
          {:ok, [GitHub.Check.Annotation.t()]} | {:error, GitHub.Error.t()}
  def list_annotations(owner, repo, check_run_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      url: "/repos/#{owner}/#{repo}/check-runs/#{check_run_id}/annotations",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.Check.Annotation, :t}}}],
      opts: opts
    })
  end

  @doc """
  List check runs for a Git reference

  ## Options

    * `check_name` (String.t()): Returns check runs with the specified `name`.
    * `status` (String.t()): Returns check runs with the specified `status`.
    * `filter` (String.t()): Filters check runs by their `completed_at` timestamp. `latest` returns the most recent check runs.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.
    * `app_id` (integer): 

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/checks#list-check-runs-for-a-git-reference)

  """
  @spec list_for_ref(String.t(), String.t(), String.t(), keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def list_for_ref(owner, repo, ref, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:app_id, :check_name, :filter, :page, :per_page, :status])

    client.request(%{
      url: "/repos/#{owner}/#{repo}/commits/#{ref}/check-runs",
      method: :get,
      query: query,
      response: [{200, :map}],
      opts: opts
    })
  end

  @doc """
  List check runs in a check suite

  ## Options

    * `check_name` (String.t()): Returns check runs with the specified `name`.
    * `status` (String.t()): Returns check runs with the specified `status`.
    * `filter` (String.t()): Filters check runs by their `completed_at` timestamp. `latest` returns the most recent check runs.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/checks#list-check-runs-in-a-check-suite)

  """
  @spec list_for_suite(String.t(), String.t(), integer, keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def list_for_suite(owner, repo, check_suite_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:check_name, :filter, :page, :per_page, :status])

    client.request(%{
      url: "/repos/#{owner}/#{repo}/check-suites/#{check_suite_id}/check-runs",
      method: :get,
      query: query,
      response: [{200, :map}],
      opts: opts
    })
  end

  @doc """
  List check suites for a Git reference

  ## Options

    * `app_id` (integer): Filters check suites by GitHub App `id`.
    * `check_name` (String.t()): Returns check runs with the specified `name`.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/checks#list-check-suites-for-a-git-reference)

  """
  @spec list_suites_for_ref(String.t(), String.t(), String.t(), keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def list_suites_for_ref(owner, repo, ref, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:app_id, :check_name, :page, :per_page])

    client.request(%{
      url: "/repos/#{owner}/#{repo}/commits/#{ref}/check-suites",
      method: :get,
      query: query,
      response: [{200, :map}],
      opts: opts
    })
  end

  @doc """
  Rerequest a check run

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/checks#rerequest-a-check-run)

  """
  @spec rerequest_run(String.t(), String.t(), integer, keyword) ::
          {:ok, GitHub.EmptyObject.t()} | {:error, GitHub.Error.t()}
  def rerequest_run(owner, repo, check_run_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/repos/#{owner}/#{repo}/check-runs/#{check_run_id}/rerequest",
      method: :post,
      response: [
        {201, {GitHub.EmptyObject, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Rerequest a check suite

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/checks#rerequest-a-check-suite)

  """
  @spec rerequest_suite(String.t(), String.t(), integer, keyword) ::
          {:ok, GitHub.EmptyObject.t()} | {:error, GitHub.Error.t()}
  def rerequest_suite(owner, repo, check_suite_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/repos/#{owner}/#{repo}/check-suites/#{check_suite_id}/rerequest",
      method: :post,
      response: [{201, {GitHub.EmptyObject, :t}}],
      opts: opts
    })
  end

  @doc """
  Update repository preferences for check suites

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/checks#update-repository-preferences-for-check-suites)

  """
  @spec set_suites_preferences(String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.Check.SuitePreference.t()} | {:error, GitHub.Error.t()}
  def set_suites_preferences(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/repos/#{owner}/#{repo}/check-suites/preferences",
      body: body,
      method: :patch,
      request: [{"application/json", :map}],
      response: [{200, {GitHub.Check.SuitePreference, :t}}],
      opts: opts
    })
  end

  @doc """
  Update a check run

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/checks#update-a-check-run)

  """
  @spec update(String.t(), String.t(), integer, map, keyword) ::
          {:ok, GitHub.Check.Run.t()} | {:error, GitHub.Error.t()}
  def update(owner, repo, check_run_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/repos/#{owner}/#{repo}/check-runs/#{check_run_id}",
      body: body,
      method: :patch,
      request: [{"application/json", :map}],
      response: [{200, {GitHub.Check.Run, :t}}],
      opts: opts
    })
  end
end
