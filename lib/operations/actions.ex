defmodule GitHub.Actions do
  @moduledoc """
  Provides API endpoints related to actions
  """

  @default_client GitHub.Client

  @doc """
  Add custom labels to a self-hosted runner for an organization

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#add-custom-labels-to-a-self-hosted-runner-for-an-organization)

  """
  @spec add_custom_labels_to_self_hosted_runner_for_org(String.t(), integer, map, keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def add_custom_labels_to_self_hosted_runner_for_org(org, runner_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, runner_id: runner_id],
      call: {GitHub.Actions, :add_custom_labels_to_self_hosted_runner_for_org},
      url: "/orgs/#{org}/actions/runners/#{runner_id}/labels",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {200, :map},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :simple}}
      ],
      opts: opts
    })
  end

  @doc """
  Add custom labels to a self-hosted runner for a repository

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#add-custom-labels-to-a-self-hosted-runner-for-a-repository)

  """
  @spec add_custom_labels_to_self_hosted_runner_for_repo(
          String.t(),
          String.t(),
          integer,
          map,
          keyword
        ) :: {:ok, map} | {:error, GitHub.Error.t()}
  def add_custom_labels_to_self_hosted_runner_for_repo(owner, repo, runner_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, runner_id: runner_id],
      call: {GitHub.Actions, :add_custom_labels_to_self_hosted_runner_for_repo},
      url: "/repos/#{owner}/#{repo}/actions/runners/#{runner_id}/labels",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {200, :map},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :simple}}
      ],
      opts: opts
    })
  end

  @doc """
  Add selected repository to an organization secret

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#add-selected-repository-to-an-organization-secret)

  """
  @spec add_selected_repo_to_org_secret(String.t(), String.t(), integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def add_selected_repo_to_org_secret(org, secret_name, repository_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, secret_name: secret_name, repository_id: repository_id],
      call: {GitHub.Actions, :add_selected_repo_to_org_secret},
      url: "/orgs/#{org}/actions/secrets/#{secret_name}/repositories/#{repository_id}",
      method: :put,
      response: [{204, nil}, {409, nil}],
      opts: opts
    })
  end

  @doc """
  Add selected repository to an organization variable

  ## Resources

    * [API method documentation](https://docs.github.com/rest/actions/variables#add-selected-repository-to-an-organization-variable)

  """
  @spec add_selected_repo_to_org_variable(String.t(), String.t(), integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def add_selected_repo_to_org_variable(org, name, repository_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, name: name, repository_id: repository_id],
      call: {GitHub.Actions, :add_selected_repo_to_org_variable},
      url: "/orgs/#{org}/actions/variables/#{name}/repositories/#{repository_id}",
      method: :put,
      response: [{204, nil}, {409, nil}],
      opts: opts
    })
  end

  @doc """
  Add a repository to a required workflow

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#add-a-repository-to-selected-repositories-list-for-a-required-workflow)

  """
  @spec add_selected_repo_to_required_workflow(String.t(), integer, integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def add_selected_repo_to_required_workflow(org, required_workflow_id, repository_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, required_workflow_id: required_workflow_id, repository_id: repository_id],
      call: {GitHub.Actions, :add_selected_repo_to_required_workflow},
      url:
        "/orgs/#{org}/actions/required_workflows/#{required_workflow_id}/repositories/#{repository_id}",
      method: :put,
      response: [{204, nil}, {404, nil}, {422, nil}],
      opts: opts
    })
  end

  @doc """
  Approve a workflow run for a fork pull request

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#approve-a-workflow-run-for-a-fork-pull-request)

  """
  @spec approve_workflow_run(String.t(), String.t(), integer, keyword) ::
          {:ok, GitHub.EmptyObject.t()} | {:error, GitHub.Error.t()}
  def approve_workflow_run(owner, repo, run_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, run_id: run_id],
      call: {GitHub.Actions, :approve_workflow_run},
      url: "/repos/#{owner}/#{repo}/actions/runs/#{run_id}/approve",
      method: :post,
      response: [
        {201, {GitHub.EmptyObject, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Cancel a workflow run

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#cancel-a-workflow-run)

  """
  @spec cancel_workflow_run(String.t(), String.t(), integer, keyword) ::
          {:ok, GitHub.EmptyObject.t()} | {:error, GitHub.Error.t()}
  def cancel_workflow_run(owner, repo, run_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, run_id: run_id],
      call: {GitHub.Actions, :cancel_workflow_run},
      url: "/repos/#{owner}/#{repo}/actions/runs/#{run_id}/cancel",
      method: :post,
      response: [{202, {GitHub.EmptyObject, :t}}, {409, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Create an environment variable

  ## Resources

    * [API method documentation](https://docs.github.com/rest/actions/variables#create-an-environment-variable)

  """
  @spec create_environment_variable(integer, String.t(), map, keyword) ::
          {:ok, GitHub.EmptyObject.t()} | {:error, GitHub.Error.t()}
  def create_environment_variable(repository_id, environment_name, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [repository_id: repository_id, environment_name: environment_name],
      call: {GitHub.Actions, :create_environment_variable},
      url: "/repositories/#{repository_id}/environments/#{environment_name}/variables",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{201, {GitHub.EmptyObject, :t}}],
      opts: opts
    })
  end

  @doc """
  Create or update an environment secret

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#create-or-update-an-environment-secret)

  """
  @spec create_or_update_environment_secret(integer, String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.EmptyObject.t()} | {:error, GitHub.Error.t()}
  def create_or_update_environment_secret(
        repository_id,
        environment_name,
        secret_name,
        body,
        opts \\ []
      ) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [
        repository_id: repository_id,
        environment_name: environment_name,
        secret_name: secret_name
      ],
      call: {GitHub.Actions, :create_or_update_environment_secret},
      url:
        "/repositories/#{repository_id}/environments/#{environment_name}/secrets/#{secret_name}",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [{201, {GitHub.EmptyObject, :t}}, {204, nil}],
      opts: opts
    })
  end

  @doc """
  Create or update an organization secret

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#create-or-update-an-organization-secret)

  """
  @spec create_or_update_org_secret(String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.EmptyObject.t()} | {:error, GitHub.Error.t()}
  def create_or_update_org_secret(org, secret_name, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, secret_name: secret_name],
      call: {GitHub.Actions, :create_or_update_org_secret},
      url: "/orgs/#{org}/actions/secrets/#{secret_name}",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [{201, {GitHub.EmptyObject, :t}}, {204, nil}],
      opts: opts
    })
  end

  @doc """
  Create or update a repository secret

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#create-or-update-a-repository-secret)

  """
  @spec create_or_update_repo_secret(String.t(), String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.EmptyObject.t()} | {:error, GitHub.Error.t()}
  def create_or_update_repo_secret(owner, repo, secret_name, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, secret_name: secret_name],
      call: {GitHub.Actions, :create_or_update_repo_secret},
      url: "/repos/#{owner}/#{repo}/actions/secrets/#{secret_name}",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [{201, {GitHub.EmptyObject, :t}}, {204, nil}],
      opts: opts
    })
  end

  @doc """
  Create an organization variable

  ## Resources

    * [API method documentation](https://docs.github.com/rest/actions/variables#create-an-organization-variable)

  """
  @spec create_org_variable(String.t(), map, keyword) ::
          {:ok, GitHub.EmptyObject.t()} | {:error, GitHub.Error.t()}
  def create_org_variable(org, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org],
      call: {GitHub.Actions, :create_org_variable},
      url: "/orgs/#{org}/actions/variables",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{201, {GitHub.EmptyObject, :t}}],
      opts: opts
    })
  end

  @doc """
  Create a registration token for an organization

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#create-a-registration-token-for-an-organization)

  """
  @spec create_registration_token_for_org(String.t(), keyword) ::
          {:ok, GitHub.AuthenticationToken.t()} | {:error, GitHub.Error.t()}
  def create_registration_token_for_org(org, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org],
      call: {GitHub.Actions, :create_registration_token_for_org},
      url: "/orgs/#{org}/actions/runners/registration-token",
      method: :post,
      response: [{201, {GitHub.AuthenticationToken, :t}}],
      opts: opts
    })
  end

  @doc """
  Create a registration token for a repository

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#create-a-registration-token-for-a-repository)

  """
  @spec create_registration_token_for_repo(String.t(), String.t(), keyword) ::
          {:ok, GitHub.AuthenticationToken.t()} | {:error, GitHub.Error.t()}
  def create_registration_token_for_repo(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Actions, :create_registration_token_for_repo},
      url: "/repos/#{owner}/#{repo}/actions/runners/registration-token",
      method: :post,
      response: [{201, {GitHub.AuthenticationToken, :t}}],
      opts: opts
    })
  end

  @doc """
  Create a remove token for an organization

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#create-a-remove-token-for-an-organization)

  """
  @spec create_remove_token_for_org(String.t(), keyword) ::
          {:ok, GitHub.AuthenticationToken.t()} | {:error, GitHub.Error.t()}
  def create_remove_token_for_org(org, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org],
      call: {GitHub.Actions, :create_remove_token_for_org},
      url: "/orgs/#{org}/actions/runners/remove-token",
      method: :post,
      response: [{201, {GitHub.AuthenticationToken, :t}}],
      opts: opts
    })
  end

  @doc """
  Create a remove token for a repository

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#create-a-remove-token-for-a-repository)

  """
  @spec create_remove_token_for_repo(String.t(), String.t(), keyword) ::
          {:ok, GitHub.AuthenticationToken.t()} | {:error, GitHub.Error.t()}
  def create_remove_token_for_repo(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Actions, :create_remove_token_for_repo},
      url: "/repos/#{owner}/#{repo}/actions/runners/remove-token",
      method: :post,
      response: [{201, {GitHub.AuthenticationToken, :t}}],
      opts: opts
    })
  end

  @doc """
  Create a repository variable

  ## Resources

    * [API method documentation](https://docs.github.com/rest/actions/variables#create-a-repository-variable)

  """
  @spec create_repo_variable(String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.EmptyObject.t()} | {:error, GitHub.Error.t()}
  def create_repo_variable(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Actions, :create_repo_variable},
      url: "/repos/#{owner}/#{repo}/actions/variables",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{201, {GitHub.EmptyObject, :t}}],
      opts: opts
    })
  end

  @doc """
  Create a required workflow

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#create-a-required-workflow)

  """
  @spec create_required_workflow(String.t(), map, keyword) ::
          {:ok, GitHub.RequiredWorkflow.t()} | {:error, GitHub.Error.t()}
  def create_required_workflow(org, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org],
      call: {GitHub.Actions, :create_required_workflow},
      url: "/orgs/#{org}/actions/required_workflows",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{201, {GitHub.RequiredWorkflow, :t}}, {422, {GitHub.ValidationError, :simple}}],
      opts: opts
    })
  end

  @doc """
  Create a workflow dispatch event

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#create-a-workflow-dispatch-event)

  """
  @spec create_workflow_dispatch(String.t(), String.t(), integer | String.t(), map, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def create_workflow_dispatch(owner, repo, workflow_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, workflow_id: workflow_id],
      call: {GitHub.Actions, :create_workflow_dispatch},
      url: "/repos/#{owner}/#{repo}/actions/workflows/#{workflow_id}/dispatches",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Delete a GitHub Actions cache for a repository (using a cache ID)

  ## Resources

    * [API method documentation](https://docs.github.com/rest/actions/cache#delete-a-github-actions-cache-for-a-repository-using-a-cache-id)

  """
  @spec delete_actions_cache_by_id(String.t(), String.t(), integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def delete_actions_cache_by_id(owner, repo, cache_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, cache_id: cache_id],
      call: {GitHub.Actions, :delete_actions_cache_by_id},
      url: "/repos/#{owner}/#{repo}/actions/caches/#{cache_id}",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Delete GitHub Actions caches for a repository (using a cache key)

  ## Options

    * `key` (String.t()): A key for identifying the cache.
    * `ref` (String.t()): The Git reference for the results you want to list. The `ref` for a branch can be formatted either as `refs/heads/<branch name>` or simply `<branch name>`. To reference a pull request use `refs/pull/<number>/merge`.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/actions/cache#delete-github-actions-caches-for-a-repository-using-a-cache-key)

  """
  @spec delete_actions_cache_by_key(String.t(), String.t(), keyword) ::
          {:ok, GitHub.Actions.CacheList.t()} | {:error, GitHub.Error.t()}
  def delete_actions_cache_by_key(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:key, :ref])

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Actions, :delete_actions_cache_by_key},
      url: "/repos/#{owner}/#{repo}/actions/caches",
      method: :delete,
      query: query,
      response: [{200, {GitHub.Actions.CacheList, :t}}],
      opts: opts
    })
  end

  @doc """
  Delete an artifact

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#delete-an-artifact)

  """
  @spec delete_artifact(String.t(), String.t(), integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def delete_artifact(owner, repo, artifact_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, artifact_id: artifact_id],
      call: {GitHub.Actions, :delete_artifact},
      url: "/repos/#{owner}/#{repo}/actions/artifacts/#{artifact_id}",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Delete an environment secret

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#delete-an-environment-secret)

  """
  @spec delete_environment_secret(integer, String.t(), String.t(), keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def delete_environment_secret(repository_id, environment_name, secret_name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [
        repository_id: repository_id,
        environment_name: environment_name,
        secret_name: secret_name
      ],
      call: {GitHub.Actions, :delete_environment_secret},
      url:
        "/repositories/#{repository_id}/environments/#{environment_name}/secrets/#{secret_name}",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Delete an environment variable

  ## Resources

    * [API method documentation](https://docs.github.com/rest/actions/variables#delete-an-environment-variable)

  """
  @spec delete_environment_variable(integer, String.t(), String.t(), keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def delete_environment_variable(repository_id, environment_name, name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [repository_id: repository_id, environment_name: environment_name, name: name],
      call: {GitHub.Actions, :delete_environment_variable},
      url: "/repositories/#{repository_id}/environments/#{environment_name}/variables/#{name}",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Delete an organization secret

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#delete-an-organization-secret)

  """
  @spec delete_org_secret(String.t(), String.t(), keyword) :: :ok | {:error, GitHub.Error.t()}
  def delete_org_secret(org, secret_name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, secret_name: secret_name],
      call: {GitHub.Actions, :delete_org_secret},
      url: "/orgs/#{org}/actions/secrets/#{secret_name}",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Delete an organization variable

  ## Resources

    * [API method documentation](https://docs.github.com/rest/actions/variables#delete-an-organization-variable)

  """
  @spec delete_org_variable(String.t(), String.t(), keyword) :: :ok | {:error, GitHub.Error.t()}
  def delete_org_variable(org, name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, name: name],
      call: {GitHub.Actions, :delete_org_variable},
      url: "/orgs/#{org}/actions/variables/#{name}",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Delete a repository secret

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#delete-a-repository-secret)

  """
  @spec delete_repo_secret(String.t(), String.t(), String.t(), keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def delete_repo_secret(owner, repo, secret_name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, secret_name: secret_name],
      call: {GitHub.Actions, :delete_repo_secret},
      url: "/repos/#{owner}/#{repo}/actions/secrets/#{secret_name}",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Delete a repository variable

  ## Resources

    * [API method documentation](https://docs.github.com/rest/actions/variables#delete-a-repository-variable)

  """
  @spec delete_repo_variable(String.t(), String.t(), String.t(), keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def delete_repo_variable(owner, repo, name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, name: name],
      call: {GitHub.Actions, :delete_repo_variable},
      url: "/repos/#{owner}/#{repo}/actions/variables/#{name}",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Delete a required workflow

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#delete-a-required-workflow)

  """
  @spec delete_required_workflow(String.t(), integer, keyword) :: :ok | {:error, GitHub.Error.t()}
  def delete_required_workflow(org, required_workflow_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, required_workflow_id: required_workflow_id],
      call: {GitHub.Actions, :delete_required_workflow},
      url: "/orgs/#{org}/actions/required_workflows/#{required_workflow_id}",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Delete a self-hosted runner from an organization

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#delete-a-self-hosted-runner-from-an-organization)

  """
  @spec delete_self_hosted_runner_from_org(String.t(), integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def delete_self_hosted_runner_from_org(org, runner_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, runner_id: runner_id],
      call: {GitHub.Actions, :delete_self_hosted_runner_from_org},
      url: "/orgs/#{org}/actions/runners/#{runner_id}",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Delete a self-hosted runner from a repository

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#delete-a-self-hosted-runner-from-a-repository)

  """
  @spec delete_self_hosted_runner_from_repo(String.t(), String.t(), integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def delete_self_hosted_runner_from_repo(owner, repo, runner_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, runner_id: runner_id],
      call: {GitHub.Actions, :delete_self_hosted_runner_from_repo},
      url: "/repos/#{owner}/#{repo}/actions/runners/#{runner_id}",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Delete a workflow run

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#delete-a-workflow-run)

  """
  @spec delete_workflow_run(String.t(), String.t(), integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def delete_workflow_run(owner, repo, run_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, run_id: run_id],
      call: {GitHub.Actions, :delete_workflow_run},
      url: "/repos/#{owner}/#{repo}/actions/runs/#{run_id}",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Delete workflow run logs

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#delete-workflow-run-logs)

  """
  @spec delete_workflow_run_logs(String.t(), String.t(), integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def delete_workflow_run_logs(owner, repo, run_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, run_id: run_id],
      call: {GitHub.Actions, :delete_workflow_run_logs},
      url: "/repos/#{owner}/#{repo}/actions/runs/#{run_id}/logs",
      method: :delete,
      response: [{204, nil}, {403, {GitHub.BasicError, :t}}, {500, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Disable a selected repository for GitHub Actions in an organization

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#disable-a-selected-repository-for-github-actions-in-an-organization)

  """
  @spec disable_selected_repository_github_actions_organization(String.t(), integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def disable_selected_repository_github_actions_organization(org, repository_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, repository_id: repository_id],
      call: {GitHub.Actions, :disable_selected_repository_github_actions_organization},
      url: "/orgs/#{org}/actions/permissions/repositories/#{repository_id}",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Disable a workflow

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#disable-a-workflow)

  """
  @spec disable_workflow(String.t(), String.t(), integer | String.t(), keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def disable_workflow(owner, repo, workflow_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, workflow_id: workflow_id],
      call: {GitHub.Actions, :disable_workflow},
      url: "/repos/#{owner}/#{repo}/actions/workflows/#{workflow_id}/disable",
      method: :put,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Download an artifact

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#download-an-artifact)

  """
  @spec download_artifact(String.t(), String.t(), integer, String.t(), keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def download_artifact(owner, repo, artifact_id, archive_format, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, artifact_id: artifact_id, archive_format: archive_format],
      call: {GitHub.Actions, :download_artifact},
      url: "/repos/#{owner}/#{repo}/actions/artifacts/#{artifact_id}/#{archive_format}",
      method: :get,
      response: [{302, nil}, {410, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Download job logs for a workflow run

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#download-job-logs-for-a-workflow-run)

  """
  @spec download_job_logs_for_workflow_run(String.t(), String.t(), integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def download_job_logs_for_workflow_run(owner, repo, job_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, job_id: job_id],
      call: {GitHub.Actions, :download_job_logs_for_workflow_run},
      url: "/repos/#{owner}/#{repo}/actions/jobs/#{job_id}/logs",
      method: :get,
      response: [{302, nil}],
      opts: opts
    })
  end

  @doc """
  Download workflow run attempt logs

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#download-workflow-run-attempt-logs)

  """
  @spec download_workflow_run_attempt_logs(String.t(), String.t(), integer, integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def download_workflow_run_attempt_logs(owner, repo, run_id, attempt_number, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, run_id: run_id, attempt_number: attempt_number],
      call: {GitHub.Actions, :download_workflow_run_attempt_logs},
      url: "/repos/#{owner}/#{repo}/actions/runs/#{run_id}/attempts/#{attempt_number}/logs",
      method: :get,
      response: [{302, nil}],
      opts: opts
    })
  end

  @doc """
  Download workflow run logs

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#download-workflow-run-logs)

  """
  @spec download_workflow_run_logs(String.t(), String.t(), integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def download_workflow_run_logs(owner, repo, run_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, run_id: run_id],
      call: {GitHub.Actions, :download_workflow_run_logs},
      url: "/repos/#{owner}/#{repo}/actions/runs/#{run_id}/logs",
      method: :get,
      response: [{302, nil}],
      opts: opts
    })
  end

  @doc """
  Enable a selected repository for GitHub Actions in an organization

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#enable-a-selected-repository-for-github-actions-in-an-organization)

  """
  @spec enable_selected_repository_github_actions_organization(String.t(), integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def enable_selected_repository_github_actions_organization(org, repository_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, repository_id: repository_id],
      call: {GitHub.Actions, :enable_selected_repository_github_actions_organization},
      url: "/orgs/#{org}/actions/permissions/repositories/#{repository_id}",
      method: :put,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Enable a workflow

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#enable-a-workflow)

  """
  @spec enable_workflow(String.t(), String.t(), integer | String.t(), keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def enable_workflow(owner, repo, workflow_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, workflow_id: workflow_id],
      call: {GitHub.Actions, :enable_workflow},
      url: "/repos/#{owner}/#{repo}/actions/workflows/#{workflow_id}/enable",
      method: :put,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  List GitHub Actions caches for a repository

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.
    * `ref` (String.t()): The Git reference for the results you want to list. The `ref` for a branch can be formatted either as `refs/heads/<branch name>` or simply `<branch name>`. To reference a pull request use `refs/pull/<number>/merge`.
    * `key` (String.t()): An explicit key or prefix for identifying the cache
    * `sort` (String.t()): The property to sort the results by. `created_at` means when the cache was created. `last_accessed_at` means when the cache was last accessed. `size_in_bytes` is the size of the cache in bytes.
    * `direction` (String.t()): The direction to sort the results by.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/actions/cache#list-github-actions-caches-for-a-repository)

  """
  @spec get_actions_cache_list(String.t(), String.t(), keyword) ::
          {:ok, GitHub.Actions.CacheList.t()} | {:error, GitHub.Error.t()}
  def get_actions_cache_list(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:direction, :key, :page, :per_page, :ref, :sort])

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Actions, :get_actions_cache_list},
      url: "/repos/#{owner}/#{repo}/actions/caches",
      method: :get,
      query: query,
      response: [{200, {GitHub.Actions.CacheList, :t}}],
      opts: opts
    })
  end

  @doc """
  Get GitHub Actions cache usage for a repository

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#get-github-actions-cache-usage-for-a-repository)

  """
  @spec get_actions_cache_usage(String.t(), String.t(), keyword) ::
          {:ok, GitHub.Actions.CacheUsageByRepository.t()} | {:error, GitHub.Error.t()}
  def get_actions_cache_usage(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Actions, :get_actions_cache_usage},
      url: "/repos/#{owner}/#{repo}/actions/cache/usage",
      method: :get,
      response: [{200, {GitHub.Actions.CacheUsageByRepository, :t}}],
      opts: opts
    })
  end

  @doc """
  List repositories with GitHub Actions cache usage for an organization

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#list-repositories-with-github-actions-cache-usage-for-an-organization)

  """
  @spec get_actions_cache_usage_by_repo_for_org(String.t(), keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def get_actions_cache_usage_by_repo_for_org(org, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [org: org],
      call: {GitHub.Actions, :get_actions_cache_usage_by_repo_for_org},
      url: "/orgs/#{org}/actions/cache/usage-by-repository",
      method: :get,
      query: query,
      response: [{200, :map}],
      opts: opts
    })
  end

  @doc """
  Get GitHub Actions cache usage for an organization

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#get-github-actions-cache-usage-for-an-organization)

  """
  @spec get_actions_cache_usage_for_org(String.t(), keyword) ::
          {:ok, GitHub.Actions.CacheUsageOrgEnterprise.t()} | {:error, GitHub.Error.t()}
  def get_actions_cache_usage_for_org(org, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org],
      call: {GitHub.Actions, :get_actions_cache_usage_for_org},
      url: "/orgs/#{org}/actions/cache/usage",
      method: :get,
      response: [{200, {GitHub.Actions.CacheUsageOrgEnterprise, :t}}],
      opts: opts
    })
  end

  @doc """
  Get allowed actions and reusable workflows for an organization

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#get-allowed-actions-for-an-organization)

  """
  @spec get_allowed_actions_organization(String.t(), keyword) ::
          {:ok, GitHub.SelectedActions.t()} | {:error, GitHub.Error.t()}
  def get_allowed_actions_organization(org, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org],
      call: {GitHub.Actions, :get_allowed_actions_organization},
      url: "/orgs/#{org}/actions/permissions/selected-actions",
      method: :get,
      response: [{200, {GitHub.SelectedActions, :t}}],
      opts: opts
    })
  end

  @doc """
  Get allowed actions and reusable workflows for a repository

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#get-allowed-actions-for-a-repository)

  """
  @spec get_allowed_actions_repository(String.t(), String.t(), keyword) ::
          {:ok, GitHub.SelectedActions.t()} | {:error, GitHub.Error.t()}
  def get_allowed_actions_repository(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Actions, :get_allowed_actions_repository},
      url: "/repos/#{owner}/#{repo}/actions/permissions/selected-actions",
      method: :get,
      response: [{200, {GitHub.SelectedActions, :t}}],
      opts: opts
    })
  end

  @doc """
  Get an artifact

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#get-an-artifact)

  """
  @spec get_artifact(String.t(), String.t(), integer, keyword) ::
          {:ok, GitHub.Artifact.t()} | {:error, GitHub.Error.t()}
  def get_artifact(owner, repo, artifact_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, artifact_id: artifact_id],
      call: {GitHub.Actions, :get_artifact},
      url: "/repos/#{owner}/#{repo}/actions/artifacts/#{artifact_id}",
      method: :get,
      response: [{200, {GitHub.Artifact, :t}}],
      opts: opts
    })
  end

  @doc """
  Get the customization template for an OIDC subject claim for a repository

  ## Resources

    * [API method documentation](https://docs.github.com/rest/actions/oidc#get-the-customization-template-for-an-oidc-subject-claim-for-a-repository)

  """
  @spec get_custom_oidc_sub_claim_for_repo(String.t(), String.t(), keyword) ::
          {:ok, GitHub.OIDCCustomSubRepo.t()} | {:error, GitHub.Error.t()}
  def get_custom_oidc_sub_claim_for_repo(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Actions, :get_custom_oidc_sub_claim_for_repo},
      url: "/repos/#{owner}/#{repo}/actions/oidc/customization/sub",
      method: :get,
      response: [
        {200, {GitHub.OIDCCustomSubRepo, :t}},
        {400, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get an environment public key

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#get-an-environment-public-key)

  """
  @spec get_environment_public_key(integer, String.t(), keyword) ::
          {:ok, GitHub.Actions.PublicKey.t()} | {:error, GitHub.Error.t()}
  def get_environment_public_key(repository_id, environment_name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [repository_id: repository_id, environment_name: environment_name],
      call: {GitHub.Actions, :get_environment_public_key},
      url: "/repositories/#{repository_id}/environments/#{environment_name}/secrets/public-key",
      method: :get,
      response: [{200, {GitHub.Actions.PublicKey, :t}}],
      opts: opts
    })
  end

  @doc """
  Get an environment secret

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#get-an-environment-secret)

  """
  @spec get_environment_secret(integer, String.t(), String.t(), keyword) ::
          {:ok, GitHub.Actions.Secret.t()} | {:error, GitHub.Error.t()}
  def get_environment_secret(repository_id, environment_name, secret_name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [
        repository_id: repository_id,
        environment_name: environment_name,
        secret_name: secret_name
      ],
      call: {GitHub.Actions, :get_environment_secret},
      url:
        "/repositories/#{repository_id}/environments/#{environment_name}/secrets/#{secret_name}",
      method: :get,
      response: [{200, {GitHub.Actions.Secret, :t}}],
      opts: opts
    })
  end

  @doc """
  Get an environment variable

  ## Resources

    * [API method documentation](https://docs.github.com/rest/actions/variables#get-an-environment-variable)

  """
  @spec get_environment_variable(integer, String.t(), String.t(), keyword) ::
          {:ok, GitHub.Actions.Variable.t()} | {:error, GitHub.Error.t()}
  def get_environment_variable(repository_id, environment_name, name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [repository_id: repository_id, environment_name: environment_name, name: name],
      call: {GitHub.Actions, :get_environment_variable},
      url: "/repositories/#{repository_id}/environments/#{environment_name}/variables/#{name}",
      method: :get,
      response: [{200, {GitHub.Actions.Variable, :t}}],
      opts: opts
    })
  end

  @doc """
  Get default workflow permissions for an organization

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#get-default-workflow-permissions)

  """
  @spec get_github_actions_default_workflow_permissions_organization(String.t(), keyword) ::
          {:ok, GitHub.Actions.GetDefaultWorkflowPermissions.t()} | {:error, GitHub.Error.t()}
  def get_github_actions_default_workflow_permissions_organization(org, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org],
      call: {GitHub.Actions, :get_github_actions_default_workflow_permissions_organization},
      url: "/orgs/#{org}/actions/permissions/workflow",
      method: :get,
      response: [{200, {GitHub.Actions.GetDefaultWorkflowPermissions, :t}}],
      opts: opts
    })
  end

  @doc """
  Get default workflow permissions for a repository

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#get-default-workflow-permissions-for-a-repository)

  """
  @spec get_github_actions_default_workflow_permissions_repository(
          String.t(),
          String.t(),
          keyword
        ) :: {:ok, GitHub.Actions.GetDefaultWorkflowPermissions.t()} | {:error, GitHub.Error.t()}
  def get_github_actions_default_workflow_permissions_repository(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Actions, :get_github_actions_default_workflow_permissions_repository},
      url: "/repos/#{owner}/#{repo}/actions/permissions/workflow",
      method: :get,
      response: [{200, {GitHub.Actions.GetDefaultWorkflowPermissions, :t}}],
      opts: opts
    })
  end

  @doc """
  Get GitHub Actions permissions for an organization

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#get-github-actions-permissions-for-an-organization)

  """
  @spec get_github_actions_permissions_organization(String.t(), keyword) ::
          {:ok, GitHub.Actions.OrganizationPermissions.t()} | {:error, GitHub.Error.t()}
  def get_github_actions_permissions_organization(org, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org],
      call: {GitHub.Actions, :get_github_actions_permissions_organization},
      url: "/orgs/#{org}/actions/permissions",
      method: :get,
      response: [{200, {GitHub.Actions.OrganizationPermissions, :t}}],
      opts: opts
    })
  end

  @doc """
  Get GitHub Actions permissions for a repository

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#get-github-actions-permissions-for-a-repository)

  """
  @spec get_github_actions_permissions_repository(String.t(), String.t(), keyword) ::
          {:ok, GitHub.Actions.RepositoryPermissions.t()} | {:error, GitHub.Error.t()}
  def get_github_actions_permissions_repository(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Actions, :get_github_actions_permissions_repository},
      url: "/repos/#{owner}/#{repo}/actions/permissions",
      method: :get,
      response: [{200, {GitHub.Actions.RepositoryPermissions, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a job for a workflow run

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#get-a-job-for-a-workflow-run)

  """
  @spec get_job_for_workflow_run(String.t(), String.t(), integer, keyword) ::
          {:ok, GitHub.Job.t()} | {:error, GitHub.Error.t()}
  def get_job_for_workflow_run(owner, repo, job_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, job_id: job_id],
      call: {GitHub.Actions, :get_job_for_workflow_run},
      url: "/repos/#{owner}/#{repo}/actions/jobs/#{job_id}",
      method: :get,
      response: [{200, {GitHub.Job, :t}}],
      opts: opts
    })
  end

  @doc """
  Get an organization public key

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#get-an-organization-public-key)

  """
  @spec get_org_public_key(String.t(), keyword) ::
          {:ok, GitHub.Actions.PublicKey.t()} | {:error, GitHub.Error.t()}
  def get_org_public_key(org, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org],
      call: {GitHub.Actions, :get_org_public_key},
      url: "/orgs/#{org}/actions/secrets/public-key",
      method: :get,
      response: [{200, {GitHub.Actions.PublicKey, :t}}],
      opts: opts
    })
  end

  @doc """
  Get an organization secret

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#get-an-organization-secret)

  """
  @spec get_org_secret(String.t(), String.t(), keyword) ::
          {:ok, GitHub.Organization.ActionsSecret.t()} | {:error, GitHub.Error.t()}
  def get_org_secret(org, secret_name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, secret_name: secret_name],
      call: {GitHub.Actions, :get_org_secret},
      url: "/orgs/#{org}/actions/secrets/#{secret_name}",
      method: :get,
      response: [{200, {GitHub.Organization.ActionsSecret, :t}}],
      opts: opts
    })
  end

  @doc """
  Get an organization variable

  ## Resources

    * [API method documentation](https://docs.github.com/rest/actions/variables#get-an-organization-variable)

  """
  @spec get_org_variable(String.t(), String.t(), keyword) ::
          {:ok, GitHub.Organization.ActionsVariable.t()} | {:error, GitHub.Error.t()}
  def get_org_variable(org, name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, name: name],
      call: {GitHub.Actions, :get_org_variable},
      url: "/orgs/#{org}/actions/variables/#{name}",
      method: :get,
      response: [{200, {GitHub.Organization.ActionsVariable, :t}}],
      opts: opts
    })
  end

  @doc """
  Get pending deployments for a workflow run

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#get-pending-deployments-for-a-workflow-run)

  """
  @spec get_pending_deployments_for_run(String.t(), String.t(), integer, keyword) ::
          {:ok, [GitHub.PendingDeployment.t()]} | {:error, GitHub.Error.t()}
  def get_pending_deployments_for_run(owner, repo, run_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, run_id: run_id],
      call: {GitHub.Actions, :get_pending_deployments_for_run},
      url: "/repos/#{owner}/#{repo}/actions/runs/#{run_id}/pending_deployments",
      method: :get,
      response: [{200, {:array, {GitHub.PendingDeployment, :t}}}],
      opts: opts
    })
  end

  @doc """
  Get a repository public key

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#get-a-repository-public-key)

  """
  @spec get_repo_public_key(String.t(), String.t(), keyword) ::
          {:ok, GitHub.Actions.PublicKey.t()} | {:error, GitHub.Error.t()}
  def get_repo_public_key(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Actions, :get_repo_public_key},
      url: "/repos/#{owner}/#{repo}/actions/secrets/public-key",
      method: :get,
      response: [{200, {GitHub.Actions.PublicKey, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a required workflow entity for a repository

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#get-repository-required-workflow)

  """
  @spec get_repo_required_workflow(String.t(), String.t(), integer, keyword) ::
          {:ok, GitHub.RepoRequiredWorkflow.t()} | {:error, GitHub.Error.t()}
  def get_repo_required_workflow(org, repo, required_workflow_id_for_repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, repo: repo, required_workflow_id_for_repo: required_workflow_id_for_repo],
      call: {GitHub.Actions, :get_repo_required_workflow},
      url: "/repos/#{org}/#{repo}/actions/required_workflows/#{required_workflow_id_for_repo}",
      method: :get,
      response: [{200, {GitHub.RepoRequiredWorkflow, :t}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Get required workflow usage

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#get-repository-required-workflow-usage)

  """
  @spec get_repo_required_workflow_usage(String.t(), String.t(), integer, keyword) ::
          {:ok, GitHub.Actions.Workflow.Usage.t()} | {:error, GitHub.Error.t()}
  def get_repo_required_workflow_usage(org, repo, required_workflow_id_for_repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, repo: repo, required_workflow_id_for_repo: required_workflow_id_for_repo],
      call: {GitHub.Actions, :get_repo_required_workflow_usage},
      url:
        "/repos/#{org}/#{repo}/actions/required_workflows/#{required_workflow_id_for_repo}/timing",
      method: :get,
      response: [{200, {GitHub.Actions.Workflow.Usage, :t}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a repository secret

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#get-a-repository-secret)

  """
  @spec get_repo_secret(String.t(), String.t(), String.t(), keyword) ::
          {:ok, GitHub.Actions.Secret.t()} | {:error, GitHub.Error.t()}
  def get_repo_secret(owner, repo, secret_name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, secret_name: secret_name],
      call: {GitHub.Actions, :get_repo_secret},
      url: "/repos/#{owner}/#{repo}/actions/secrets/#{secret_name}",
      method: :get,
      response: [{200, {GitHub.Actions.Secret, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a repository variable

  ## Resources

    * [API method documentation](https://docs.github.com/rest/actions/variables#get-a-repository-variable)

  """
  @spec get_repo_variable(String.t(), String.t(), String.t(), keyword) ::
          {:ok, GitHub.Actions.Variable.t()} | {:error, GitHub.Error.t()}
  def get_repo_variable(owner, repo, name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, name: name],
      call: {GitHub.Actions, :get_repo_variable},
      url: "/repos/#{owner}/#{repo}/actions/variables/#{name}",
      method: :get,
      response: [{200, {GitHub.Actions.Variable, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a required workflow

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#get-a-required-workflow)

  """
  @spec get_required_workflow(String.t(), integer, keyword) ::
          {:ok, GitHub.RequiredWorkflow.t()} | {:error, GitHub.Error.t()}
  def get_required_workflow(org, required_workflow_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, required_workflow_id: required_workflow_id],
      call: {GitHub.Actions, :get_required_workflow},
      url: "/orgs/#{org}/actions/required_workflows/#{required_workflow_id}",
      method: :get,
      response: [{200, {GitHub.RequiredWorkflow, :t}}],
      opts: opts
    })
  end

  @doc """
  Get the review history for a workflow run

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#get-the-review-history-for-a-workflow-run)

  """
  @spec get_reviews_for_run(String.t(), String.t(), integer, keyword) ::
          {:ok, [GitHub.EnvironmentApprovals.t()]} | {:error, GitHub.Error.t()}
  def get_reviews_for_run(owner, repo, run_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, run_id: run_id],
      call: {GitHub.Actions, :get_reviews_for_run},
      url: "/repos/#{owner}/#{repo}/actions/runs/#{run_id}/approvals",
      method: :get,
      response: [{200, {:array, {GitHub.EnvironmentApprovals, :t}}}],
      opts: opts
    })
  end

  @doc """
  Get a self-hosted runner for an organization

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#get-a-self-hosted-runner-for-an-organization)

  """
  @spec get_self_hosted_runner_for_org(String.t(), integer, keyword) ::
          {:ok, GitHub.Actions.Runner.t()} | {:error, GitHub.Error.t()}
  def get_self_hosted_runner_for_org(org, runner_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, runner_id: runner_id],
      call: {GitHub.Actions, :get_self_hosted_runner_for_org},
      url: "/orgs/#{org}/actions/runners/#{runner_id}",
      method: :get,
      response: [{200, {GitHub.Actions.Runner, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a self-hosted runner for a repository

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#get-a-self-hosted-runner-for-a-repository)

  """
  @spec get_self_hosted_runner_for_repo(String.t(), String.t(), integer, keyword) ::
          {:ok, GitHub.Actions.Runner.t()} | {:error, GitHub.Error.t()}
  def get_self_hosted_runner_for_repo(owner, repo, runner_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, runner_id: runner_id],
      call: {GitHub.Actions, :get_self_hosted_runner_for_repo},
      url: "/repos/#{owner}/#{repo}/actions/runners/#{runner_id}",
      method: :get,
      response: [{200, {GitHub.Actions.Runner, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a workflow

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#get-a-workflow)

  """
  @spec get_workflow(String.t(), String.t(), integer | String.t(), keyword) ::
          {:ok, GitHub.Actions.Workflow.t()} | {:error, GitHub.Error.t()}
  def get_workflow(owner, repo, workflow_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, workflow_id: workflow_id],
      call: {GitHub.Actions, :get_workflow},
      url: "/repos/#{owner}/#{repo}/actions/workflows/#{workflow_id}",
      method: :get,
      response: [{200, {GitHub.Actions.Workflow, :t}}],
      opts: opts
    })
  end

  @doc """
  Get the level of access for workflows outside of the repository

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#get-workflow-access-level-to-a-repository)

  """
  @spec get_workflow_access_to_repository(String.t(), String.t(), keyword) ::
          {:ok, GitHub.Actions.Workflow.AccessToRepository.t()} | {:error, GitHub.Error.t()}
  def get_workflow_access_to_repository(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Actions, :get_workflow_access_to_repository},
      url: "/repos/#{owner}/#{repo}/actions/permissions/access",
      method: :get,
      response: [{200, {GitHub.Actions.Workflow.AccessToRepository, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a workflow run

  ## Options

    * `exclude_pull_requests` (boolean): If `true` pull requests are omitted from the response (empty array).

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#get-a-workflow-run)

  """
  @spec get_workflow_run(String.t(), String.t(), integer, keyword) ::
          {:ok, GitHub.Actions.Workflow.Run.t()} | {:error, GitHub.Error.t()}
  def get_workflow_run(owner, repo, run_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:exclude_pull_requests])

    client.request(%{
      args: [owner: owner, repo: repo, run_id: run_id],
      call: {GitHub.Actions, :get_workflow_run},
      url: "/repos/#{owner}/#{repo}/actions/runs/#{run_id}",
      method: :get,
      query: query,
      response: [{200, {GitHub.Actions.Workflow.Run, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a workflow run attempt

  ## Options

    * `exclude_pull_requests` (boolean): If `true` pull requests are omitted from the response (empty array).

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#get-a-workflow-run-attempt)

  """
  @spec get_workflow_run_attempt(String.t(), String.t(), integer, integer, keyword) ::
          {:ok, GitHub.Actions.Workflow.Run.t()} | {:error, GitHub.Error.t()}
  def get_workflow_run_attempt(owner, repo, run_id, attempt_number, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:exclude_pull_requests])

    client.request(%{
      args: [owner: owner, repo: repo, run_id: run_id, attempt_number: attempt_number],
      call: {GitHub.Actions, :get_workflow_run_attempt},
      url: "/repos/#{owner}/#{repo}/actions/runs/#{run_id}/attempts/#{attempt_number}",
      method: :get,
      query: query,
      response: [{200, {GitHub.Actions.Workflow.Run, :t}}],
      opts: opts
    })
  end

  @doc """
  Get workflow run usage

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#get-workflow-run-usage)

  """
  @spec get_workflow_run_usage(String.t(), String.t(), integer, keyword) ::
          {:ok, GitHub.Actions.Workflow.RunUsage.t()} | {:error, GitHub.Error.t()}
  def get_workflow_run_usage(owner, repo, run_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, run_id: run_id],
      call: {GitHub.Actions, :get_workflow_run_usage},
      url: "/repos/#{owner}/#{repo}/actions/runs/#{run_id}/timing",
      method: :get,
      response: [{200, {GitHub.Actions.Workflow.RunUsage, :t}}],
      opts: opts
    })
  end

  @doc """
  Get workflow usage

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#get-workflow-usage)

  """
  @spec get_workflow_usage(String.t(), String.t(), integer | String.t(), keyword) ::
          {:ok, GitHub.Actions.Workflow.Usage.t()} | {:error, GitHub.Error.t()}
  def get_workflow_usage(owner, repo, workflow_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, workflow_id: workflow_id],
      call: {GitHub.Actions, :get_workflow_usage},
      url: "/repos/#{owner}/#{repo}/actions/workflows/#{workflow_id}/timing",
      method: :get,
      response: [{200, {GitHub.Actions.Workflow.Usage, :t}}],
      opts: opts
    })
  end

  @doc """
  List artifacts for a repository

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.
    * `name` (String.t()): Filters artifacts by exact match on their name field.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#list-artifacts-for-a-repository)

  """
  @spec list_artifacts_for_repo(String.t(), String.t(), keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def list_artifacts_for_repo(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:name, :page, :per_page])

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Actions, :list_artifacts_for_repo},
      url: "/repos/#{owner}/#{repo}/actions/artifacts",
      method: :get,
      query: query,
      response: [{200, :map}],
      opts: opts
    })
  end

  @doc """
  List environment secrets

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#list-environment-secrets)

  """
  @spec list_environment_secrets(integer, String.t(), keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def list_environment_secrets(repository_id, environment_name, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [repository_id: repository_id, environment_name: environment_name],
      call: {GitHub.Actions, :list_environment_secrets},
      url: "/repositories/#{repository_id}/environments/#{environment_name}/secrets",
      method: :get,
      query: query,
      response: [{200, :map}],
      opts: opts
    })
  end

  @doc """
  List environment variables

  ## Options

    * `per_page` (integer): The number of results per page (max 30).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/actions/variables#list-environment-variables)

  """
  @spec list_environment_variables(integer, String.t(), keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def list_environment_variables(repository_id, environment_name, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [repository_id: repository_id, environment_name: environment_name],
      call: {GitHub.Actions, :list_environment_variables},
      url: "/repositories/#{repository_id}/environments/#{environment_name}/variables",
      method: :get,
      query: query,
      response: [{200, :map}],
      opts: opts
    })
  end

  @doc """
  List jobs for a workflow run

  ## Options

    * `filter` (String.t()): Filters jobs by their `completed_at` timestamp. `latest` returns jobs from the most recent execution of the workflow run. `all` returns all jobs for a workflow run, including from old executions of the workflow run.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#list-jobs-for-a-workflow-run)

  """
  @spec list_jobs_for_workflow_run(String.t(), String.t(), integer, keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def list_jobs_for_workflow_run(owner, repo, run_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:filter, :page, :per_page])

    client.request(%{
      args: [owner: owner, repo: repo, run_id: run_id],
      call: {GitHub.Actions, :list_jobs_for_workflow_run},
      url: "/repos/#{owner}/#{repo}/actions/runs/#{run_id}/jobs",
      method: :get,
      query: query,
      response: [{200, :map}],
      opts: opts
    })
  end

  @doc """
  List jobs for a workflow run attempt

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#list-jobs-for-a-workflow-run-attempt)

  """
  @spec list_jobs_for_workflow_run_attempt(String.t(), String.t(), integer, integer, keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def list_jobs_for_workflow_run_attempt(owner, repo, run_id, attempt_number, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [owner: owner, repo: repo, run_id: run_id, attempt_number: attempt_number],
      call: {GitHub.Actions, :list_jobs_for_workflow_run_attempt},
      url: "/repos/#{owner}/#{repo}/actions/runs/#{run_id}/attempts/#{attempt_number}/jobs",
      method: :get,
      query: query,
      response: [{200, :map}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  List labels for a self-hosted runner for an organization

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#list-labels-for-a-self-hosted-runner-for-an-organization)

  """
  @spec list_labels_for_self_hosted_runner_for_org(String.t(), integer, keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def list_labels_for_self_hosted_runner_for_org(org, runner_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, runner_id: runner_id],
      call: {GitHub.Actions, :list_labels_for_self_hosted_runner_for_org},
      url: "/orgs/#{org}/actions/runners/#{runner_id}/labels",
      method: :get,
      response: [{200, :map}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  List labels for a self-hosted runner for a repository

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#list-labels-for-a-self-hosted-runner-for-a-repository)

  """
  @spec list_labels_for_self_hosted_runner_for_repo(String.t(), String.t(), integer, keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def list_labels_for_self_hosted_runner_for_repo(owner, repo, runner_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, runner_id: runner_id],
      call: {GitHub.Actions, :list_labels_for_self_hosted_runner_for_repo},
      url: "/repos/#{owner}/#{repo}/actions/runners/#{runner_id}/labels",
      method: :get,
      response: [{200, :map}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  List organization secrets

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#list-organization-secrets)

  """
  @spec list_org_secrets(String.t(), keyword) :: {:ok, map} | {:error, GitHub.Error.t()}
  def list_org_secrets(org, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [org: org],
      call: {GitHub.Actions, :list_org_secrets},
      url: "/orgs/#{org}/actions/secrets",
      method: :get,
      query: query,
      response: [{200, :map}],
      opts: opts
    })
  end

  @doc """
  List organization variables

  ## Options

    * `per_page` (integer): The number of results per page (max 30).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/actions/variables#list-organization-variables)

  """
  @spec list_org_variables(String.t(), keyword) :: {:ok, map} | {:error, GitHub.Error.t()}
  def list_org_variables(org, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [org: org],
      call: {GitHub.Actions, :list_org_variables},
      url: "/orgs/#{org}/actions/variables",
      method: :get,
      query: query,
      response: [{200, :map}],
      opts: opts
    })
  end

  @doc """
  List repository required workflows

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#list-repository-required-workflows)

  """
  @spec list_repo_required_workflows(String.t(), String.t(), keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def list_repo_required_workflows(org, repo, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [org: org, repo: repo],
      call: {GitHub.Actions, :list_repo_required_workflows},
      url: "/repos/#{org}/#{repo}/actions/required_workflows",
      method: :get,
      query: query,
      response: [{200, :map}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  List repository secrets

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#list-repository-secrets)

  """
  @spec list_repo_secrets(String.t(), String.t(), keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def list_repo_secrets(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Actions, :list_repo_secrets},
      url: "/repos/#{owner}/#{repo}/actions/secrets",
      method: :get,
      query: query,
      response: [{200, :map}],
      opts: opts
    })
  end

  @doc """
  List repository variables

  ## Options

    * `per_page` (integer): The number of results per page (max 30).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/actions/variables#list-repository-variables)

  """
  @spec list_repo_variables(String.t(), String.t(), keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def list_repo_variables(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Actions, :list_repo_variables},
      url: "/repos/#{owner}/#{repo}/actions/variables",
      method: :get,
      query: query,
      response: [{200, :map}],
      opts: opts
    })
  end

  @doc """
  List repository workflows

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#list-repository-workflows)

  """
  @spec list_repo_workflows(String.t(), String.t(), keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def list_repo_workflows(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Actions, :list_repo_workflows},
      url: "/repos/#{owner}/#{repo}/actions/workflows",
      method: :get,
      query: query,
      response: [{200, :map}],
      opts: opts
    })
  end

  @doc """
  List workflow runs for a required workflow

  ## Options

    * `actor` (String.t()): Returns someone's workflow runs. Use the login for the user who created the `push` associated with the check suite or workflow run.
    * `branch` (String.t()): Returns workflow runs associated with a branch. Use the name of the branch of the `push`.
    * `event` (String.t()): Returns workflow run triggered by the event you specify. For example, `push`, `pull_request` or `issue`. For more information, see "[Events that trigger workflows](https://docs.github.com/actions/automating-your-workflow-with-github-actions/events-that-trigger-workflows)."
    * `status` (String.t()): Returns workflow runs with the check run `status` or `conclusion` that you specify. For example, a conclusion can be `success` or a status can be `in_progress`. Only GitHub can set a status of `waiting` or `requested`.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.
    * `created` (String.t()): Returns workflow runs created within the given date-time range. For more information on the syntax, see "[Understanding the search syntax](https://docs.github.com/search-github/getting-started-with-searching-on-github/understanding-the-search-syntax#query-for-dates)."
    * `exclude_pull_requests` (boolean): If `true` pull requests are omitted from the response (empty array).
    * `check_suite_id` (integer): Returns workflow runs with the `check_suite_id` that you specify.
    * `head_sha` (String.t()): Only returns workflow runs that are associated with the specified `head_sha`.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#list-required-workflow-runs)

  """
  @spec list_required_workflow_runs(String.t(), String.t(), integer, keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def list_required_workflow_runs(owner, repo, required_workflow_id_for_repo, opts \\ []) do
    client = opts[:client] || @default_client

    query =
      Keyword.take(opts, [
        :actor,
        :branch,
        :check_suite_id,
        :created,
        :event,
        :exclude_pull_requests,
        :head_sha,
        :page,
        :per_page,
        :status
      ])

    client.request(%{
      args: [
        owner: owner,
        repo: repo,
        required_workflow_id_for_repo: required_workflow_id_for_repo
      ],
      call: {GitHub.Actions, :list_required_workflow_runs},
      url:
        "/repos/#{owner}/#{repo}/actions/required_workflows/#{required_workflow_id_for_repo}/runs",
      method: :get,
      query: query,
      response: [{200, :map}],
      opts: opts
    })
  end

  @doc """
  List required workflows

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#list-required-workflows)

  """
  @spec list_required_workflows(String.t(), keyword) :: {:ok, map} | {:error, GitHub.Error.t()}
  def list_required_workflows(org, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [org: org],
      call: {GitHub.Actions, :list_required_workflows},
      url: "/orgs/#{org}/actions/required_workflows",
      method: :get,
      query: query,
      response: [{200, :map}],
      opts: opts
    })
  end

  @doc """
  List runner applications for an organization

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#list-runner-applications-for-an-organization)

  """
  @spec list_runner_applications_for_org(String.t(), keyword) ::
          {:ok, [GitHub.Actions.Runner.Application.t()]} | {:error, GitHub.Error.t()}
  def list_runner_applications_for_org(org, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org],
      call: {GitHub.Actions, :list_runner_applications_for_org},
      url: "/orgs/#{org}/actions/runners/downloads",
      method: :get,
      response: [{200, {:array, {GitHub.Actions.Runner.Application, :t}}}],
      opts: opts
    })
  end

  @doc """
  List runner applications for a repository

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#list-runner-applications-for-a-repository)

  """
  @spec list_runner_applications_for_repo(String.t(), String.t(), keyword) ::
          {:ok, [GitHub.Actions.Runner.Application.t()]} | {:error, GitHub.Error.t()}
  def list_runner_applications_for_repo(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Actions, :list_runner_applications_for_repo},
      url: "/repos/#{owner}/#{repo}/actions/runners/downloads",
      method: :get,
      response: [{200, {:array, {GitHub.Actions.Runner.Application, :t}}}],
      opts: opts
    })
  end

  @doc """
  List selected repositories for an organization secret

  ## Options

    * `page` (integer): Page number of the results to fetch.
    * `per_page` (integer): The number of results per page (max 100).

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#list-selected-repositories-for-an-organization-secret)

  """
  @spec list_selected_repos_for_org_secret(String.t(), String.t(), keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def list_selected_repos_for_org_secret(org, secret_name, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [org: org, secret_name: secret_name],
      call: {GitHub.Actions, :list_selected_repos_for_org_secret},
      url: "/orgs/#{org}/actions/secrets/#{secret_name}/repositories",
      method: :get,
      query: query,
      response: [{200, :map}],
      opts: opts
    })
  end

  @doc """
  List selected repositories for an organization variable

  ## Options

    * `page` (integer): Page number of the results to fetch.
    * `per_page` (integer): The number of results per page (max 100).

  ## Resources

    * [API method documentation](https://docs.github.com/rest/actions/variables#list-selected-repositories-for-an-organization-variable)

  """
  @spec list_selected_repos_for_org_variable(String.t(), String.t(), keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def list_selected_repos_for_org_variable(org, name, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [org: org, name: name],
      call: {GitHub.Actions, :list_selected_repos_for_org_variable},
      url: "/orgs/#{org}/actions/variables/#{name}/repositories",
      method: :get,
      query: query,
      response: [{200, :map}, {409, nil}],
      opts: opts
    })
  end

  @doc """
  List selected repositories enabled for GitHub Actions in an organization

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#list-selected-repositories-enabled-for-github-actions-in-an-organization)

  """
  @spec list_selected_repositories_enabled_github_actions_organization(String.t(), keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def list_selected_repositories_enabled_github_actions_organization(org, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [org: org],
      call: {GitHub.Actions, :list_selected_repositories_enabled_github_actions_organization},
      url: "/orgs/#{org}/actions/permissions/repositories",
      method: :get,
      query: query,
      response: [{200, :map}],
      opts: opts
    })
  end

  @doc """
  List selected repositories for a required workflow

  ## Resources

    * [API method documentation https://docs.github.com/rest/reference/actions#list-selected-repositories-required-workflows](https://docs.github.com/rest/reference/actions#list-selected-repositories-required-workflows)

  """
  @spec list_selected_repositories_required_workflow(String.t(), integer, keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def list_selected_repositories_required_workflow(org, required_workflow_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, required_workflow_id: required_workflow_id],
      call: {GitHub.Actions, :list_selected_repositories_required_workflow},
      url: "/orgs/#{org}/actions/required_workflows/#{required_workflow_id}/repositories",
      method: :get,
      response: [{200, :map}, {404, nil}],
      opts: opts
    })
  end

  @doc """
  List self-hosted runners for an organization

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#list-self-hosted-runners-for-an-organization)

  """
  @spec list_self_hosted_runners_for_org(String.t(), keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def list_self_hosted_runners_for_org(org, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [org: org],
      call: {GitHub.Actions, :list_self_hosted_runners_for_org},
      url: "/orgs/#{org}/actions/runners",
      method: :get,
      query: query,
      response: [{200, :map}],
      opts: opts
    })
  end

  @doc """
  List self-hosted runners for a repository

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#list-self-hosted-runners-for-a-repository)

  """
  @spec list_self_hosted_runners_for_repo(String.t(), String.t(), keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def list_self_hosted_runners_for_repo(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Actions, :list_self_hosted_runners_for_repo},
      url: "/repos/#{owner}/#{repo}/actions/runners",
      method: :get,
      query: query,
      response: [{200, :map}],
      opts: opts
    })
  end

  @doc """
  List workflow run artifacts

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#list-workflow-run-artifacts)

  """
  @spec list_workflow_run_artifacts(String.t(), String.t(), integer, keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def list_workflow_run_artifacts(owner, repo, run_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [owner: owner, repo: repo, run_id: run_id],
      call: {GitHub.Actions, :list_workflow_run_artifacts},
      url: "/repos/#{owner}/#{repo}/actions/runs/#{run_id}/artifacts",
      method: :get,
      query: query,
      response: [{200, :map}],
      opts: opts
    })
  end

  @doc """
  List workflow runs for a workflow

  ## Options

    * `actor` (String.t()): Returns someone's workflow runs. Use the login for the user who created the `push` associated with the check suite or workflow run.
    * `branch` (String.t()): Returns workflow runs associated with a branch. Use the name of the branch of the `push`.
    * `event` (String.t()): Returns workflow run triggered by the event you specify. For example, `push`, `pull_request` or `issue`. For more information, see "[Events that trigger workflows](https://docs.github.com/actions/automating-your-workflow-with-github-actions/events-that-trigger-workflows)."
    * `status` (String.t()): Returns workflow runs with the check run `status` or `conclusion` that you specify. For example, a conclusion can be `success` or a status can be `in_progress`. Only GitHub can set a status of `waiting` or `requested`.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.
    * `created` (String.t()): Returns workflow runs created within the given date-time range. For more information on the syntax, see "[Understanding the search syntax](https://docs.github.com/search-github/getting-started-with-searching-on-github/understanding-the-search-syntax#query-for-dates)."
    * `exclude_pull_requests` (boolean): If `true` pull requests are omitted from the response (empty array).
    * `check_suite_id` (integer): Returns workflow runs with the `check_suite_id` that you specify.
    * `head_sha` (String.t()): Only returns workflow runs that are associated with the specified `head_sha`.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#list-workflow-runs)

  """
  @spec list_workflow_runs(String.t(), String.t(), integer | String.t(), keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def list_workflow_runs(owner, repo, workflow_id, opts \\ []) do
    client = opts[:client] || @default_client

    query =
      Keyword.take(opts, [
        :actor,
        :branch,
        :check_suite_id,
        :created,
        :event,
        :exclude_pull_requests,
        :head_sha,
        :page,
        :per_page,
        :status
      ])

    client.request(%{
      args: [owner: owner, repo: repo, workflow_id: workflow_id],
      call: {GitHub.Actions, :list_workflow_runs},
      url: "/repos/#{owner}/#{repo}/actions/workflows/#{workflow_id}/runs",
      method: :get,
      query: query,
      response: [{200, :map}],
      opts: opts
    })
  end

  @doc """
  List workflow runs for a repository

  ## Options

    * `actor` (String.t()): Returns someone's workflow runs. Use the login for the user who created the `push` associated with the check suite or workflow run.
    * `branch` (String.t()): Returns workflow runs associated with a branch. Use the name of the branch of the `push`.
    * `event` (String.t()): Returns workflow run triggered by the event you specify. For example, `push`, `pull_request` or `issue`. For more information, see "[Events that trigger workflows](https://docs.github.com/actions/automating-your-workflow-with-github-actions/events-that-trigger-workflows)."
    * `status` (String.t()): Returns workflow runs with the check run `status` or `conclusion` that you specify. For example, a conclusion can be `success` or a status can be `in_progress`. Only GitHub can set a status of `waiting` or `requested`.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.
    * `created` (String.t()): Returns workflow runs created within the given date-time range. For more information on the syntax, see "[Understanding the search syntax](https://docs.github.com/search-github/getting-started-with-searching-on-github/understanding-the-search-syntax#query-for-dates)."
    * `exclude_pull_requests` (boolean): If `true` pull requests are omitted from the response (empty array).
    * `check_suite_id` (integer): Returns workflow runs with the `check_suite_id` that you specify.
    * `head_sha` (String.t()): Only returns workflow runs that are associated with the specified `head_sha`.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#list-workflow-runs-for-a-repository)

  """
  @spec list_workflow_runs_for_repo(String.t(), String.t(), keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def list_workflow_runs_for_repo(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    query =
      Keyword.take(opts, [
        :actor,
        :branch,
        :check_suite_id,
        :created,
        :event,
        :exclude_pull_requests,
        :head_sha,
        :page,
        :per_page,
        :status
      ])

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Actions, :list_workflow_runs_for_repo},
      url: "/repos/#{owner}/#{repo}/actions/runs",
      method: :get,
      query: query,
      response: [{200, :map}],
      opts: opts
    })
  end

  @doc """
  Re-run a job from a workflow run

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#re-run-job-for-workflow-run)

  """
  @spec re_run_job_for_workflow_run(String.t(), String.t(), integer, map | nil, keyword) ::
          {:ok, GitHub.EmptyObject.t()} | {:error, GitHub.Error.t()}
  def re_run_job_for_workflow_run(owner, repo, job_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, job_id: job_id],
      call: {GitHub.Actions, :re_run_job_for_workflow_run},
      url: "/repos/#{owner}/#{repo}/actions/jobs/#{job_id}/rerun",
      body: body,
      method: :post,
      request: [{"application/json", {:nullable, :map}}],
      response: [{201, {GitHub.EmptyObject, :t}}, {403, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Re-run a workflow

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#re-run-a-workflow)

  """
  @spec re_run_workflow(String.t(), String.t(), integer, map | nil, keyword) ::
          {:ok, GitHub.EmptyObject.t()} | {:error, GitHub.Error.t()}
  def re_run_workflow(owner, repo, run_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, run_id: run_id],
      call: {GitHub.Actions, :re_run_workflow},
      url: "/repos/#{owner}/#{repo}/actions/runs/#{run_id}/rerun",
      body: body,
      method: :post,
      request: [{"application/json", {:nullable, :map}}],
      response: [{201, {GitHub.EmptyObject, :t}}],
      opts: opts
    })
  end

  @doc """
  Re-run failed jobs from a workflow run

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#re-run-workflow-failed-jobs)

  """
  @spec re_run_workflow_failed_jobs(String.t(), String.t(), integer, map | nil, keyword) ::
          {:ok, GitHub.EmptyObject.t()} | {:error, GitHub.Error.t()}
  def re_run_workflow_failed_jobs(owner, repo, run_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, run_id: run_id],
      call: {GitHub.Actions, :re_run_workflow_failed_jobs},
      url: "/repos/#{owner}/#{repo}/actions/runs/#{run_id}/rerun-failed-jobs",
      body: body,
      method: :post,
      request: [{"application/json", {:nullable, :map}}],
      response: [{201, {GitHub.EmptyObject, :t}}],
      opts: opts
    })
  end

  @doc """
  Remove all custom labels from a self-hosted runner for an organization

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#remove-all-custom-labels-from-a-self-hosted-runner-for-an-organization)

  """
  @spec remove_all_custom_labels_from_self_hosted_runner_for_org(String.t(), integer, keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def remove_all_custom_labels_from_self_hosted_runner_for_org(org, runner_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, runner_id: runner_id],
      call: {GitHub.Actions, :remove_all_custom_labels_from_self_hosted_runner_for_org},
      url: "/orgs/#{org}/actions/runners/#{runner_id}/labels",
      method: :delete,
      response: [{200, :map}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Remove all custom labels from a self-hosted runner for a repository

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#remove-all-custom-labels-from-a-self-hosted-runner-for-a-repository)

  """
  @spec remove_all_custom_labels_from_self_hosted_runner_for_repo(
          String.t(),
          String.t(),
          integer,
          keyword
        ) :: {:ok, map} | {:error, GitHub.Error.t()}
  def remove_all_custom_labels_from_self_hosted_runner_for_repo(
        owner,
        repo,
        runner_id,
        opts \\ []
      ) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, runner_id: runner_id],
      call: {GitHub.Actions, :remove_all_custom_labels_from_self_hosted_runner_for_repo},
      url: "/repos/#{owner}/#{repo}/actions/runners/#{runner_id}/labels",
      method: :delete,
      response: [{200, :map}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Remove a custom label from a self-hosted runner for an organization

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#remove-a-custom-label-from-a-self-hosted-runner-for-an-organization)

  """
  @spec remove_custom_label_from_self_hosted_runner_for_org(
          String.t(),
          integer,
          String.t(),
          keyword
        ) :: {:ok, map} | {:error, GitHub.Error.t()}
  def remove_custom_label_from_self_hosted_runner_for_org(org, runner_id, name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, runner_id: runner_id, name: name],
      call: {GitHub.Actions, :remove_custom_label_from_self_hosted_runner_for_org},
      url: "/orgs/#{org}/actions/runners/#{runner_id}/labels/#{name}",
      method: :delete,
      response: [
        {200, :map},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :simple}}
      ],
      opts: opts
    })
  end

  @doc """
  Remove a custom label from a self-hosted runner for a repository

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#remove-a-custom-label-from-a-self-hosted-runner-for-a-repository)

  """
  @spec remove_custom_label_from_self_hosted_runner_for_repo(
          String.t(),
          String.t(),
          integer,
          String.t(),
          keyword
        ) :: {:ok, map} | {:error, GitHub.Error.t()}
  def remove_custom_label_from_self_hosted_runner_for_repo(
        owner,
        repo,
        runner_id,
        name,
        opts \\ []
      ) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, runner_id: runner_id, name: name],
      call: {GitHub.Actions, :remove_custom_label_from_self_hosted_runner_for_repo},
      url: "/repos/#{owner}/#{repo}/actions/runners/#{runner_id}/labels/#{name}",
      method: :delete,
      response: [
        {200, :map},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :simple}}
      ],
      opts: opts
    })
  end

  @doc """
  Remove selected repository from an organization secret

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#remove-selected-repository-from-an-organization-secret)

  """
  @spec remove_selected_repo_from_org_secret(String.t(), String.t(), integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def remove_selected_repo_from_org_secret(org, secret_name, repository_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, secret_name: secret_name, repository_id: repository_id],
      call: {GitHub.Actions, :remove_selected_repo_from_org_secret},
      url: "/orgs/#{org}/actions/secrets/#{secret_name}/repositories/#{repository_id}",
      method: :delete,
      response: [{204, nil}, {409, nil}],
      opts: opts
    })
  end

  @doc """
  Remove selected repository from an organization variable

  ## Resources

    * [API method documentation](https://docs.github.com/rest/actions/variables#remove-selected-repository-from-an-organization-variable)

  """
  @spec remove_selected_repo_from_org_variable(String.t(), String.t(), integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def remove_selected_repo_from_org_variable(org, name, repository_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, name: name, repository_id: repository_id],
      call: {GitHub.Actions, :remove_selected_repo_from_org_variable},
      url: "/orgs/#{org}/actions/variables/#{name}/repositories/#{repository_id}",
      method: :delete,
      response: [{204, nil}, {409, nil}],
      opts: opts
    })
  end

  @doc """
  Remove a selected repository from required workflow

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#remove-a-repository-from-selected-repositories-list-for-a-required-workflow)

  """
  @spec remove_selected_repo_from_required_workflow(String.t(), integer, integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def remove_selected_repo_from_required_workflow(
        org,
        required_workflow_id,
        repository_id,
        opts \\ []
      ) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, required_workflow_id: required_workflow_id, repository_id: repository_id],
      call: {GitHub.Actions, :remove_selected_repo_from_required_workflow},
      url:
        "/orgs/#{org}/actions/required_workflows/#{required_workflow_id}/repositories/#{repository_id}",
      method: :delete,
      response: [{204, nil}, {404, nil}, {422, nil}],
      opts: opts
    })
  end

  @doc """
  Review pending deployments for a workflow run

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#review-pending-deployments-for-a-workflow-run)

  """
  @spec review_pending_deployments_for_run(String.t(), String.t(), integer, map, keyword) ::
          {:ok, [GitHub.Deployment.t()]} | {:error, GitHub.Error.t()}
  def review_pending_deployments_for_run(owner, repo, run_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, run_id: run_id],
      call: {GitHub.Actions, :review_pending_deployments_for_run},
      url: "/repos/#{owner}/#{repo}/actions/runs/#{run_id}/pending_deployments",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, {:array, {GitHub.Deployment, :t}}}],
      opts: opts
    })
  end

  @doc """
  Set allowed actions and reusable workflows for an organization

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#set-allowed-actions-for-an-organization)

  """
  @spec set_allowed_actions_organization(String.t(), GitHub.SelectedActions.t(), keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def set_allowed_actions_organization(org, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org],
      call: {GitHub.Actions, :set_allowed_actions_organization},
      url: "/orgs/#{org}/actions/permissions/selected-actions",
      body: body,
      method: :put,
      request: [{"application/json", {GitHub.SelectedActions, :t}}],
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Set allowed actions and reusable workflows for a repository

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#set-allowed-actions-for-a-repository)

  """
  @spec set_allowed_actions_repository(
          String.t(),
          String.t(),
          GitHub.SelectedActions.t(),
          keyword
        ) :: :ok | {:error, GitHub.Error.t()}
  def set_allowed_actions_repository(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Actions, :set_allowed_actions_repository},
      url: "/repos/#{owner}/#{repo}/actions/permissions/selected-actions",
      body: body,
      method: :put,
      request: [{"application/json", {GitHub.SelectedActions, :t}}],
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Set custom labels for a self-hosted runner for an organization

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#set-custom-labels-for-a-self-hosted-runner-for-an-organization)

  """
  @spec set_custom_labels_for_self_hosted_runner_for_org(String.t(), integer, map, keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def set_custom_labels_for_self_hosted_runner_for_org(org, runner_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, runner_id: runner_id],
      call: {GitHub.Actions, :set_custom_labels_for_self_hosted_runner_for_org},
      url: "/orgs/#{org}/actions/runners/#{runner_id}/labels",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [
        {200, :map},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :simple}}
      ],
      opts: opts
    })
  end

  @doc """
  Set custom labels for a self-hosted runner for a repository

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#set-custom-labels-for-a-self-hosted-runner-for-a-repository)

  """
  @spec set_custom_labels_for_self_hosted_runner_for_repo(
          String.t(),
          String.t(),
          integer,
          map,
          keyword
        ) :: {:ok, map} | {:error, GitHub.Error.t()}
  def set_custom_labels_for_self_hosted_runner_for_repo(owner, repo, runner_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, runner_id: runner_id],
      call: {GitHub.Actions, :set_custom_labels_for_self_hosted_runner_for_repo},
      url: "/repos/#{owner}/#{repo}/actions/runners/#{runner_id}/labels",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [
        {200, :map},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :simple}}
      ],
      opts: opts
    })
  end

  @doc """
  Set the customization template for an OIDC subject claim for a repository

  ## Resources

    * [API method documentation](https://docs.github.com/rest/actions/oidc#set-the-customization-template-for-an-oidc-subject-claim-for-a-repository)

  """
  @spec set_custom_oidc_sub_claim_for_repo(String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.EmptyObject.t()} | {:error, GitHub.Error.t()}
  def set_custom_oidc_sub_claim_for_repo(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Actions, :set_custom_oidc_sub_claim_for_repo},
      url: "/repos/#{owner}/#{repo}/actions/oidc/customization/sub",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [
        {201, {GitHub.EmptyObject, :t}},
        {400, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :simple}}
      ],
      opts: opts
    })
  end

  @doc """
  Set default workflow permissions for an organization

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#set-default-workflow-permissions)

  """
  @spec set_github_actions_default_workflow_permissions_organization(
          String.t(),
          GitHub.Actions.SetDefaultWorkflowPermissions.t(),
          keyword
        ) :: :ok | {:error, GitHub.Error.t()}
  def set_github_actions_default_workflow_permissions_organization(org, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org],
      call: {GitHub.Actions, :set_github_actions_default_workflow_permissions_organization},
      url: "/orgs/#{org}/actions/permissions/workflow",
      body: body,
      method: :put,
      request: [{"application/json", {GitHub.Actions.SetDefaultWorkflowPermissions, :t}}],
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Set default workflow permissions for a repository

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#set-default-workflow-permissions-for-a-repository)

  """
  @spec set_github_actions_default_workflow_permissions_repository(
          String.t(),
          String.t(),
          GitHub.Actions.SetDefaultWorkflowPermissions.t(),
          keyword
        ) :: :ok | {:error, GitHub.Error.t()}
  def set_github_actions_default_workflow_permissions_repository(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Actions, :set_github_actions_default_workflow_permissions_repository},
      url: "/repos/#{owner}/#{repo}/actions/permissions/workflow",
      body: body,
      method: :put,
      request: [{"application/json", {GitHub.Actions.SetDefaultWorkflowPermissions, :t}}],
      response: [{204, nil}, {409, nil}],
      opts: opts
    })
  end

  @doc """
  Set GitHub Actions permissions for an organization

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#set-github-actions-permissions-for-an-organization)

  """
  @spec set_github_actions_permissions_organization(String.t(), map, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def set_github_actions_permissions_organization(org, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org],
      call: {GitHub.Actions, :set_github_actions_permissions_organization},
      url: "/orgs/#{org}/actions/permissions",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Set GitHub Actions permissions for a repository

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#set-github-actions-permissions-for-a-repository)

  """
  @spec set_github_actions_permissions_repository(String.t(), String.t(), map, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def set_github_actions_permissions_repository(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Actions, :set_github_actions_permissions_repository},
      url: "/repos/#{owner}/#{repo}/actions/permissions",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Set selected repositories for an organization secret

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#set-selected-repositories-for-an-organization-secret)

  """
  @spec set_selected_repos_for_org_secret(String.t(), String.t(), map, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def set_selected_repos_for_org_secret(org, secret_name, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, secret_name: secret_name],
      call: {GitHub.Actions, :set_selected_repos_for_org_secret},
      url: "/orgs/#{org}/actions/secrets/#{secret_name}/repositories",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Set selected repositories for an organization variable

  ## Resources

    * [API method documentation](https://docs.github.com/rest/actions/variables#set-selected-repositories-for-an-organization-variable)

  """
  @spec set_selected_repos_for_org_variable(String.t(), String.t(), map, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def set_selected_repos_for_org_variable(org, name, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, name: name],
      call: {GitHub.Actions, :set_selected_repos_for_org_variable},
      url: "/orgs/#{org}/actions/variables/#{name}/repositories",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [{204, nil}, {409, nil}],
      opts: opts
    })
  end

  @doc """
  Sets repositories for a required workflow

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#set-selected-repositories-for-a-required-workflow)

  """
  @spec set_selected_repos_to_required_workflow(String.t(), integer, map, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def set_selected_repos_to_required_workflow(org, required_workflow_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, required_workflow_id: required_workflow_id],
      call: {GitHub.Actions, :set_selected_repos_to_required_workflow},
      url: "/orgs/#{org}/actions/required_workflows/#{required_workflow_id}/repositories",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Set selected repositories enabled for GitHub Actions in an organization

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#set-selected-repositories-enabled-for-github-actions-in-an-organization)

  """
  @spec set_selected_repositories_enabled_github_actions_organization(String.t(), map, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def set_selected_repositories_enabled_github_actions_organization(org, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org],
      call: {GitHub.Actions, :set_selected_repositories_enabled_github_actions_organization},
      url: "/orgs/#{org}/actions/permissions/repositories",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Set the level of access for workflows outside of the repository

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#set-workflow-access-to-a-repository)

  """
  @spec set_workflow_access_to_repository(
          String.t(),
          String.t(),
          GitHub.Actions.Workflow.AccessToRepository.t(),
          keyword
        ) :: :ok | {:error, GitHub.Error.t()}
  def set_workflow_access_to_repository(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Actions, :set_workflow_access_to_repository},
      url: "/repos/#{owner}/#{repo}/actions/permissions/access",
      body: body,
      method: :put,
      request: [{"application/json", {GitHub.Actions.Workflow.AccessToRepository, :t}}],
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Update an environment variable

  ## Resources

    * [API method documentation](https://docs.github.com/rest/actions/variables#update-an-environment-variable)

  """
  @spec update_environment_variable(integer, String.t(), String.t(), map, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def update_environment_variable(repository_id, environment_name, name, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [repository_id: repository_id, environment_name: environment_name, name: name],
      call: {GitHub.Actions, :update_environment_variable},
      url: "/repositories/#{repository_id}/environments/#{environment_name}/variables/#{name}",
      body: body,
      method: :patch,
      request: [{"application/json", :map}],
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Update an organization variable

  ## Resources

    * [API method documentation](https://docs.github.com/rest/actions/variables#update-an-organization-variable)

  """
  @spec update_org_variable(String.t(), String.t(), map, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def update_org_variable(org, name, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, name: name],
      call: {GitHub.Actions, :update_org_variable},
      url: "/orgs/#{org}/actions/variables/#{name}",
      body: body,
      method: :patch,
      request: [{"application/json", :map}],
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Update a repository variable

  ## Resources

    * [API method documentation](https://docs.github.com/rest/actions/variables#update-a-repository-variable)

  """
  @spec update_repo_variable(String.t(), String.t(), String.t(), map, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def update_repo_variable(owner, repo, name, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, name: name],
      call: {GitHub.Actions, :update_repo_variable},
      url: "/repos/#{owner}/#{repo}/actions/variables/#{name}",
      body: body,
      method: :patch,
      request: [{"application/json", :map}],
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Update a required workflow

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/actions#update-a-required-workflow)

  """
  @spec update_required_workflow(String.t(), integer, map, keyword) ::
          {:ok, GitHub.RequiredWorkflow.t()} | {:error, GitHub.Error.t()}
  def update_required_workflow(org, required_workflow_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, required_workflow_id: required_workflow_id],
      call: {GitHub.Actions, :update_required_workflow},
      url: "/orgs/#{org}/actions/required_workflows/#{required_workflow_id}",
      body: body,
      method: :patch,
      request: [{"application/json", :map}],
      response: [{200, {GitHub.RequiredWorkflow, :t}}, {422, {GitHub.ValidationError, :simple}}],
      opts: opts
    })
  end
end
