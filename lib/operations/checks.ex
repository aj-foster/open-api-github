defmodule GitHub.Checks do
  @moduledoc """
  Provides API endpoints related to checks
  """

  @default_client GitHub.Client

  @doc """
  Create a check run

  **Note:** The Checks API only looks for pushes in the repository where the check suite or check run were created. Pushes to a branch in a forked repository are not detected and return an empty `pull_requests` array.

  Creates a new check run for a specific commit in a repository. Your GitHub App must have the `checks:write` permission to create check runs.

  In a check suite, GitHub limits the number of check runs with the same name to 1000. Once these check runs exceed 1000, GitHub will start to automatically delete older check runs.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/checks/runs#create-a-check-run)

  """
  @spec create(String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.Check.Run.t()} | {:error, GitHub.Error.t()}
  def create(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, body: body],
      call: {GitHub.Checks, :create},
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

  **Note:** The Checks API only looks for pushes in the repository where the check suite or check run were created. Pushes to a branch in a forked repository are not detected and return an empty `pull_requests` array and a `null` value for `head_branch`.

  By default, check suites are automatically created when you create a [check run](https://docs.github.com/rest/checks/runs). You only need to use this endpoint for manually creating check suites when you've disabled automatic creation using "[Update repository preferences for check suites](https://docs.github.com/rest/checks/suites#update-repository-preferences-for-check-suites)". Your GitHub App must have the `checks:write` permission to create check suites.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/checks/suites#create-a-check-suite)

  """
  @spec create_suite(String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.Check.Suite.t()} | {:error, GitHub.Error.t()}
  def create_suite(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, body: body],
      call: {GitHub.Checks, :create_suite},
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

  **Note:** The Checks API only looks for pushes in the repository where the check suite or check run were created. Pushes to a branch in a forked repository are not detected and return an empty `pull_requests` array.

  Gets a single check run using its `id`. GitHub Apps must have the `checks:read` permission on a private repository or pull access to a public repository to get check runs. OAuth apps and authenticated users must have the `repo` scope to get check runs in a private repository.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/checks/runs#get-a-check-run)

  """
  @spec get(String.t(), String.t(), integer, keyword) ::
          {:ok, GitHub.Check.Run.t()} | {:error, GitHub.Error.t()}
  def get(owner, repo, check_run_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, check_run_id: check_run_id],
      call: {GitHub.Checks, :get},
      url: "/repos/#{owner}/#{repo}/check-runs/#{check_run_id}",
      method: :get,
      response: [{200, {GitHub.Check.Run, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a check suite

  **Note:** The Checks API only looks for pushes in the repository where the check suite or check run were created. Pushes to a branch in a forked repository are not detected and return an empty `pull_requests` array and a `null` value for `head_branch`.

  Gets a single check suite using its `id`. GitHub Apps must have the `checks:read` permission on a private repository or pull access to a public repository to get check suites. OAuth apps and authenticated users must have the `repo` scope to get check suites in a private repository.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/checks/suites#get-a-check-suite)

  """
  @spec get_suite(String.t(), String.t(), integer, keyword) ::
          {:ok, GitHub.Check.Suite.t()} | {:error, GitHub.Error.t()}
  def get_suite(owner, repo, check_suite_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, check_suite_id: check_suite_id],
      call: {GitHub.Checks, :get_suite},
      url: "/repos/#{owner}/#{repo}/check-suites/#{check_suite_id}",
      method: :get,
      response: [{200, {GitHub.Check.Suite, :t}}],
      opts: opts
    })
  end

  @doc """
  List check run annotations

  Lists annotations for a check run using the annotation `id`. GitHub Apps must have the `checks:read` permission on a private repository or pull access to a public repository to get annotations for a check run. OAuth apps and authenticated users must have the `repo` scope to get annotations for a check run in a private repository.

  ## Options

    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/checks/runs#list-check-run-annotations)

  """
  @spec list_annotations(String.t(), String.t(), integer, keyword) ::
          {:ok, [GitHub.Check.Annotation.t()]} | {:error, GitHub.Error.t()}
  def list_annotations(owner, repo, check_run_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [owner: owner, repo: repo, check_run_id: check_run_id],
      call: {GitHub.Checks, :list_annotations},
      url: "/repos/#{owner}/#{repo}/check-runs/#{check_run_id}/annotations",
      method: :get,
      query: query,
      response: [{200, [{GitHub.Check.Annotation, :t}]}],
      opts: opts
    })
  end

  @doc """
  List check runs for a Git reference

  **Note:** The Checks API only looks for pushes in the repository where the check suite or check run were created. Pushes to a branch in a forked repository are not detected and return an empty `pull_requests` array.

  Lists check runs for a commit ref. The `ref` can be a SHA, branch name, or a tag name. GitHub Apps must have the `checks:read` permission on a private repository or pull access to a public repository to get check runs. OAuth apps and authenticated users must have the `repo` scope to get check runs in a private repository.

  ## Options

    * `check_name`: Returns check runs with the specified `name`.
    * `status`: Returns check runs with the specified `status`.
    * `filter`: Filters check runs by their `completed_at` timestamp. `latest` returns the most recent check runs.
    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.
    * `app_id`

  ## Resources

    * [API method documentation](https://docs.github.com/rest/checks/runs#list-check-runs-for-a-git-reference)

  """
  @spec list_for_ref(String.t(), String.t(), String.t(), keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def list_for_ref(owner, repo, ref, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:app_id, :check_name, :filter, :page, :per_page, :status])

    client.request(%{
      args: [owner: owner, repo: repo, ref: ref],
      call: {GitHub.Checks, :list_for_ref},
      url: "/repos/#{owner}/#{repo}/commits/#{ref}/check-runs",
      method: :get,
      query: query,
      response: [{200, :map}],
      opts: opts
    })
  end

  @doc """
  List check runs in a check suite

  **Note:** The Checks API only looks for pushes in the repository where the check suite or check run were created. Pushes to a branch in a forked repository are not detected and return an empty `pull_requests` array.

  Lists check runs for a check suite using its `id`. GitHub Apps must have the `checks:read` permission on a private repository or pull access to a public repository to get check runs. OAuth apps and authenticated users must have the `repo` scope to get check runs in a private repository.

  ## Options

    * `check_name`: Returns check runs with the specified `name`.
    * `status`: Returns check runs with the specified `status`.
    * `filter`: Filters check runs by their `completed_at` timestamp. `latest` returns the most recent check runs.
    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/checks/runs#list-check-runs-in-a-check-suite)

  """
  @spec list_for_suite(String.t(), String.t(), integer, keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def list_for_suite(owner, repo, check_suite_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:check_name, :filter, :page, :per_page, :status])

    client.request(%{
      args: [owner: owner, repo: repo, check_suite_id: check_suite_id],
      call: {GitHub.Checks, :list_for_suite},
      url: "/repos/#{owner}/#{repo}/check-suites/#{check_suite_id}/check-runs",
      method: :get,
      query: query,
      response: [{200, :map}],
      opts: opts
    })
  end

  @doc """
  List check suites for a Git reference

  **Note:** The Checks API only looks for pushes in the repository where the check suite or check run were created. Pushes to a branch in a forked repository are not detected and return an empty `pull_requests` array and a `null` value for `head_branch`.

  Lists check suites for a commit `ref`. The `ref` can be a SHA, branch name, or a tag name. GitHub Apps must have the `checks:read` permission on a private repository or pull access to a public repository to list check suites. OAuth apps and authenticated users must have the `repo` scope to get check suites in a private repository.

  ## Options

    * `app_id`: Filters check suites by GitHub App `id`.
    * `check_name`: Returns check runs with the specified `name`.
    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/checks/suites#list-check-suites-for-a-git-reference)

  """
  @spec list_suites_for_ref(String.t(), String.t(), String.t(), keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def list_suites_for_ref(owner, repo, ref, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:app_id, :check_name, :page, :per_page])

    client.request(%{
      args: [owner: owner, repo: repo, ref: ref],
      call: {GitHub.Checks, :list_suites_for_ref},
      url: "/repos/#{owner}/#{repo}/commits/#{ref}/check-suites",
      method: :get,
      query: query,
      response: [{200, :map}],
      opts: opts
    })
  end

  @doc """
  Rerequest a check run

  Triggers GitHub to rerequest an existing check run, without pushing new code to a repository. This endpoint will trigger the [`check_run` webhook](https://docs.github.com/webhooks/event-payloads/#check_run) event with the action `rerequested`. When a check run is `rerequested`, its `status` is reset to `queued` and the `conclusion` is cleared.

  To rerequest a check run, your GitHub App must have the `checks:read` permission on a private repository or pull access to a public repository.

  For more information about how to re-run GitHub Actions jobs, see "[Re-run a job from a workflow run](https://docs.github.com/rest/actions/workflow-runs#re-run-a-job-from-a-workflow-run)".

  ## Resources

    * [API method documentation](https://docs.github.com/rest/checks/runs#rerequest-a-check-run)

  """
  @spec rerequest_run(String.t(), String.t(), integer, keyword) ::
          {:ok, GitHub.EmptyObject.t()} | {:error, GitHub.Error.t()}
  def rerequest_run(owner, repo, check_run_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, check_run_id: check_run_id],
      call: {GitHub.Checks, :rerequest_run},
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

  Triggers GitHub to rerequest an existing check suite, without pushing new code to a repository. This endpoint will trigger the [`check_suite` webhook](https://docs.github.com/webhooks/event-payloads/#check_suite) event with the action `rerequested`. When a check suite is `rerequested`, its `status` is reset to `queued` and the `conclusion` is cleared.

  To rerequest a check suite, your GitHub App must have the `checks:write` permission on a private repository or pull access to a public repository.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/checks/suites#rerequest-a-check-suite)

  """
  @spec rerequest_suite(String.t(), String.t(), integer, keyword) ::
          {:ok, GitHub.EmptyObject.t()} | {:error, GitHub.Error.t()}
  def rerequest_suite(owner, repo, check_suite_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, check_suite_id: check_suite_id],
      call: {GitHub.Checks, :rerequest_suite},
      url: "/repos/#{owner}/#{repo}/check-suites/#{check_suite_id}/rerequest",
      method: :post,
      response: [{201, {GitHub.EmptyObject, :t}}],
      opts: opts
    })
  end

  @doc """
  Update repository preferences for check suites

  Changes the default automatic flow when creating check suites. By default, a check suite is automatically created each time code is pushed to a repository. When you disable the automatic creation of check suites, you can manually [Create a check suite](https://docs.github.com/rest/checks/suites#create-a-check-suite). You must have admin permissions in the repository to set preferences for check suites.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/checks/suites#update-repository-preferences-for-check-suites)

  """
  @spec set_suites_preferences(String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.Check.SuitePreference.t()} | {:error, GitHub.Error.t()}
  def set_suites_preferences(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, body: body],
      call: {GitHub.Checks, :set_suites_preferences},
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

  **Note:** The Checks API only looks for pushes in the repository where the check suite or check run were created. Pushes to a branch in a forked repository are not detected and return an empty `pull_requests` array.

  Updates a check run for a specific commit in a repository. Your GitHub App must have the `checks:write` permission to edit check runs.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/checks/runs#update-a-check-run)

  """
  @spec update(String.t(), String.t(), integer, map, keyword) ::
          {:ok, GitHub.Check.Run.t()} | {:error, GitHub.Error.t()}
  def update(owner, repo, check_run_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, check_run_id: check_run_id, body: body],
      call: {GitHub.Checks, :update},
      url: "/repos/#{owner}/#{repo}/check-runs/#{check_run_id}",
      body: body,
      method: :patch,
      request: [{"application/json", :map}],
      response: [{200, {GitHub.Check.Run, :t}}],
      opts: opts
    })
  end
end
