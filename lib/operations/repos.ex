defmodule GitHub.Repos do
  @moduledoc """
  Provides API endpoints related to repos
  """

  @default_client GitHub.Client

  @doc """
  Accept a repository invitation

  ## Resources

    * [API method documentation](https://docs.github.com/rest/collaborators/invitations#accept-a-repository-invitation)

  """
  @spec accept_invitation_for_authenticated_user(integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def accept_invitation_for_authenticated_user(invitation_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [invitation_id: invitation_id],
      call: {GitHub.Repos, :accept_invitation_for_authenticated_user},
      url: "/user/repository_invitations/#{invitation_id}",
      method: :patch,
      response: [
        {204, nil},
        {304, nil},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {409, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Add app access restrictions

  ## Resources

    * [API method documentation](https://docs.github.com/rest/branches/branch-protection#add-app-access-restrictions)

  """
  @spec add_app_access_restrictions(
          String.t(),
          String.t(),
          String.t(),
          map | [String.t()],
          keyword
        ) :: {:ok, [GitHub.Integration.t()]} | {:error, GitHub.Error.t()}
  def add_app_access_restrictions(owner, repo, branch, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, branch: branch],
      call: {GitHub.Repos, :add_app_access_restrictions},
      url: "/repos/#{owner}/#{repo}/branches/#{branch}/protection/restrictions/apps",
      body: body,
      method: :post,
      request: [{"application/json", {:union, [:map, array: :string]}}],
      response: [{200, {:array, {GitHub.Integration, :t}}}, {422, {GitHub.ValidationError, :t}}],
      opts: opts
    })
  end

  @doc """
  Add a repository collaborator

  ## Resources

    * [API method documentation](https://docs.github.com/rest/collaborators/collaborators#add-a-repository-collaborator)

  """
  @spec add_collaborator(String.t(), String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.Repository.Invitation.t()} | {:error, GitHub.Error.t()}
  def add_collaborator(owner, repo, username, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, username: username],
      call: {GitHub.Repos, :add_collaborator},
      url: "/repos/#{owner}/#{repo}/collaborators/#{username}",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [
        {201, {GitHub.Repository.Invitation, :t}},
        {204, nil},
        {403, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Add status check contexts

  ## Resources

    * [API method documentation](https://docs.github.com/rest/branches/branch-protection#add-status-check-contexts)

  """
  @spec add_status_check_contexts(String.t(), String.t(), String.t(), map | [String.t()], keyword) ::
          {:ok, [String.t()]} | {:error, GitHub.Error.t()}
  def add_status_check_contexts(owner, repo, branch, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, branch: branch],
      call: {GitHub.Repos, :add_status_check_contexts},
      url:
        "/repos/#{owner}/#{repo}/branches/#{branch}/protection/required_status_checks/contexts",
      body: body,
      method: :post,
      request: [{"application/json", {:union, [:map, array: :string]}}],
      response: [
        {200, {:array, :string}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Add team access restrictions

  ## Resources

    * [API method documentation](https://docs.github.com/rest/branches/branch-protection#add-team-access-restrictions)

  """
  @spec add_team_access_restrictions(
          String.t(),
          String.t(),
          String.t(),
          map | [String.t()],
          keyword
        ) :: {:ok, [GitHub.Team.t()]} | {:error, GitHub.Error.t()}
  def add_team_access_restrictions(owner, repo, branch, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, branch: branch],
      call: {GitHub.Repos, :add_team_access_restrictions},
      url: "/repos/#{owner}/#{repo}/branches/#{branch}/protection/restrictions/teams",
      body: body,
      method: :post,
      request: [{"application/json", {:union, [:map, array: :string]}}],
      response: [{200, {:array, {GitHub.Team, :t}}}, {422, {GitHub.ValidationError, :t}}],
      opts: opts
    })
  end

  @doc """
  Add user access restrictions

  ## Resources

    * [API method documentation](https://docs.github.com/rest/branches/branch-protection#add-user-access-restrictions)

  """
  @spec add_user_access_restrictions(
          String.t(),
          String.t(),
          String.t(),
          map | [String.t()],
          keyword
        ) :: {:ok, [GitHub.User.simple()]} | {:error, GitHub.Error.t()}
  def add_user_access_restrictions(owner, repo, branch, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, branch: branch],
      call: {GitHub.Repos, :add_user_access_restrictions},
      url: "/repos/#{owner}/#{repo}/branches/#{branch}/protection/restrictions/users",
      body: body,
      method: :post,
      request: [{"application/json", {:union, [:map, array: :string]}}],
      response: [{200, {:array, {GitHub.User, :simple}}}, {422, {GitHub.ValidationError, :t}}],
      opts: opts
    })
  end

  @doc """
  Check if a user is a repository collaborator

  ## Resources

    * [API method documentation](https://docs.github.com/rest/collaborators/collaborators#check-if-a-user-is-a-repository-collaborator)

  """
  @spec check_collaborator(String.t(), String.t(), String.t(), keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def check_collaborator(owner, repo, username, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, username: username],
      call: {GitHub.Repos, :check_collaborator},
      url: "/repos/#{owner}/#{repo}/collaborators/#{username}",
      method: :get,
      response: [{204, nil}, {404, nil}],
      opts: opts
    })
  end

  @doc """
  Check if vulnerability alerts are enabled for a repository

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/repos#check-if-vulnerability-alerts-are-enabled-for-a-repository)

  """
  @spec check_vulnerability_alerts(String.t(), String.t(), keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def check_vulnerability_alerts(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :check_vulnerability_alerts},
      url: "/repos/#{owner}/#{repo}/vulnerability-alerts",
      method: :get,
      response: [{204, nil}, {404, nil}],
      opts: opts
    })
  end

  @doc """
  List CODEOWNERS errors

  ## Options

    * `ref` (String.t()): A branch, tag or commit name used to determine which version of the CODEOWNERS file to use. Default: the repository's default branch (e.g. `main`)

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/repos#list-codeowners-errors)

  """
  @spec codeowners_errors(String.t(), String.t(), keyword) ::
          {:ok, GitHub.CodeownersErrors.t()} | {:error, GitHub.Error.t()}
  def codeowners_errors(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:ref])

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :codeowners_errors},
      url: "/repos/#{owner}/#{repo}/codeowners/errors",
      method: :get,
      query: query,
      response: [{200, {GitHub.CodeownersErrors, :t}}, {404, nil}],
      opts: opts
    })
  end

  @doc """
  Compare two commits

  ## Options

    * `page` (integer): Page number of the results to fetch.
    * `per_page` (integer): The number of results per page (max 100).

  ## Resources

    * [API method documentation](https://docs.github.com/rest/commits/commits#compare-two-commits)

  """
  @spec compare_commits(String.t(), String.t(), String.t(), keyword) ::
          {:ok, GitHub.Commit.Comparison.t()} | {:error, GitHub.Error.t()}
  def compare_commits(owner, repo, basehead, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [owner: owner, repo: repo, basehead: basehead],
      call: {GitHub.Repos, :compare_commits},
      url: "/repos/#{owner}/#{repo}/compare/#{basehead}",
      method: :get,
      query: query,
      response: [
        {200, {GitHub.Commit.Comparison, :t}},
        {404, {GitHub.BasicError, :t}},
        {500, {GitHub.BasicError, :t}},
        {503, :map}
      ],
      opts: opts
    })
  end

  @doc """
  Create an autolink reference for a repository

  ## Resources

    * [API method documentation](https://docs.github.com/rest/repos/autolinks#create-an-autolink-reference-for-a-repository)

  """
  @spec create_autolink(String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.Autolink.t()} | {:error, GitHub.Error.t()}
  def create_autolink(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :create_autolink},
      url: "/repos/#{owner}/#{repo}/autolinks",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{201, {GitHub.Autolink, :t}}, {422, {GitHub.ValidationError, :t}}],
      opts: opts
    })
  end

  @doc """
  Create a commit comment

  ## Resources

    * [API method documentation](https://docs.github.com/rest/commits/comments#create-a-commit-comment)

  """
  @spec create_commit_comment(String.t(), String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.Commit.Comment.t()} | {:error, GitHub.Error.t()}
  def create_commit_comment(owner, repo, commit_sha, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, commit_sha: commit_sha],
      call: {GitHub.Repos, :create_commit_comment},
      url: "/repos/#{owner}/#{repo}/commits/#{commit_sha}/comments",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {201, {GitHub.Commit.Comment, :t}},
        {403, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Create commit signature protection

  ## Resources

    * [API method documentation](https://docs.github.com/rest/branches/branch-protection#create-commit-signature-protection)

  """
  @spec create_commit_signature_protection(String.t(), String.t(), String.t(), keyword) ::
          {:ok, GitHub.ProtectedBranch.AdminEnforced.t()} | {:error, GitHub.Error.t()}
  def create_commit_signature_protection(owner, repo, branch, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, branch: branch],
      call: {GitHub.Repos, :create_commit_signature_protection},
      url: "/repos/#{owner}/#{repo}/branches/#{branch}/protection/required_signatures",
      method: :post,
      response: [
        {200, {GitHub.ProtectedBranch.AdminEnforced, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Create a commit status

  ## Resources

    * [API method documentation](https://docs.github.com/rest/commits/statuses#create-a-commit-status)

  """
  @spec create_commit_status(String.t(), String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.Status.t()} | {:error, GitHub.Error.t()}
  def create_commit_status(owner, repo, sha, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, sha: sha],
      call: {GitHub.Repos, :create_commit_status},
      url: "/repos/#{owner}/#{repo}/statuses/#{sha}",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{201, {GitHub.Status, :t}}],
      opts: opts
    })
  end

  @doc """
  Create a deploy key

  ## Resources

    * [API method documentation](https://docs.github.com/rest/deploy-keys#create-a-deploy-key)

  """
  @spec create_deploy_key(String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.DeployKey.t()} | {:error, GitHub.Error.t()}
  def create_deploy_key(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :create_deploy_key},
      url: "/repos/#{owner}/#{repo}/keys",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{201, {GitHub.DeployKey, :t}}, {422, {GitHub.ValidationError, :t}}],
      opts: opts
    })
  end

  @doc """
  Create a deployment

  ## Resources

    * [API method documentation](https://docs.github.com/rest/deployments/deployments#create-a-deployment)

  """
  @spec create_deployment(String.t(), String.t(), map, keyword) ::
          {:ok, map | GitHub.Deployment.t()} | {:error, GitHub.Error.t()}
  def create_deployment(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :create_deployment},
      url: "/repos/#{owner}/#{repo}/deployments",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {201, {GitHub.Deployment, :t}},
        {202, :map},
        {409, nil},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Create a deployment branch policy

  ## Resources

    * [API method documentation](https://docs.github.com/rest/deployments/branch-policies#create-deployment-branch-policy)

  """
  @spec create_deployment_branch_policy(
          String.t(),
          String.t(),
          String.t(),
          GitHub.Deployment.BranchPolicyNamePattern.t(),
          keyword
        ) :: {:ok, GitHub.Deployment.BranchPolicy.t()} | {:error, GitHub.Error.t()}
  def create_deployment_branch_policy(owner, repo, environment_name, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, environment_name: environment_name],
      call: {GitHub.Repos, :create_deployment_branch_policy},
      url: "/repos/#{owner}/#{repo}/environments/#{environment_name}/deployment-branch-policies",
      body: body,
      method: :post,
      request: [{"application/json", {GitHub.Deployment.BranchPolicyNamePattern, :t}}],
      response: [{200, {GitHub.Deployment.BranchPolicy, :t}}, {303, nil}, {404, nil}],
      opts: opts
    })
  end

  @doc """
  Create a deployment status

  ## Resources

    * [API method documentation](https://docs.github.com/rest/deployments/statuses#create-a-deployment-status)

  """
  @spec create_deployment_status(String.t(), String.t(), integer, map, keyword) ::
          {:ok, GitHub.Deployment.Status.t()} | {:error, GitHub.Error.t()}
  def create_deployment_status(owner, repo, deployment_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, deployment_id: deployment_id],
      call: {GitHub.Repos, :create_deployment_status},
      url: "/repos/#{owner}/#{repo}/deployments/#{deployment_id}/statuses",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{201, {GitHub.Deployment.Status, :t}}, {422, {GitHub.ValidationError, :t}}],
      opts: opts
    })
  end

  @doc """
  Create a repository dispatch event

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/repos#create-a-repository-dispatch-event)

  """
  @spec create_dispatch_event(String.t(), String.t(), map, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def create_dispatch_event(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :create_dispatch_event},
      url: "/repos/#{owner}/#{repo}/dispatches",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{204, nil}, {422, {GitHub.ValidationError, :t}}],
      opts: opts
    })
  end

  @doc """
  Create a repository for the authenticated user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/repos#create-a-repository-for-the-authenticated-user)

  """
  @spec create_for_authenticated_user(map, keyword) ::
          {:ok, GitHub.Repository.t()} | {:error, GitHub.Error.t()}
  def create_for_authenticated_user(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      call: {GitHub.Repos, :create_for_authenticated_user},
      url: "/user/repos",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {201, {GitHub.Repository, :t}},
        {304, nil},
        {400, {GitHub.BasicError, :t}},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Create a fork

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/repos#create-a-fork)

  """
  @spec create_fork(String.t(), String.t(), map | nil, keyword) ::
          {:ok, GitHub.Repository.full()} | {:error, GitHub.Error.t()}
  def create_fork(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :create_fork},
      url: "/repos/#{owner}/#{repo}/forks",
      body: body,
      method: :post,
      request: [{"application/json", {:nullable, :map}}],
      response: [
        {202, {GitHub.Repository, :full}},
        {400, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Create an organization repository

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/repos#create-an-organization-repository)

  """
  @spec create_in_org(String.t(), map, keyword) ::
          {:ok, GitHub.Repository.t()} | {:error, GitHub.Error.t()}
  def create_in_org(org, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org],
      call: {GitHub.Repos, :create_in_org},
      url: "/orgs/#{org}/repos",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {201, {GitHub.Repository, :t}},
        {403, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Create or update an environment

  ## Resources

    * [API method documentation](https://docs.github.com/rest/deployments/environments#create-or-update-an-environment)

  """
  @spec create_or_update_environment(String.t(), String.t(), String.t(), map | nil, keyword) ::
          {:ok, GitHub.Environment.t()} | {:error, GitHub.Error.t()}
  def create_or_update_environment(owner, repo, environment_name, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, environment_name: environment_name],
      call: {GitHub.Repos, :create_or_update_environment},
      url: "/repos/#{owner}/#{repo}/environments/#{environment_name}",
      body: body,
      method: :put,
      request: [{"application/json", {:nullable, :map}}],
      response: [{200, {GitHub.Environment, :t}}, {422, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Create or update file contents

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/repos#create-or-update-file-contents)

  """
  @spec create_or_update_file_contents(String.t(), String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.FileCommit.t()} | {:error, GitHub.Error.t()}
  def create_or_update_file_contents(owner, repo, path, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, path: path],
      call: {GitHub.Repos, :create_or_update_file_contents},
      url: "/repos/#{owner}/#{repo}/contents/#{path}",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [
        {200, {GitHub.FileCommit, :t}},
        {201, {GitHub.FileCommit, :t}},
        {404, {GitHub.BasicError, :t}},
        {409, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Create a GitHub Pages deployment

  ## Resources

    * [API method documentation](https://docs.github.com/rest/pages#create-a-github-pages-deployment)

  """
  @spec create_pages_deployment(String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.Pages.Deployment.t()} | {:error, GitHub.Error.t()}
  def create_pages_deployment(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :create_pages_deployment},
      url: "/repos/#{owner}/#{repo}/pages/deployment",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {200, {GitHub.Pages.Deployment, :t}},
        {400, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Create a GitHub Pages site

  ## Resources

    * [API method documentation](https://docs.github.com/rest/pages#create-a-github-pages-site)

  """
  @spec create_pages_site(String.t(), String.t(), map | nil, keyword) ::
          {:ok, GitHub.Page.t()} | {:error, GitHub.Error.t()}
  def create_pages_site(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :create_pages_site},
      url: "/repos/#{owner}/#{repo}/pages",
      body: body,
      method: :post,
      request: [{"application/json", {:nullable, :map}}],
      response: [
        {201, {GitHub.Page, :t}},
        {409, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Create a release

  ## Resources

    * [API method documentation](https://docs.github.com/rest/releases/releases#create-a-release)

  """
  @spec create_release(String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.Release.t()} | {:error, GitHub.Error.t()}
  def create_release(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :create_release},
      url: "/repos/#{owner}/#{repo}/releases",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {201, {GitHub.Release, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Create a tag protection state for a repository

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/repos#create-tag-protection-state-for-a-repository)

  """
  @spec create_tag_protection(String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.TagProtection.t()} | {:error, GitHub.Error.t()}
  def create_tag_protection(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :create_tag_protection},
      url: "/repos/#{owner}/#{repo}/tags/protection",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {201, {GitHub.TagProtection, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Create a repository using a template

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/repos#create-a-repository-using-a-template)

  """
  @spec create_using_template(String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.Repository.t()} | {:error, GitHub.Error.t()}
  def create_using_template(template_owner, template_repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [template_owner: template_owner, template_repo: template_repo],
      call: {GitHub.Repos, :create_using_template},
      url: "/repos/#{template_owner}/#{template_repo}/generate",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{201, {GitHub.Repository, :t}}],
      opts: opts
    })
  end

  @doc """
  Create a repository webhook

  ## Resources

    * [API method documentation](https://docs.github.com/rest/webhooks/repos#create-a-repository-webhook)

  """
  @spec create_webhook(String.t(), String.t(), map | nil, keyword) ::
          {:ok, GitHub.Hook.t()} | {:error, GitHub.Error.t()}
  def create_webhook(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :create_webhook},
      url: "/repos/#{owner}/#{repo}/hooks",
      body: body,
      method: :post,
      request: [{"application/json", {:nullable, :map}}],
      response: [
        {201, {GitHub.Hook, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Decline a repository invitation

  ## Resources

    * [API method documentation](https://docs.github.com/rest/collaborators/invitations#decline-a-repository-invitation)

  """
  @spec decline_invitation_for_authenticated_user(integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def decline_invitation_for_authenticated_user(invitation_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [invitation_id: invitation_id],
      call: {GitHub.Repos, :decline_invitation_for_authenticated_user},
      url: "/user/repository_invitations/#{invitation_id}",
      method: :delete,
      response: [
        {204, nil},
        {304, nil},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {409, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Delete a repository

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/repos#delete-a-repository)

  """
  @spec delete(String.t(), String.t(), keyword) :: :ok | {:error, GitHub.Error.t()}
  def delete(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :delete},
      url: "/repos/#{owner}/#{repo}",
      method: :delete,
      response: [
        {204, nil},
        {307, {GitHub.BasicError, :t}},
        {403, :map},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Delete access restrictions

  ## Resources

    * [API method documentation](https://docs.github.com/rest/branches/branch-protection#delete-access-restrictions)

  """
  @spec delete_access_restrictions(String.t(), String.t(), String.t(), keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def delete_access_restrictions(owner, repo, branch, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, branch: branch],
      call: {GitHub.Repos, :delete_access_restrictions},
      url: "/repos/#{owner}/#{repo}/branches/#{branch}/protection/restrictions",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Delete admin branch protection

  ## Resources

    * [API method documentation](https://docs.github.com/rest/branches/branch-protection#delete-admin-branch-protection)

  """
  @spec delete_admin_branch_protection(String.t(), String.t(), String.t(), keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def delete_admin_branch_protection(owner, repo, branch, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, branch: branch],
      call: {GitHub.Repos, :delete_admin_branch_protection},
      url: "/repos/#{owner}/#{repo}/branches/#{branch}/protection/enforce_admins",
      method: :delete,
      response: [{204, nil}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Delete an environment

  ## Resources

    * [API method documentation](https://docs.github.com/rest/deployments/environments#delete-an-environment)

  """
  @spec delete_an_environment(String.t(), String.t(), String.t(), keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def delete_an_environment(owner, repo, environment_name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, environment_name: environment_name],
      call: {GitHub.Repos, :delete_an_environment},
      url: "/repos/#{owner}/#{repo}/environments/#{environment_name}",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Delete an autolink reference from a repository

  ## Resources

    * [API method documentation](https://docs.github.com/rest/repos/autolinks#delete-an-autolink-reference-from-a-repository)

  """
  @spec delete_autolink(String.t(), String.t(), integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def delete_autolink(owner, repo, autolink_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, autolink_id: autolink_id],
      call: {GitHub.Repos, :delete_autolink},
      url: "/repos/#{owner}/#{repo}/autolinks/#{autolink_id}",
      method: :delete,
      response: [{204, nil}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Delete branch protection

  ## Resources

    * [API method documentation](https://docs.github.com/rest/branches/branch-protection#delete-branch-protection)

  """
  @spec delete_branch_protection(String.t(), String.t(), String.t(), keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def delete_branch_protection(owner, repo, branch, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, branch: branch],
      call: {GitHub.Repos, :delete_branch_protection},
      url: "/repos/#{owner}/#{repo}/branches/#{branch}/protection",
      method: :delete,
      response: [{204, nil}, {403, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Delete a commit comment

  ## Resources

    * [API method documentation](https://docs.github.com/rest/commits/comments#delete-a-commit-comment)

  """
  @spec delete_commit_comment(String.t(), String.t(), integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def delete_commit_comment(owner, repo, comment_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, comment_id: comment_id],
      call: {GitHub.Repos, :delete_commit_comment},
      url: "/repos/#{owner}/#{repo}/comments/#{comment_id}",
      method: :delete,
      response: [{204, nil}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Delete commit signature protection

  ## Resources

    * [API method documentation](https://docs.github.com/rest/branches/branch-protection#delete-commit-signature-protection)

  """
  @spec delete_commit_signature_protection(String.t(), String.t(), String.t(), keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def delete_commit_signature_protection(owner, repo, branch, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, branch: branch],
      call: {GitHub.Repos, :delete_commit_signature_protection},
      url: "/repos/#{owner}/#{repo}/branches/#{branch}/protection/required_signatures",
      method: :delete,
      response: [{204, nil}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Delete a deploy key

  ## Resources

    * [API method documentation](https://docs.github.com/rest/deploy-keys#delete-a-deploy-key)

  """
  @spec delete_deploy_key(String.t(), String.t(), integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def delete_deploy_key(owner, repo, key_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, key_id: key_id],
      call: {GitHub.Repos, :delete_deploy_key},
      url: "/repos/#{owner}/#{repo}/keys/#{key_id}",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Delete a deployment

  ## Resources

    * [API method documentation](https://docs.github.com/rest/deployments/deployments#delete-a-deployment)

  """
  @spec delete_deployment(String.t(), String.t(), integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def delete_deployment(owner, repo, deployment_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, deployment_id: deployment_id],
      call: {GitHub.Repos, :delete_deployment},
      url: "/repos/#{owner}/#{repo}/deployments/#{deployment_id}",
      method: :delete,
      response: [
        {204, nil},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :simple}}
      ],
      opts: opts
    })
  end

  @doc """
  Delete a deployment branch policy

  ## Resources

    * [API method documentation](https://docs.github.com/rest/deployments/branch-policies#delete-deployment-branch-policy)

  """
  @spec delete_deployment_branch_policy(String.t(), String.t(), String.t(), integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def delete_deployment_branch_policy(owner, repo, environment_name, branch_policy_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [
        owner: owner,
        repo: repo,
        environment_name: environment_name,
        branch_policy_id: branch_policy_id
      ],
      call: {GitHub.Repos, :delete_deployment_branch_policy},
      url:
        "/repos/#{owner}/#{repo}/environments/#{environment_name}/deployment-branch-policies/#{branch_policy_id}",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Delete a file

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/repos#delete-a-file)

  """
  @spec delete_file(String.t(), String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.FileCommit.t()} | {:error, GitHub.Error.t()}
  def delete_file(owner, repo, path, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, path: path],
      call: {GitHub.Repos, :delete_file},
      url: "/repos/#{owner}/#{repo}/contents/#{path}",
      body: body,
      method: :delete,
      request: [{"application/json", :map}],
      response: [
        {200, {GitHub.FileCommit, :t}},
        {404, {GitHub.BasicError, :t}},
        {409, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}},
        {503, :map}
      ],
      opts: opts
    })
  end

  @doc """
  Delete a repository invitation

  ## Resources

    * [API method documentation](https://docs.github.com/rest/collaborators/invitations#delete-a-repository-invitation)

  """
  @spec delete_invitation(String.t(), String.t(), integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def delete_invitation(owner, repo, invitation_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, invitation_id: invitation_id],
      call: {GitHub.Repos, :delete_invitation},
      url: "/repos/#{owner}/#{repo}/invitations/#{invitation_id}",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Delete a GitHub Pages site

  ## Resources

    * [API method documentation](https://docs.github.com/rest/pages#delete-a-github-pages-site)

  """
  @spec delete_pages_site(String.t(), String.t(), keyword) :: :ok | {:error, GitHub.Error.t()}
  def delete_pages_site(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :delete_pages_site},
      url: "/repos/#{owner}/#{repo}/pages",
      method: :delete,
      response: [
        {204, nil},
        {404, {GitHub.BasicError, :t}},
        {409, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Delete pull request review protection

  ## Resources

    * [API method documentation](https://docs.github.com/rest/branches/branch-protection#delete-pull-request-review-protection)

  """
  @spec delete_pull_request_review_protection(String.t(), String.t(), String.t(), keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def delete_pull_request_review_protection(owner, repo, branch, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, branch: branch],
      call: {GitHub.Repos, :delete_pull_request_review_protection},
      url: "/repos/#{owner}/#{repo}/branches/#{branch}/protection/required_pull_request_reviews",
      method: :delete,
      response: [{204, nil}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Delete a release

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/repos#delete-a-release)

  """
  @spec delete_release(String.t(), String.t(), integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def delete_release(owner, repo, release_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, release_id: release_id],
      call: {GitHub.Repos, :delete_release},
      url: "/repos/#{owner}/#{repo}/releases/#{release_id}",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Delete a release asset

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/repos#delete-a-release-asset)

  """
  @spec delete_release_asset(String.t(), String.t(), integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def delete_release_asset(owner, repo, asset_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, asset_id: asset_id],
      call: {GitHub.Repos, :delete_release_asset},
      url: "/repos/#{owner}/#{repo}/releases/assets/#{asset_id}",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Delete a tag protection state for a repository

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/repos#delete-tag-protection-state-for-a-repository)

  """
  @spec delete_tag_protection(String.t(), String.t(), integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def delete_tag_protection(owner, repo, tag_protection_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, tag_protection_id: tag_protection_id],
      call: {GitHub.Repos, :delete_tag_protection},
      url: "/repos/#{owner}/#{repo}/tags/protection/#{tag_protection_id}",
      method: :delete,
      response: [{204, nil}, {403, {GitHub.BasicError, :t}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Delete a repository webhook

  ## Resources

    * [API method documentation](https://docs.github.com/rest/webhooks/repos#delete-a-repository-webhook)

  """
  @spec delete_webhook(String.t(), String.t(), integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def delete_webhook(owner, repo, hook_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, hook_id: hook_id],
      call: {GitHub.Repos, :delete_webhook},
      url: "/repos/#{owner}/#{repo}/hooks/#{hook_id}",
      method: :delete,
      response: [{204, nil}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Disable automated security fixes

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/repos#disable-automated-security-fixes)

  """
  @spec disable_automated_security_fixes(String.t(), String.t(), keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def disable_automated_security_fixes(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :disable_automated_security_fixes},
      url: "/repos/#{owner}/#{repo}/automated-security-fixes",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Disable Git LFS for a repository

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/repos#disable-git-lfs-for-a-repository)

  """
  @spec disable_lfs_for_repo(String.t(), String.t(), keyword) :: :ok | {:error, GitHub.Error.t()}
  def disable_lfs_for_repo(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :disable_lfs_for_repo},
      url: "/repos/#{owner}/#{repo}/lfs",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Disable vulnerability alerts

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/repos#disable-vulnerability-alerts)

  """
  @spec disable_vulnerability_alerts(String.t(), String.t(), keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def disable_vulnerability_alerts(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :disable_vulnerability_alerts},
      url: "/repos/#{owner}/#{repo}/vulnerability-alerts",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Download a repository archive (tar)

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/repos#download-a-repository-archive)

  """
  @spec download_tarball_archive(String.t(), String.t(), String.t(), keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def download_tarball_archive(owner, repo, ref, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, ref: ref],
      call: {GitHub.Repos, :download_tarball_archive},
      url: "/repos/#{owner}/#{repo}/tarball/#{ref}",
      method: :get,
      response: [{302, nil}],
      opts: opts
    })
  end

  @doc """
  Download a repository archive (zip)

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/repos#download-a-repository-archive)

  """
  @spec download_zipball_archive(String.t(), String.t(), String.t(), keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def download_zipball_archive(owner, repo, ref, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, ref: ref],
      call: {GitHub.Repos, :download_zipball_archive},
      url: "/repos/#{owner}/#{repo}/zipball/#{ref}",
      method: :get,
      response: [{302, nil}],
      opts: opts
    })
  end

  @doc """
  Enable automated security fixes

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/repos#enable-automated-security-fixes)

  """
  @spec enable_automated_security_fixes(String.t(), String.t(), keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def enable_automated_security_fixes(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :enable_automated_security_fixes},
      url: "/repos/#{owner}/#{repo}/automated-security-fixes",
      method: :put,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Enable Git LFS for a repository

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/repos#enable-git-lfs-for-a-repository)

  """
  @spec enable_lfs_for_repo(String.t(), String.t(), keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def enable_lfs_for_repo(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :enable_lfs_for_repo},
      url: "/repos/#{owner}/#{repo}/lfs",
      method: :put,
      response: [{202, :map}, {403, nil}],
      opts: opts
    })
  end

  @doc """
  Enable vulnerability alerts

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/repos#enable-vulnerability-alerts)

  """
  @spec enable_vulnerability_alerts(String.t(), String.t(), keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def enable_vulnerability_alerts(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :enable_vulnerability_alerts},
      url: "/repos/#{owner}/#{repo}/vulnerability-alerts",
      method: :put,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Generate release notes content for a release

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/repos#generate-release-notes)

  """
  @spec generate_release_notes(String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.Release.NotesContent.t()} | {:error, GitHub.Error.t()}
  def generate_release_notes(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :generate_release_notes},
      url: "/repos/#{owner}/#{repo}/releases/generate-notes",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, {GitHub.Release.NotesContent, :t}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a repository

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/repos#get-a-repository)

  """
  @spec get(String.t(), String.t(), keyword) ::
          {:ok, GitHub.Repository.full()} | {:error, GitHub.Error.t()}
  def get(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :get},
      url: "/repos/#{owner}/#{repo}",
      method: :get,
      response: [
        {200, {GitHub.Repository, :full}},
        {301, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get access restrictions

  ## Resources

    * [API method documentation](https://docs.github.com/rest/branches/branch-protection#get-access-restrictions)

  """
  @spec get_access_restrictions(String.t(), String.t(), String.t(), keyword) ::
          {:ok, GitHub.Branch.RestrictionPolicy.t()} | {:error, GitHub.Error.t()}
  def get_access_restrictions(owner, repo, branch, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, branch: branch],
      call: {GitHub.Repos, :get_access_restrictions},
      url: "/repos/#{owner}/#{repo}/branches/#{branch}/protection/restrictions",
      method: :get,
      response: [{200, {GitHub.Branch.RestrictionPolicy, :t}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Get admin branch protection

  ## Resources

    * [API method documentation](https://docs.github.com/rest/branches/branch-protection#get-admin-branch-protection)

  """
  @spec get_admin_branch_protection(String.t(), String.t(), String.t(), keyword) ::
          {:ok, GitHub.ProtectedBranch.AdminEnforced.t()} | {:error, GitHub.Error.t()}
  def get_admin_branch_protection(owner, repo, branch, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, branch: branch],
      call: {GitHub.Repos, :get_admin_branch_protection},
      url: "/repos/#{owner}/#{repo}/branches/#{branch}/protection/enforce_admins",
      method: :get,
      response: [{200, {GitHub.ProtectedBranch.AdminEnforced, :t}}],
      opts: opts
    })
  end

  @doc """
  List environments

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/deployments/environments#list-environments)

  """
  @spec get_all_environments(String.t(), String.t(), keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def get_all_environments(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :get_all_environments},
      url: "/repos/#{owner}/#{repo}/environments",
      method: :get,
      query: query,
      response: [{200, :map}],
      opts: opts
    })
  end

  @doc """
  Get all status check contexts

  ## Resources

    * [API method documentation](https://docs.github.com/rest/branches/branch-protection#get-all-status-check-contexts)

  """
  @spec get_all_status_check_contexts(String.t(), String.t(), String.t(), keyword) ::
          {:ok, [String.t()]} | {:error, GitHub.Error.t()}
  def get_all_status_check_contexts(owner, repo, branch, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, branch: branch],
      call: {GitHub.Repos, :get_all_status_check_contexts},
      url:
        "/repos/#{owner}/#{repo}/branches/#{branch}/protection/required_status_checks/contexts",
      method: :get,
      response: [{200, {:array, :string}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Get all repository topics

  ## Options

    * `page` (integer): Page number of the results to fetch.
    * `per_page` (integer): The number of results per page (max 100).

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/repos#get-all-repository-topics)

  """
  @spec get_all_topics(String.t(), String.t(), keyword) ::
          {:ok, GitHub.Topic.t()} | {:error, GitHub.Error.t()}
  def get_all_topics(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :get_all_topics},
      url: "/repos/#{owner}/#{repo}/topics",
      method: :get,
      query: query,
      response: [{200, {GitHub.Topic, :t}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Get apps with access to the protected branch

  ## Resources

    * [API method documentation](https://docs.github.com/rest/branches/branch-protection#list-apps-with-access-to-the-protected-branch)

  """
  @spec get_apps_with_access_to_protected_branch(String.t(), String.t(), String.t(), keyword) ::
          {:ok, [GitHub.Integration.t()]} | {:error, GitHub.Error.t()}
  def get_apps_with_access_to_protected_branch(owner, repo, branch, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, branch: branch],
      call: {GitHub.Repos, :get_apps_with_access_to_protected_branch},
      url: "/repos/#{owner}/#{repo}/branches/#{branch}/protection/restrictions/apps",
      method: :get,
      response: [{200, {:array, {GitHub.Integration, :t}}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Get an autolink reference of a repository

  ## Resources

    * [API method documentation](https://docs.github.com/rest/repos/autolinks#get-an-autolink-reference-of-a-repository)

  """
  @spec get_autolink(String.t(), String.t(), integer, keyword) ::
          {:ok, GitHub.Autolink.t()} | {:error, GitHub.Error.t()}
  def get_autolink(owner, repo, autolink_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, autolink_id: autolink_id],
      call: {GitHub.Repos, :get_autolink},
      url: "/repos/#{owner}/#{repo}/autolinks/#{autolink_id}",
      method: :get,
      response: [{200, {GitHub.Autolink, :t}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a branch

  ## Resources

    * [API method documentation](https://docs.github.com/rest/branches/branches#get-a-branch)

  """
  @spec get_branch(String.t(), String.t(), String.t(), keyword) ::
          {:ok, GitHub.Branch.WithProtection.t()} | {:error, GitHub.Error.t()}
  def get_branch(owner, repo, branch, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, branch: branch],
      call: {GitHub.Repos, :get_branch},
      url: "/repos/#{owner}/#{repo}/branches/#{branch}",
      method: :get,
      response: [
        {200, {GitHub.Branch.WithProtection, :t}},
        {301, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get branch protection

  ## Resources

    * [API method documentation](https://docs.github.com/rest/branches/branch-protection#get-branch-protection)

  """
  @spec get_branch_protection(String.t(), String.t(), String.t(), keyword) ::
          {:ok, GitHub.Branch.Protection.t()} | {:error, GitHub.Error.t()}
  def get_branch_protection(owner, repo, branch, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, branch: branch],
      call: {GitHub.Repos, :get_branch_protection},
      url: "/repos/#{owner}/#{repo}/branches/#{branch}/protection",
      method: :get,
      response: [{200, {GitHub.Branch.Protection, :t}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Get repository clones

  ## Options

    * `per` (String.t()): The time frame to display results for.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/metrics/traffic#get-repository-clones)

  """
  @spec get_clones(String.t(), String.t(), keyword) ::
          {:ok, GitHub.CloneTraffic.t()} | {:error, GitHub.Error.t()}
  def get_clones(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:per])

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :get_clones},
      url: "/repos/#{owner}/#{repo}/traffic/clones",
      method: :get,
      query: query,
      response: [{200, {GitHub.CloneTraffic, :t}}, {403, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Get the weekly commit activity

  ## Resources

    * [API method documentation](https://docs.github.com/rest/metrics/statistics#get-the-weekly-commit-activity)

  """
  @spec get_code_frequency_stats(String.t(), String.t(), keyword) ::
          {:ok, map | [[integer]]} | {:error, GitHub.Error.t()}
  def get_code_frequency_stats(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :get_code_frequency_stats},
      url: "/repos/#{owner}/#{repo}/stats/code_frequency",
      method: :get,
      response: [{200, {:array, {:array, :integer}}}, {202, :map}, {204, nil}],
      opts: opts
    })
  end

  @doc """
  Get repository permissions for a user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/collaborators/collaborators#get-repository-permissions-for-a-user)

  """
  @spec get_collaborator_permission_level(String.t(), String.t(), String.t(), keyword) ::
          {:ok, GitHub.Repository.CollaboratorPermission.t()} | {:error, GitHub.Error.t()}
  def get_collaborator_permission_level(owner, repo, username, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, username: username],
      call: {GitHub.Repos, :get_collaborator_permission_level},
      url: "/repos/#{owner}/#{repo}/collaborators/#{username}/permission",
      method: :get,
      response: [
        {200, {GitHub.Repository.CollaboratorPermission, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get the combined status for a specific reference

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/commits/statuses#get-the-combined-status-for-a-specific-reference)

  """
  @spec get_combined_status_for_ref(String.t(), String.t(), String.t(), keyword) ::
          {:ok, GitHub.CombinedCommitStatus.t()} | {:error, GitHub.Error.t()}
  def get_combined_status_for_ref(owner, repo, ref, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [owner: owner, repo: repo, ref: ref],
      call: {GitHub.Repos, :get_combined_status_for_ref},
      url: "/repos/#{owner}/#{repo}/commits/#{ref}/status",
      method: :get,
      query: query,
      response: [{200, {GitHub.CombinedCommitStatus, :t}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a commit

  ## Options

    * `page` (integer): Page number of the results to fetch.
    * `per_page` (integer): The number of results per page (max 100).

  ## Resources

    * [API method documentation](https://docs.github.com/rest/commits/commits#get-a-commit)

  """
  @spec get_commit(String.t(), String.t(), String.t(), keyword) ::
          {:ok, GitHub.Commit.t()} | {:error, GitHub.Error.t()}
  def get_commit(owner, repo, ref, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [owner: owner, repo: repo, ref: ref],
      call: {GitHub.Repos, :get_commit},
      url: "/repos/#{owner}/#{repo}/commits/#{ref}",
      method: :get,
      query: query,
      response: [
        {200, {GitHub.Commit, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}},
        {500, {GitHub.BasicError, :t}},
        {503, :map}
      ],
      opts: opts
    })
  end

  @doc """
  Get the last year of commit activity

  ## Resources

    * [API method documentation](https://docs.github.com/rest/metrics/statistics#get-the-last-year-of-commit-activity)

  """
  @spec get_commit_activity_stats(String.t(), String.t(), keyword) ::
          {:ok, map | [GitHub.Commit.Activity.t()]} | {:error, GitHub.Error.t()}
  def get_commit_activity_stats(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :get_commit_activity_stats},
      url: "/repos/#{owner}/#{repo}/stats/commit_activity",
      method: :get,
      response: [{200, {:array, {GitHub.Commit.Activity, :t}}}, {202, :map}, {204, nil}],
      opts: opts
    })
  end

  @doc """
  Get a commit comment

  ## Resources

    * [API method documentation](https://docs.github.com/rest/commits/comments#get-a-commit-comment)

  """
  @spec get_commit_comment(String.t(), String.t(), integer, keyword) ::
          {:ok, GitHub.Commit.Comment.t()} | {:error, GitHub.Error.t()}
  def get_commit_comment(owner, repo, comment_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, comment_id: comment_id],
      call: {GitHub.Repos, :get_commit_comment},
      url: "/repos/#{owner}/#{repo}/comments/#{comment_id}",
      method: :get,
      response: [{200, {GitHub.Commit.Comment, :t}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Get commit signature protection

  ## Resources

    * [API method documentation](https://docs.github.com/rest/branches/branch-protection#get-commit-signature-protection)

  """
  @spec get_commit_signature_protection(String.t(), String.t(), String.t(), keyword) ::
          {:ok, GitHub.ProtectedBranch.AdminEnforced.t()} | {:error, GitHub.Error.t()}
  def get_commit_signature_protection(owner, repo, branch, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, branch: branch],
      call: {GitHub.Repos, :get_commit_signature_protection},
      url: "/repos/#{owner}/#{repo}/branches/#{branch}/protection/required_signatures",
      method: :get,
      response: [
        {200, {GitHub.ProtectedBranch.AdminEnforced, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get community profile metrics

  ## Resources

    * [API method documentation](https://docs.github.com/rest/metrics/community#get-community-profile-metrics)

  """
  @spec get_community_profile_metrics(String.t(), String.t(), keyword) ::
          {:ok, GitHub.CommunityProfile.t()} | {:error, GitHub.Error.t()}
  def get_community_profile_metrics(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :get_community_profile_metrics},
      url: "/repos/#{owner}/#{repo}/community/profile",
      method: :get,
      response: [{200, {GitHub.CommunityProfile, :t}}],
      opts: opts
    })
  end

  @doc """
  Get repository content

  ## Options

    * `ref` (String.t()): The name of the commit/branch/tag. Default: the repository’s default branch (usually `master`)

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/repos#get-repository-content)

  """
  @spec get_content(String.t(), String.t(), String.t(), keyword) ::
          {:ok,
           GitHub.Content.File.t()
           | GitHub.Content.Submodule.t()
           | GitHub.Content.Symlink.t()
           | [map]}
          | {:error, GitHub.Error.t()}
  def get_content(owner, repo, path, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:ref])

    client.request(%{
      args: [owner: owner, repo: repo, path: path],
      call: {GitHub.Repos, :get_content},
      url: "/repos/#{owner}/#{repo}/contents/#{path}",
      method: :get,
      query: query,
      response: [
        {200,
         {:union,
          [
            {:array, :map},
            {GitHub.Content.File, :t},
            {GitHub.Content.Symlink, :t},
            {GitHub.Content.Submodule, :t}
          ]}},
        {302, nil},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get all contributor commit activity

  ## Resources

    * [API method documentation](https://docs.github.com/rest/metrics/statistics#get-all-contributor-commit-activity)

  """
  @spec get_contributors_stats(String.t(), String.t(), keyword) ::
          {:ok, map | [GitHub.ContributorActivity.t()]} | {:error, GitHub.Error.t()}
  def get_contributors_stats(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :get_contributors_stats},
      url: "/repos/#{owner}/#{repo}/stats/contributors",
      method: :get,
      response: [{200, {:array, {GitHub.ContributorActivity, :t}}}, {202, :map}, {204, nil}],
      opts: opts
    })
  end

  @doc """
  Get a deploy key

  ## Resources

    * [API method documentation](https://docs.github.com/rest/deploy-keys#get-a-deploy-key)

  """
  @spec get_deploy_key(String.t(), String.t(), integer, keyword) ::
          {:ok, GitHub.DeployKey.t()} | {:error, GitHub.Error.t()}
  def get_deploy_key(owner, repo, key_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, key_id: key_id],
      call: {GitHub.Repos, :get_deploy_key},
      url: "/repos/#{owner}/#{repo}/keys/#{key_id}",
      method: :get,
      response: [{200, {GitHub.DeployKey, :t}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a deployment

  ## Resources

    * [API method documentation](https://docs.github.com/rest/deployments/deployments#get-a-deployment)

  """
  @spec get_deployment(String.t(), String.t(), integer, keyword) ::
          {:ok, GitHub.Deployment.t()} | {:error, GitHub.Error.t()}
  def get_deployment(owner, repo, deployment_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, deployment_id: deployment_id],
      call: {GitHub.Repos, :get_deployment},
      url: "/repos/#{owner}/#{repo}/deployments/#{deployment_id}",
      method: :get,
      response: [{200, {GitHub.Deployment, :t}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a deployment branch policy

  ## Resources

    * [API method documentation](https://docs.github.com/rest/deployments/branch-policies#get-deployment-branch-policy)

  """
  @spec get_deployment_branch_policy(String.t(), String.t(), String.t(), integer, keyword) ::
          {:ok, GitHub.Deployment.BranchPolicy.t()} | {:error, GitHub.Error.t()}
  def get_deployment_branch_policy(owner, repo, environment_name, branch_policy_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [
        owner: owner,
        repo: repo,
        environment_name: environment_name,
        branch_policy_id: branch_policy_id
      ],
      call: {GitHub.Repos, :get_deployment_branch_policy},
      url:
        "/repos/#{owner}/#{repo}/environments/#{environment_name}/deployment-branch-policies/#{branch_policy_id}",
      method: :get,
      response: [{200, {GitHub.Deployment.BranchPolicy, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a deployment status

  ## Resources

    * [API method documentation](https://docs.github.com/rest/deployments/statuses#get-a-deployment-status)

  """
  @spec get_deployment_status(String.t(), String.t(), integer, integer, keyword) ::
          {:ok, GitHub.Deployment.Status.t()} | {:error, GitHub.Error.t()}
  def get_deployment_status(owner, repo, deployment_id, status_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, deployment_id: deployment_id, status_id: status_id],
      call: {GitHub.Repos, :get_deployment_status},
      url: "/repos/#{owner}/#{repo}/deployments/#{deployment_id}/statuses/#{status_id}",
      method: :get,
      response: [{200, {GitHub.Deployment.Status, :t}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Get an environment

  ## Resources

    * [API method documentation](https://docs.github.com/rest/deployments/environments#get-an-environment)

  """
  @spec get_environment(String.t(), String.t(), String.t(), keyword) ::
          {:ok, GitHub.Environment.t()} | {:error, GitHub.Error.t()}
  def get_environment(owner, repo, environment_name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, environment_name: environment_name],
      call: {GitHub.Repos, :get_environment},
      url: "/repos/#{owner}/#{repo}/environments/#{environment_name}",
      method: :get,
      response: [{200, {GitHub.Environment, :t}}],
      opts: opts
    })
  end

  @doc """
  Get latest Pages build

  ## Resources

    * [API method documentation](https://docs.github.com/rest/pages#get-latest-pages-build)

  """
  @spec get_latest_pages_build(String.t(), String.t(), keyword) ::
          {:ok, GitHub.Pages.Build.t()} | {:error, GitHub.Error.t()}
  def get_latest_pages_build(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :get_latest_pages_build},
      url: "/repos/#{owner}/#{repo}/pages/builds/latest",
      method: :get,
      response: [{200, {GitHub.Pages.Build, :t}}],
      opts: opts
    })
  end

  @doc """
  Get the latest release

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/repos#get-the-latest-release)

  """
  @spec get_latest_release(String.t(), String.t(), keyword) ::
          {:ok, GitHub.Release.t()} | {:error, GitHub.Error.t()}
  def get_latest_release(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :get_latest_release},
      url: "/repos/#{owner}/#{repo}/releases/latest",
      method: :get,
      response: [{200, {GitHub.Release, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a GitHub Pages site

  ## Resources

    * [API method documentation](https://docs.github.com/rest/pages#get-a-github-pages-site)

  """
  @spec get_pages(String.t(), String.t(), keyword) ::
          {:ok, GitHub.Page.t()} | {:error, GitHub.Error.t()}
  def get_pages(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :get_pages},
      url: "/repos/#{owner}/#{repo}/pages",
      method: :get,
      response: [{200, {GitHub.Page, :t}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Get GitHub Pages build

  ## Resources

    * [API method documentation](https://docs.github.com/rest/pages#get-github-pages-build)

  """
  @spec get_pages_build(String.t(), String.t(), integer, keyword) ::
          {:ok, GitHub.Pages.Build.t()} | {:error, GitHub.Error.t()}
  def get_pages_build(owner, repo, build_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, build_id: build_id],
      call: {GitHub.Repos, :get_pages_build},
      url: "/repos/#{owner}/#{repo}/pages/builds/#{build_id}",
      method: :get,
      response: [{200, {GitHub.Pages.Build, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a DNS health check for GitHub Pages

  ## Resources

    * [API method documentation](https://docs.github.com/rest/pages#get-a-dns-health-check-for-github-pages)

  """
  @spec get_pages_health_check(String.t(), String.t(), keyword) ::
          {:ok, GitHub.EmptyObject.t() | GitHub.Pages.HealthCheck.t()}
          | {:error, GitHub.Error.t()}
  def get_pages_health_check(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :get_pages_health_check},
      url: "/repos/#{owner}/#{repo}/pages/health",
      method: :get,
      response: [
        {200, {GitHub.Pages.HealthCheck, :t}},
        {202, {GitHub.EmptyObject, :t}},
        {400, nil},
        {404, {GitHub.BasicError, :t}},
        {422, nil}
      ],
      opts: opts
    })
  end

  @doc """
  Get the weekly commit count

  ## Resources

    * [API method documentation](https://docs.github.com/rest/metrics/statistics#get-the-weekly-commit-count)

  """
  @spec get_participation_stats(String.t(), String.t(), keyword) ::
          {:ok, GitHub.ParticipationStats.t()} | {:error, GitHub.Error.t()}
  def get_participation_stats(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :get_participation_stats},
      url: "/repos/#{owner}/#{repo}/stats/participation",
      method: :get,
      response: [{200, {GitHub.ParticipationStats, :t}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Get pull request review protection

  ## Resources

    * [API method documentation](https://docs.github.com/rest/branches/branch-protection#get-pull-request-review-protection)

  """
  @spec get_pull_request_review_protection(String.t(), String.t(), String.t(), keyword) ::
          {:ok, GitHub.ProtectedBranch.PullRequestReview.t()} | {:error, GitHub.Error.t()}
  def get_pull_request_review_protection(owner, repo, branch, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, branch: branch],
      call: {GitHub.Repos, :get_pull_request_review_protection},
      url: "/repos/#{owner}/#{repo}/branches/#{branch}/protection/required_pull_request_reviews",
      method: :get,
      response: [{200, {GitHub.ProtectedBranch.PullRequestReview, :t}}],
      opts: opts
    })
  end

  @doc """
  Get the hourly commit count for each day

  ## Resources

    * [API method documentation](https://docs.github.com/rest/metrics/statistics#get-the-hourly-commit-count-for-each-day)

  """
  @spec get_punch_card_stats(String.t(), String.t(), keyword) ::
          {:ok, [[integer]]} | {:error, GitHub.Error.t()}
  def get_punch_card_stats(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :get_punch_card_stats},
      url: "/repos/#{owner}/#{repo}/stats/punch_card",
      method: :get,
      response: [{200, {:array, {:array, :integer}}}, {204, nil}],
      opts: opts
    })
  end

  @doc """
  Get a repository README

  ## Options

    * `ref` (String.t()): The name of the commit/branch/tag. Default: the repository’s default branch (usually `master`)

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/repos#get-a-repository-readme)

  """
  @spec get_readme(String.t(), String.t(), keyword) ::
          {:ok, GitHub.Content.File.t()} | {:error, GitHub.Error.t()}
  def get_readme(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:ref])

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :get_readme},
      url: "/repos/#{owner}/#{repo}/readme",
      method: :get,
      query: query,
      response: [
        {200, {GitHub.Content.File, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get a repository README for a directory

  ## Options

    * `ref` (String.t()): The name of the commit/branch/tag. Default: the repository’s default branch (usually `master`)

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/repos#get-a-repository-directory-readme)

  """
  @spec get_readme_in_directory(String.t(), String.t(), String.t(), keyword) ::
          {:ok, GitHub.Content.File.t()} | {:error, GitHub.Error.t()}
  def get_readme_in_directory(owner, repo, dir, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:ref])

    client.request(%{
      args: [owner: owner, repo: repo, dir: dir],
      call: {GitHub.Repos, :get_readme_in_directory},
      url: "/repos/#{owner}/#{repo}/readme/#{dir}",
      method: :get,
      query: query,
      response: [
        {200, {GitHub.Content.File, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get a release

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/repos#get-a-release)

  """
  @spec get_release(String.t(), String.t(), integer, keyword) ::
          {:ok, GitHub.Release.t()} | {:error, GitHub.Error.t()}
  def get_release(owner, repo, release_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, release_id: release_id],
      call: {GitHub.Repos, :get_release},
      url: "/repos/#{owner}/#{repo}/releases/#{release_id}",
      method: :get,
      response: [{200, {GitHub.Release, :t}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a release asset

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/repos#get-a-release-asset)

  """
  @spec get_release_asset(String.t(), String.t(), integer, keyword) ::
          {:ok, GitHub.Release.Asset.t()} | {:error, GitHub.Error.t()}
  def get_release_asset(owner, repo, asset_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, asset_id: asset_id],
      call: {GitHub.Repos, :get_release_asset},
      url: "/repos/#{owner}/#{repo}/releases/assets/#{asset_id}",
      method: :get,
      response: [{200, {GitHub.Release.Asset, :t}}, {302, nil}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a release by tag name

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/repos#get-a-release-by-tag-name)

  """
  @spec get_release_by_tag(String.t(), String.t(), String.t(), keyword) ::
          {:ok, GitHub.Release.t()} | {:error, GitHub.Error.t()}
  def get_release_by_tag(owner, repo, tag, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, tag: tag],
      call: {GitHub.Repos, :get_release_by_tag},
      url: "/repos/#{owner}/#{repo}/releases/tags/#{tag}",
      method: :get,
      response: [{200, {GitHub.Release, :t}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Get status checks protection

  ## Resources

    * [API method documentation](https://docs.github.com/rest/branches/branch-protection#get-status-checks-protection)

  """
  @spec get_status_checks_protection(String.t(), String.t(), String.t(), keyword) ::
          {:ok, GitHub.StatusCheckPolicy.t()} | {:error, GitHub.Error.t()}
  def get_status_checks_protection(owner, repo, branch, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, branch: branch],
      call: {GitHub.Repos, :get_status_checks_protection},
      url: "/repos/#{owner}/#{repo}/branches/#{branch}/protection/required_status_checks",
      method: :get,
      response: [{200, {GitHub.StatusCheckPolicy, :t}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Get teams with access to the protected branch

  ## Resources

    * [API method documentation](https://docs.github.com/rest/branches/branch-protection#list-teams-with-access-to-the-protected-branch)

  """
  @spec get_teams_with_access_to_protected_branch(String.t(), String.t(), String.t(), keyword) ::
          {:ok, [GitHub.Team.t()]} | {:error, GitHub.Error.t()}
  def get_teams_with_access_to_protected_branch(owner, repo, branch, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, branch: branch],
      call: {GitHub.Repos, :get_teams_with_access_to_protected_branch},
      url: "/repos/#{owner}/#{repo}/branches/#{branch}/protection/restrictions/teams",
      method: :get,
      response: [{200, {:array, {GitHub.Team, :t}}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Get top referral paths

  ## Resources

    * [API method documentation](https://docs.github.com/rest/metrics/traffic#get-top-referral-paths)

  """
  @spec get_top_paths(String.t(), String.t(), keyword) ::
          {:ok, [GitHub.Content.Traffic.t()]} | {:error, GitHub.Error.t()}
  def get_top_paths(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :get_top_paths},
      url: "/repos/#{owner}/#{repo}/traffic/popular/paths",
      method: :get,
      response: [{200, {:array, {GitHub.Content.Traffic, :t}}}, {403, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Get top referral sources

  ## Resources

    * [API method documentation](https://docs.github.com/rest/metrics/traffic#get-top-referral-sources)

  """
  @spec get_top_referrers(String.t(), String.t(), keyword) ::
          {:ok, [GitHub.ReferrerTraffic.t()]} | {:error, GitHub.Error.t()}
  def get_top_referrers(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :get_top_referrers},
      url: "/repos/#{owner}/#{repo}/traffic/popular/referrers",
      method: :get,
      response: [{200, {:array, {GitHub.ReferrerTraffic, :t}}}, {403, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Get users with access to the protected branch

  ## Resources

    * [API method documentation](https://docs.github.com/rest/branches/branch-protection#list-users-with-access-to-the-protected-branch)

  """
  @spec get_users_with_access_to_protected_branch(String.t(), String.t(), String.t(), keyword) ::
          {:ok, [GitHub.User.simple()]} | {:error, GitHub.Error.t()}
  def get_users_with_access_to_protected_branch(owner, repo, branch, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, branch: branch],
      call: {GitHub.Repos, :get_users_with_access_to_protected_branch},
      url: "/repos/#{owner}/#{repo}/branches/#{branch}/protection/restrictions/users",
      method: :get,
      response: [{200, {:array, {GitHub.User, :simple}}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Get page views

  ## Options

    * `per` (String.t()): The time frame to display results for.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/metrics/traffic#get-page-views)

  """
  @spec get_views(String.t(), String.t(), keyword) ::
          {:ok, GitHub.ViewTraffic.t()} | {:error, GitHub.Error.t()}
  def get_views(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:per])

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :get_views},
      url: "/repos/#{owner}/#{repo}/traffic/views",
      method: :get,
      query: query,
      response: [{200, {GitHub.ViewTraffic, :t}}, {403, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a repository webhook

  ## Resources

    * [API method documentation](https://docs.github.com/rest/webhooks/repos#get-a-repository-webhook)

  """
  @spec get_webhook(String.t(), String.t(), integer, keyword) ::
          {:ok, GitHub.Hook.t()} | {:error, GitHub.Error.t()}
  def get_webhook(owner, repo, hook_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, hook_id: hook_id],
      call: {GitHub.Repos, :get_webhook},
      url: "/repos/#{owner}/#{repo}/hooks/#{hook_id}",
      method: :get,
      response: [{200, {GitHub.Hook, :t}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a webhook configuration for a repository

  ## Resources

    * [API method documentation](https://docs.github.com/rest/webhooks/repo-config#get-a-webhook-configuration-for-a-repository)

  """
  @spec get_webhook_config_for_repo(String.t(), String.t(), integer, keyword) ::
          {:ok, GitHub.Webhook.Config.t()} | {:error, GitHub.Error.t()}
  def get_webhook_config_for_repo(owner, repo, hook_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, hook_id: hook_id],
      call: {GitHub.Repos, :get_webhook_config_for_repo},
      url: "/repos/#{owner}/#{repo}/hooks/#{hook_id}/config",
      method: :get,
      response: [{200, {GitHub.Webhook.Config, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a delivery for a repository webhook

  ## Resources

    * [API method documentation](https://docs.github.com/rest/webhooks/repo-deliveries#get-a-delivery-for-a-repository-webhook)

  """
  @spec get_webhook_delivery(String.t(), String.t(), integer, integer, keyword) ::
          {:ok, GitHub.Hook.Delivery.t()} | {:error, GitHub.Error.t()}
  def get_webhook_delivery(owner, repo, hook_id, delivery_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, hook_id: hook_id, delivery_id: delivery_id],
      call: {GitHub.Repos, :get_webhook_delivery},
      url: "/repos/#{owner}/#{repo}/hooks/#{hook_id}/deliveries/#{delivery_id}",
      method: :get,
      response: [
        {200, {GitHub.Hook.Delivery, :t}},
        {400, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List all autolinks of a repository

  ## Options

    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/repos/autolinks#list-all-autolinks-of-a-repository)

  """
  @spec list_autolinks(String.t(), String.t(), keyword) ::
          {:ok, [GitHub.Autolink.t()]} | {:error, GitHub.Error.t()}
  def list_autolinks(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page])

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :list_autolinks},
      url: "/repos/#{owner}/#{repo}/autolinks",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.Autolink, :t}}}],
      opts: opts
    })
  end

  @doc """
  List branches

  ## Options

    * `protected` (boolean): Setting to `true` returns only protected branches. When set to `false`, only unprotected branches are returned. Omitting this parameter returns all branches.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/branches/branches#list-branches)

  """
  @spec list_branches(String.t(), String.t(), keyword) ::
          {:ok, [GitHub.ShortBranch.t()]} | {:error, GitHub.Error.t()}
  def list_branches(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page, :protected])

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :list_branches},
      url: "/repos/#{owner}/#{repo}/branches",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.ShortBranch, :t}}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  List branches for HEAD commit

  ## Resources

    * [API method documentation](https://docs.github.com/rest/commits/commits#list-branches-for-head-commit)

  """
  @spec list_branches_for_head_commit(String.t(), String.t(), String.t(), keyword) ::
          {:ok, [GitHub.Branch.Short.t()]} | {:error, GitHub.Error.t()}
  def list_branches_for_head_commit(owner, repo, commit_sha, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, commit_sha: commit_sha],
      call: {GitHub.Repos, :list_branches_for_head_commit},
      url: "/repos/#{owner}/#{repo}/commits/#{commit_sha}/branches-where-head",
      method: :get,
      response: [{200, {:array, {GitHub.Branch.Short, :t}}}, {422, {GitHub.ValidationError, :t}}],
      opts: opts
    })
  end

  @doc """
  List repository collaborators

  ## Options

    * `affiliation` (String.t()): Filter collaborators returned by their affiliation. `outside` means all outside collaborators of an organization-owned repository. `direct` means all collaborators with permissions to an organization-owned repository, regardless of organization membership status. `all` means all collaborators the authenticated user can see.
    * `permission` (String.t()): Filter collaborators by the permissions they have on the repository. If not specified, all collaborators will be returned.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/collaborators/collaborators#list-repository-collaborators)

  """
  @spec list_collaborators(String.t(), String.t(), keyword) ::
          {:ok, [GitHub.Collaborator.t()]} | {:error, GitHub.Error.t()}
  def list_collaborators(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:affiliation, :page, :per_page, :permission])

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :list_collaborators},
      url: "/repos/#{owner}/#{repo}/collaborators",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.Collaborator, :t}}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  List commit comments

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/commits/comments#list-commit-comments)

  """
  @spec list_comments_for_commit(String.t(), String.t(), String.t(), keyword) ::
          {:ok, [GitHub.Commit.Comment.t()]} | {:error, GitHub.Error.t()}
  def list_comments_for_commit(owner, repo, commit_sha, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [owner: owner, repo: repo, commit_sha: commit_sha],
      call: {GitHub.Repos, :list_comments_for_commit},
      url: "/repos/#{owner}/#{repo}/commits/#{commit_sha}/comments",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.Commit.Comment, :t}}}],
      opts: opts
    })
  end

  @doc """
  List commit comments for a repository

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/commits/comments#list-commit-comments-for-a-repository)

  """
  @spec list_commit_comments_for_repo(String.t(), String.t(), keyword) ::
          {:ok, [GitHub.Commit.Comment.t()]} | {:error, GitHub.Error.t()}
  def list_commit_comments_for_repo(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :list_commit_comments_for_repo},
      url: "/repos/#{owner}/#{repo}/comments",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.Commit.Comment, :t}}}],
      opts: opts
    })
  end

  @doc """
  List commit statuses for a reference

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/commits/statuses#list-commit-statuses-for-a-reference)

  """
  @spec list_commit_statuses_for_ref(String.t(), String.t(), String.t(), keyword) ::
          {:ok, [GitHub.Status.t()]} | {:error, GitHub.Error.t()}
  def list_commit_statuses_for_ref(owner, repo, ref, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [owner: owner, repo: repo, ref: ref],
      call: {GitHub.Repos, :list_commit_statuses_for_ref},
      url: "/repos/#{owner}/#{repo}/commits/#{ref}/statuses",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.Status, :t}}}, {301, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  List commits

  ## Options

    * `sha` (String.t()): SHA or branch to start listing commits from. Default: the repository’s default branch (usually `main`).
    * `path` (String.t()): Only commits containing this file path will be returned.
    * `author` (String.t()): GitHub login or email address by which to filter by commit author.
    * `since` (String.t()): Only show notifications updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    * `until` (String.t()): Only commits before this date will be returned. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/commits/commits#list-commits)

  """
  @spec list_commits(String.t(), String.t(), keyword) ::
          {:ok, [GitHub.Commit.t()]} | {:error, GitHub.Error.t()}
  def list_commits(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:author, :page, :path, :per_page, :sha, :since, :until])

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :list_commits},
      url: "/repos/#{owner}/#{repo}/commits",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.Commit, :t}}},
        {400, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {409, {GitHub.BasicError, :t}},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List repository contributors

  ## Options

    * `anon` (String.t()): Set to `1` or `true` to include anonymous contributors in results.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/repos#list-repository-contributors)

  """
  @spec list_contributors(String.t(), String.t(), keyword) ::
          {:ok, [GitHub.Contributor.t()]} | {:error, GitHub.Error.t()}
  def list_contributors(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:anon, :page, :per_page])

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :list_contributors},
      url: "/repos/#{owner}/#{repo}/contributors",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.Contributor, :t}}},
        {204, nil},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List deploy keys

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/deploy-keys#list-deploy-keys)

  """
  @spec list_deploy_keys(String.t(), String.t(), keyword) ::
          {:ok, [GitHub.DeployKey.t()]} | {:error, GitHub.Error.t()}
  def list_deploy_keys(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :list_deploy_keys},
      url: "/repos/#{owner}/#{repo}/keys",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.DeployKey, :t}}}],
      opts: opts
    })
  end

  @doc """
  List deployment branch policies

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/deployments/branch-policies#list-deployment-branch-policies)

  """
  @spec list_deployment_branch_policies(String.t(), String.t(), String.t(), keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def list_deployment_branch_policies(owner, repo, environment_name, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [owner: owner, repo: repo, environment_name: environment_name],
      call: {GitHub.Repos, :list_deployment_branch_policies},
      url: "/repos/#{owner}/#{repo}/environments/#{environment_name}/deployment-branch-policies",
      method: :get,
      query: query,
      response: [{200, :map}],
      opts: opts
    })
  end

  @doc """
  List deployment statuses

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/deployments/statuses#list-deployment-statuses)

  """
  @spec list_deployment_statuses(String.t(), String.t(), integer, keyword) ::
          {:ok, [GitHub.Deployment.Status.t()]} | {:error, GitHub.Error.t()}
  def list_deployment_statuses(owner, repo, deployment_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [owner: owner, repo: repo, deployment_id: deployment_id],
      call: {GitHub.Repos, :list_deployment_statuses},
      url: "/repos/#{owner}/#{repo}/deployments/#{deployment_id}/statuses",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.Deployment.Status, :t}}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  List deployments

  ## Options

    * `sha` (String.t()): The SHA recorded at creation time.
    * `ref` (String.t()): The name of the ref. This can be a branch, tag, or SHA.
    * `task` (String.t()): The name of the task for the deployment (e.g., `deploy` or `deploy:migrations`).
    * `environment` (String.t() | nil): The name of the environment that was deployed to (e.g., `staging` or `production`).
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/deployments/deployments#list-deployments)

  """
  @spec list_deployments(String.t(), String.t(), keyword) ::
          {:ok, [GitHub.Deployment.t()]} | {:error, GitHub.Error.t()}
  def list_deployments(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:environment, :page, :per_page, :ref, :sha, :task])

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :list_deployments},
      url: "/repos/#{owner}/#{repo}/deployments",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.Deployment, :t}}}],
      opts: opts
    })
  end

  @doc """
  List repositories for the authenticated user

  ## Options

    * `visibility` (String.t()): Limit results to repositories with the specified visibility.
    * `affiliation` (String.t()): Comma-separated list of values. Can include:  
   * `owner`: Repositories that are owned by the authenticated user.  
   * `collaborator`: Repositories that the user has been added to as a collaborator.  
   * `organization_member`: Repositories that the user has access to through being a member of an organization. This includes every repository on every team that the user is on.
    * `type` (String.t()): Limit results to repositories of the specified type. Will cause a `422` error if used in the same request as **visibility** or **affiliation**.
    * `sort` (String.t()): The property to sort the results by.
    * `direction` (String.t()): The order to sort by. Default: `asc` when using `full_name`, otherwise `desc`.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.
    * `since` (String.t()): Only show notifications updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    * `before` (String.t()): Only show notifications updated before the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/repos#list-repositories-for-the-authenticated-user)

  """
  @spec list_for_authenticated_user(keyword) ::
          {:ok, [GitHub.Repository.t()]} | {:error, GitHub.Error.t()}
  def list_for_authenticated_user(opts \\ []) do
    client = opts[:client] || @default_client

    query =
      Keyword.take(opts, [
        :affiliation,
        :before,
        :direction,
        :page,
        :per_page,
        :since,
        :sort,
        :type,
        :visibility
      ])

    client.request(%{
      call: {GitHub.Repos, :list_for_authenticated_user},
      url: "/user/repos",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.Repository, :t}}},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List organization repositories

  ## Options

    * `type` (String.t()): Specifies the types of repositories you want returned.
    * `sort` (String.t()): The property to sort the results by.
    * `direction` (String.t()): The order to sort by. Default: `asc` when using `full_name`, otherwise `desc`.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/repos#list-organization-repositories)

  """
  @spec list_for_org(String.t(), keyword) ::
          {:ok, [GitHub.MinimalRepository.t()]} | {:error, GitHub.Error.t()}
  def list_for_org(org, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:direction, :page, :per_page, :sort, :type])

    client.request(%{
      args: [org: org],
      call: {GitHub.Repos, :list_for_org},
      url: "/orgs/#{org}/repos",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.MinimalRepository, :t}}}],
      opts: opts
    })
  end

  @doc """
  List repositories for a user

  ## Options

    * `type` (String.t()): Limit results to repositories of the specified type.
    * `sort` (String.t()): The property to sort the results by.
    * `direction` (String.t()): The order to sort by. Default: `asc` when using `full_name`, otherwise `desc`.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/repos#list-repositories-for-a-user)

  """
  @spec list_for_user(String.t(), keyword) ::
          {:ok, [GitHub.MinimalRepository.t()]} | {:error, GitHub.Error.t()}
  def list_for_user(username, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:direction, :page, :per_page, :sort, :type])

    client.request(%{
      args: [username: username],
      call: {GitHub.Repos, :list_for_user},
      url: "/users/#{username}/repos",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.MinimalRepository, :t}}}],
      opts: opts
    })
  end

  @doc """
  List forks

  ## Options

    * `sort` (String.t()): The sort order. `stargazers` will sort by star count.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/repos#list-forks)

  """
  @spec list_forks(String.t(), String.t(), keyword) ::
          {:ok, [GitHub.MinimalRepository.t()]} | {:error, GitHub.Error.t()}
  def list_forks(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page, :sort])

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :list_forks},
      url: "/repos/#{owner}/#{repo}/forks",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.MinimalRepository, :t}}}, {400, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  List repository invitations

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/collaborators/invitations#list-repository-invitations)

  """
  @spec list_invitations(String.t(), String.t(), keyword) ::
          {:ok, [GitHub.Repository.Invitation.t()]} | {:error, GitHub.Error.t()}
  def list_invitations(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :list_invitations},
      url: "/repos/#{owner}/#{repo}/invitations",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.Repository.Invitation, :t}}}],
      opts: opts
    })
  end

  @doc """
  List repository invitations for the authenticated user

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/collaborators/invitations#list-repository-invitations-for-the-authenticated-user)

  """
  @spec list_invitations_for_authenticated_user(keyword) ::
          {:ok, [GitHub.Repository.Invitation.t()]} | {:error, GitHub.Error.t()}
  def list_invitations_for_authenticated_user(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      call: {GitHub.Repos, :list_invitations_for_authenticated_user},
      url: "/user/repository_invitations",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.Repository.Invitation, :t}}},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List repository languages

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/repos#list-repository-languages)

  """
  @spec list_languages(String.t(), String.t(), keyword) ::
          {:ok, GitHub.Language.t()} | {:error, GitHub.Error.t()}
  def list_languages(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :list_languages},
      url: "/repos/#{owner}/#{repo}/languages",
      method: :get,
      response: [{200, {GitHub.Language, :t}}],
      opts: opts
    })
  end

  @doc """
  List GitHub Pages builds

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/pages#list-github-pages-builds)

  """
  @spec list_pages_builds(String.t(), String.t(), keyword) ::
          {:ok, [GitHub.Pages.Build.t()]} | {:error, GitHub.Error.t()}
  def list_pages_builds(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :list_pages_builds},
      url: "/repos/#{owner}/#{repo}/pages/builds",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.Pages.Build, :t}}}],
      opts: opts
    })
  end

  @doc """
  List public repositories

  ## Options

    * `since` (integer): A repository ID. Only return repositories with an ID greater than this ID.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/repos#list-public-repositories)

  """
  @spec list_public(keyword) :: {:ok, [GitHub.MinimalRepository.t()]} | {:error, GitHub.Error.t()}
  def list_public(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:since])

    client.request(%{
      call: {GitHub.Repos, :list_public},
      url: "/repositories",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.MinimalRepository, :t}}},
        {304, nil},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List pull requests associated with a commit

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/commits/commits#list-pull-requests-associated-with-a-commit)

  """
  @spec list_pull_requests_associated_with_commit(String.t(), String.t(), String.t(), keyword) ::
          {:ok, [GitHub.PullRequest.simple()]} | {:error, GitHub.Error.t()}
  def list_pull_requests_associated_with_commit(owner, repo, commit_sha, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [owner: owner, repo: repo, commit_sha: commit_sha],
      call: {GitHub.Repos, :list_pull_requests_associated_with_commit},
      url: "/repos/#{owner}/#{repo}/commits/#{commit_sha}/pulls",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.PullRequest, :simple}}}],
      opts: opts
    })
  end

  @doc """
  List release assets

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/repos#list-release-assets)

  """
  @spec list_release_assets(String.t(), String.t(), integer, keyword) ::
          {:ok, [GitHub.Release.Asset.t()]} | {:error, GitHub.Error.t()}
  def list_release_assets(owner, repo, release_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [owner: owner, repo: repo, release_id: release_id],
      call: {GitHub.Repos, :list_release_assets},
      url: "/repos/#{owner}/#{repo}/releases/#{release_id}/assets",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.Release.Asset, :t}}}],
      opts: opts
    })
  end

  @doc """
  List releases

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/repos#list-releases)

  """
  @spec list_releases(String.t(), String.t(), keyword) ::
          {:ok, [GitHub.Release.t()]} | {:error, GitHub.Error.t()}
  def list_releases(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :list_releases},
      url: "/repos/#{owner}/#{repo}/releases",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.Release, :t}}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  List tag protection states for a repository

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/repos#list-tag-protection-state-of-a-repository)

  """
  @spec list_tag_protection(String.t(), String.t(), keyword) ::
          {:ok, [GitHub.TagProtection.t()]} | {:error, GitHub.Error.t()}
  def list_tag_protection(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :list_tag_protection},
      url: "/repos/#{owner}/#{repo}/tags/protection",
      method: :get,
      response: [
        {200, {:array, {GitHub.TagProtection, :t}}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List repository tags

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/repos#list-repository-tags)

  """
  @spec list_tags(String.t(), String.t(), keyword) ::
          {:ok, [GitHub.Tag.t()]} | {:error, GitHub.Error.t()}
  def list_tags(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :list_tags},
      url: "/repos/#{owner}/#{repo}/tags",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.Tag, :t}}}],
      opts: opts
    })
  end

  @doc """
  List repository teams

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/repos#list-repository-teams)

  """
  @spec list_teams(String.t(), String.t(), keyword) ::
          {:ok, [GitHub.Team.t()]} | {:error, GitHub.Error.t()}
  def list_teams(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :list_teams},
      url: "/repos/#{owner}/#{repo}/teams",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.Team, :t}}}],
      opts: opts
    })
  end

  @doc """
  List deliveries for a repository webhook

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `cursor` (String.t()): Used for pagination: the starting delivery from which the page of deliveries is fetched. Refer to the `link` header for the next and previous page cursors.
    * `redelivery` (boolean): 

  ## Resources

    * [API method documentation](https://docs.github.com/rest/webhooks/repo-deliveries#list-deliveries-for-a-repository-webhook)

  """
  @spec list_webhook_deliveries(String.t(), String.t(), integer, keyword) ::
          {:ok, [GitHub.Hook.DeliveryItem.t()]} | {:error, GitHub.Error.t()}
  def list_webhook_deliveries(owner, repo, hook_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:cursor, :per_page, :redelivery])

    client.request(%{
      args: [owner: owner, repo: repo, hook_id: hook_id],
      call: {GitHub.Repos, :list_webhook_deliveries},
      url: "/repos/#{owner}/#{repo}/hooks/#{hook_id}/deliveries",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.Hook.DeliveryItem, :t}}},
        {400, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List repository webhooks

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/webhooks/repos#list-repository-webhooks)

  """
  @spec list_webhooks(String.t(), String.t(), keyword) ::
          {:ok, [GitHub.Hook.t()]} | {:error, GitHub.Error.t()}
  def list_webhooks(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :list_webhooks},
      url: "/repos/#{owner}/#{repo}/hooks",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.Hook, :t}}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Merge a branch

  ## Resources

    * [API method documentation](https://docs.github.com/rest/branches/branches#merge-a-branch)

  """
  @spec merge(String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.Commit.t()} | {:error, GitHub.Error.t()}
  def merge(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :merge},
      url: "/repos/#{owner}/#{repo}/merges",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {201, {GitHub.Commit, :t}},
        {204, nil},
        {403, {GitHub.BasicError, :t}},
        {404, nil},
        {409, nil},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Sync a fork branch with the upstream repository

  ## Resources

    * [API method documentation](https://docs.github.com/rest/branches/branches#sync-a-fork-branch-with-the-upstream-repository)

  """
  @spec merge_upstream(String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.MergedUpstream.t()} | {:error, GitHub.Error.t()}
  def merge_upstream(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :merge_upstream},
      url: "/repos/#{owner}/#{repo}/merge-upstream",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, {GitHub.MergedUpstream, :t}}, {409, nil}, {422, nil}],
      opts: opts
    })
  end

  @doc """
  Ping a repository webhook

  ## Resources

    * [API method documentation](https://docs.github.com/rest/webhooks/repos#ping-a-repository-webhook)

  """
  @spec ping_webhook(String.t(), String.t(), integer, keyword) :: :ok | {:error, GitHub.Error.t()}
  def ping_webhook(owner, repo, hook_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, hook_id: hook_id],
      call: {GitHub.Repos, :ping_webhook},
      url: "/repos/#{owner}/#{repo}/hooks/#{hook_id}/pings",
      method: :post,
      response: [{204, nil}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Redeliver a delivery for a repository webhook

  ## Resources

    * [API method documentation](https://docs.github.com/rest/webhooks/repo-deliveries#redeliver-a-delivery-for-a-repository-webhook)

  """
  @spec redeliver_webhook_delivery(String.t(), String.t(), integer, integer, keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def redeliver_webhook_delivery(owner, repo, hook_id, delivery_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, hook_id: hook_id, delivery_id: delivery_id],
      call: {GitHub.Repos, :redeliver_webhook_delivery},
      url: "/repos/#{owner}/#{repo}/hooks/#{hook_id}/deliveries/#{delivery_id}/attempts",
      method: :post,
      response: [{202, :map}, {400, {GitHub.BasicError, :t}}, {422, {GitHub.ValidationError, :t}}],
      opts: opts
    })
  end

  @doc """
  Remove app access restrictions

  ## Resources

    * [API method documentation](https://docs.github.com/rest/branches/branch-protection#remove-app-access-restrictions)

  """
  @spec remove_app_access_restrictions(
          String.t(),
          String.t(),
          String.t(),
          map | [String.t()],
          keyword
        ) :: {:ok, [GitHub.Integration.t()]} | {:error, GitHub.Error.t()}
  def remove_app_access_restrictions(owner, repo, branch, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, branch: branch],
      call: {GitHub.Repos, :remove_app_access_restrictions},
      url: "/repos/#{owner}/#{repo}/branches/#{branch}/protection/restrictions/apps",
      body: body,
      method: :delete,
      request: [{"application/json", {:union, [:map, array: :string]}}],
      response: [{200, {:array, {GitHub.Integration, :t}}}, {422, {GitHub.ValidationError, :t}}],
      opts: opts
    })
  end

  @doc """
  Remove a repository collaborator

  ## Resources

    * [API method documentation](https://docs.github.com/rest/collaborators/collaborators#remove-a-repository-collaborator)

  """
  @spec remove_collaborator(String.t(), String.t(), String.t(), keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def remove_collaborator(owner, repo, username, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, username: username],
      call: {GitHub.Repos, :remove_collaborator},
      url: "/repos/#{owner}/#{repo}/collaborators/#{username}",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Remove status check contexts

  ## Resources

    * [API method documentation](https://docs.github.com/rest/branches/branch-protection#remove-status-check-contexts)

  """
  @spec remove_status_check_contexts(
          String.t(),
          String.t(),
          String.t(),
          map | [String.t()],
          keyword
        ) :: {:ok, [String.t()]} | {:error, GitHub.Error.t()}
  def remove_status_check_contexts(owner, repo, branch, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, branch: branch],
      call: {GitHub.Repos, :remove_status_check_contexts},
      url:
        "/repos/#{owner}/#{repo}/branches/#{branch}/protection/required_status_checks/contexts",
      body: body,
      method: :delete,
      request: [{"application/json", {:union, [:map, array: :string]}}],
      response: [
        {200, {:array, :string}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Remove status check protection

  ## Resources

    * [API method documentation](https://docs.github.com/rest/branches/branch-protection#remove-status-check-protection)

  """
  @spec remove_status_check_protection(String.t(), String.t(), String.t(), keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def remove_status_check_protection(owner, repo, branch, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, branch: branch],
      call: {GitHub.Repos, :remove_status_check_protection},
      url: "/repos/#{owner}/#{repo}/branches/#{branch}/protection/required_status_checks",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Remove team access restrictions

  ## Resources

    * [API method documentation](https://docs.github.com/rest/branches/branch-protection#remove-team-access-restrictions)

  """
  @spec remove_team_access_restrictions(
          String.t(),
          String.t(),
          String.t(),
          map | [String.t()],
          keyword
        ) :: {:ok, [GitHub.Team.t()]} | {:error, GitHub.Error.t()}
  def remove_team_access_restrictions(owner, repo, branch, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, branch: branch],
      call: {GitHub.Repos, :remove_team_access_restrictions},
      url: "/repos/#{owner}/#{repo}/branches/#{branch}/protection/restrictions/teams",
      body: body,
      method: :delete,
      request: [{"application/json", {:union, [:map, array: :string]}}],
      response: [{200, {:array, {GitHub.Team, :t}}}, {422, {GitHub.ValidationError, :t}}],
      opts: opts
    })
  end

  @doc """
  Remove user access restrictions

  ## Resources

    * [API method documentation](https://docs.github.com/rest/branches/branch-protection#remove-user-access-restrictions)

  """
  @spec remove_user_access_restrictions(
          String.t(),
          String.t(),
          String.t(),
          map | [String.t()],
          keyword
        ) :: {:ok, [GitHub.User.simple()]} | {:error, GitHub.Error.t()}
  def remove_user_access_restrictions(owner, repo, branch, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, branch: branch],
      call: {GitHub.Repos, :remove_user_access_restrictions},
      url: "/repos/#{owner}/#{repo}/branches/#{branch}/protection/restrictions/users",
      body: body,
      method: :delete,
      request: [{"application/json", {:union, [:map, array: :string]}}],
      response: [{200, {:array, {GitHub.User, :simple}}}, {422, {GitHub.ValidationError, :t}}],
      opts: opts
    })
  end

  @doc """
  Rename a branch

  ## Resources

    * [API method documentation](https://docs.github.com/rest/branches/branches#rename-a-branch)

  """
  @spec rename_branch(String.t(), String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.Branch.WithProtection.t()} | {:error, GitHub.Error.t()}
  def rename_branch(owner, repo, branch, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, branch: branch],
      call: {GitHub.Repos, :rename_branch},
      url: "/repos/#{owner}/#{repo}/branches/#{branch}/rename",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {201, {GitHub.Branch.WithProtection, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Replace all repository topics

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/repos#replace-all-repository-topics)

  """
  @spec replace_all_topics(String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.Topic.t()} | {:error, GitHub.Error.t()}
  def replace_all_topics(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :replace_all_topics},
      url: "/repos/#{owner}/#{repo}/topics",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [
        {200, {GitHub.Topic, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :simple}}
      ],
      opts: opts
    })
  end

  @doc """
  Request a GitHub Pages build

  ## Resources

    * [API method documentation](https://docs.github.com/rest/pages#request-a-github-pages-build)

  """
  @spec request_pages_build(String.t(), String.t(), keyword) ::
          {:ok, GitHub.Pages.BuildStatus.t()} | {:error, GitHub.Error.t()}
  def request_pages_build(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :request_pages_build},
      url: "/repos/#{owner}/#{repo}/pages/builds",
      method: :post,
      response: [{201, {GitHub.Pages.BuildStatus, :t}}],
      opts: opts
    })
  end

  @doc """
  Set admin branch protection

  ## Resources

    * [API method documentation](https://docs.github.com/rest/branches/branch-protection#set-admin-branch-protection)

  """
  @spec set_admin_branch_protection(String.t(), String.t(), String.t(), keyword) ::
          {:ok, GitHub.ProtectedBranch.AdminEnforced.t()} | {:error, GitHub.Error.t()}
  def set_admin_branch_protection(owner, repo, branch, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, branch: branch],
      call: {GitHub.Repos, :set_admin_branch_protection},
      url: "/repos/#{owner}/#{repo}/branches/#{branch}/protection/enforce_admins",
      method: :post,
      response: [{200, {GitHub.ProtectedBranch.AdminEnforced, :t}}],
      opts: opts
    })
  end

  @doc """
  Set app access restrictions

  ## Resources

    * [API method documentation](https://docs.github.com/rest/branches/branch-protection#set-app-access-restrictions)

  """
  @spec set_app_access_restrictions(
          String.t(),
          String.t(),
          String.t(),
          map | [String.t()],
          keyword
        ) :: {:ok, [GitHub.Integration.t()]} | {:error, GitHub.Error.t()}
  def set_app_access_restrictions(owner, repo, branch, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, branch: branch],
      call: {GitHub.Repos, :set_app_access_restrictions},
      url: "/repos/#{owner}/#{repo}/branches/#{branch}/protection/restrictions/apps",
      body: body,
      method: :put,
      request: [{"application/json", {:union, [:map, array: :string]}}],
      response: [{200, {:array, {GitHub.Integration, :t}}}, {422, {GitHub.ValidationError, :t}}],
      opts: opts
    })
  end

  @doc """
  Set status check contexts

  ## Resources

    * [API method documentation](https://docs.github.com/rest/branches/branch-protection#set-status-check-contexts)

  """
  @spec set_status_check_contexts(String.t(), String.t(), String.t(), map | [String.t()], keyword) ::
          {:ok, [String.t()]} | {:error, GitHub.Error.t()}
  def set_status_check_contexts(owner, repo, branch, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, branch: branch],
      call: {GitHub.Repos, :set_status_check_contexts},
      url:
        "/repos/#{owner}/#{repo}/branches/#{branch}/protection/required_status_checks/contexts",
      body: body,
      method: :put,
      request: [{"application/json", {:union, [:map, array: :string]}}],
      response: [
        {200, {:array, :string}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Set team access restrictions

  ## Resources

    * [API method documentation](https://docs.github.com/rest/branches/branch-protection#set-team-access-restrictions)

  """
  @spec set_team_access_restrictions(
          String.t(),
          String.t(),
          String.t(),
          map | [String.t()],
          keyword
        ) :: {:ok, [GitHub.Team.t()]} | {:error, GitHub.Error.t()}
  def set_team_access_restrictions(owner, repo, branch, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, branch: branch],
      call: {GitHub.Repos, :set_team_access_restrictions},
      url: "/repos/#{owner}/#{repo}/branches/#{branch}/protection/restrictions/teams",
      body: body,
      method: :put,
      request: [{"application/json", {:union, [:map, array: :string]}}],
      response: [{200, {:array, {GitHub.Team, :t}}}, {422, {GitHub.ValidationError, :t}}],
      opts: opts
    })
  end

  @doc """
  Set user access restrictions

  ## Resources

    * [API method documentation](https://docs.github.com/rest/branches/branch-protection#set-user-access-restrictions)

  """
  @spec set_user_access_restrictions(
          String.t(),
          String.t(),
          String.t(),
          map | [String.t()],
          keyword
        ) :: {:ok, [GitHub.User.simple()]} | {:error, GitHub.Error.t()}
  def set_user_access_restrictions(owner, repo, branch, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, branch: branch],
      call: {GitHub.Repos, :set_user_access_restrictions},
      url: "/repos/#{owner}/#{repo}/branches/#{branch}/protection/restrictions/users",
      body: body,
      method: :put,
      request: [{"application/json", {:union, [:map, array: :string]}}],
      response: [{200, {:array, {GitHub.User, :simple}}}, {422, {GitHub.ValidationError, :t}}],
      opts: opts
    })
  end

  @doc """
  Test the push repository webhook

  ## Resources

    * [API method documentation](https://docs.github.com/rest/webhooks/repos#test-the-push-repository-webhook)

  """
  @spec test_push_webhook(String.t(), String.t(), integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def test_push_webhook(owner, repo, hook_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, hook_id: hook_id],
      call: {GitHub.Repos, :test_push_webhook},
      url: "/repos/#{owner}/#{repo}/hooks/#{hook_id}/tests",
      method: :post,
      response: [{204, nil}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Transfer a repository

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/repos#transfer-a-repository)

  """
  @spec transfer(String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.MinimalRepository.t()} | {:error, GitHub.Error.t()}
  def transfer(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :transfer},
      url: "/repos/#{owner}/#{repo}/transfer",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{202, {GitHub.MinimalRepository, :t}}],
      opts: opts
    })
  end

  @doc """
  Update a repository

  ## Resources

    * [API method documentation](https://docs.github.com/rest/repos/repos#update-a-repository)

  """
  @spec update(String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.Repository.full()} | {:error, GitHub.Error.t()}
  def update(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :update},
      url: "/repos/#{owner}/#{repo}",
      body: body,
      method: :patch,
      request: [{"application/json", :map}],
      response: [
        {200, {GitHub.Repository, :full}},
        {307, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Update branch protection

  ## Resources

    * [API method documentation](https://docs.github.com/rest/branches/branch-protection#update-branch-protection)

  """
  @spec update_branch_protection(String.t(), String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.ProtectedBranch.t()} | {:error, GitHub.Error.t()}
  def update_branch_protection(owner, repo, branch, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, branch: branch],
      call: {GitHub.Repos, :update_branch_protection},
      url: "/repos/#{owner}/#{repo}/branches/#{branch}/protection",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [
        {200, {GitHub.ProtectedBranch, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :simple}}
      ],
      opts: opts
    })
  end

  @doc """
  Update a commit comment

  ## Resources

    * [API method documentation](https://docs.github.com/rest/commits/comments#update-a-commit-comment)

  """
  @spec update_commit_comment(String.t(), String.t(), integer, map, keyword) ::
          {:ok, GitHub.Commit.Comment.t()} | {:error, GitHub.Error.t()}
  def update_commit_comment(owner, repo, comment_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, comment_id: comment_id],
      call: {GitHub.Repos, :update_commit_comment},
      url: "/repos/#{owner}/#{repo}/comments/#{comment_id}",
      body: body,
      method: :patch,
      request: [{"application/json", :map}],
      response: [{200, {GitHub.Commit.Comment, :t}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Update a deployment branch policy

  ## Resources

    * [API method documentation](https://docs.github.com/rest/deployments/branch-policies#update-deployment-branch-policy)

  """
  @spec update_deployment_branch_policy(
          String.t(),
          String.t(),
          String.t(),
          integer,
          GitHub.Deployment.BranchPolicyNamePattern.t(),
          keyword
        ) :: {:ok, GitHub.Deployment.BranchPolicy.t()} | {:error, GitHub.Error.t()}
  def update_deployment_branch_policy(
        owner,
        repo,
        environment_name,
        branch_policy_id,
        body,
        opts \\ []
      ) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [
        owner: owner,
        repo: repo,
        environment_name: environment_name,
        branch_policy_id: branch_policy_id
      ],
      call: {GitHub.Repos, :update_deployment_branch_policy},
      url:
        "/repos/#{owner}/#{repo}/environments/#{environment_name}/deployment-branch-policies/#{branch_policy_id}",
      body: body,
      method: :put,
      request: [{"application/json", {GitHub.Deployment.BranchPolicyNamePattern, :t}}],
      response: [{200, {GitHub.Deployment.BranchPolicy, :t}}],
      opts: opts
    })
  end

  @doc """
  Update information about a GitHub Pages site

  ## Resources

    * [API method documentation](https://docs.github.com/rest/pages#update-information-about-a-github-pages-site)

  """
  @spec update_information_about_pages_site(String.t(), String.t(), map, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def update_information_about_pages_site(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :update_information_about_pages_site},
      url: "/repos/#{owner}/#{repo}/pages",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [
        {204, nil},
        {400, {GitHub.BasicError, :t}},
        {409, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Update a repository invitation

  ## Resources

    * [API method documentation](https://docs.github.com/rest/collaborators/invitations#update-a-repository-invitation)

  """
  @spec update_invitation(String.t(), String.t(), integer, map, keyword) ::
          {:ok, GitHub.Repository.Invitation.t()} | {:error, GitHub.Error.t()}
  def update_invitation(owner, repo, invitation_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, invitation_id: invitation_id],
      call: {GitHub.Repos, :update_invitation},
      url: "/repos/#{owner}/#{repo}/invitations/#{invitation_id}",
      body: body,
      method: :patch,
      request: [{"application/json", :map}],
      response: [{200, {GitHub.Repository.Invitation, :t}}],
      opts: opts
    })
  end

  @doc """
  Update pull request review protection

  ## Resources

    * [API method documentation](https://docs.github.com/rest/branches/branch-protection#update-pull-request-review-protection)

  """
  @spec update_pull_request_review_protection(String.t(), String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.ProtectedBranch.PullRequestReview.t()} | {:error, GitHub.Error.t()}
  def update_pull_request_review_protection(owner, repo, branch, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, branch: branch],
      call: {GitHub.Repos, :update_pull_request_review_protection},
      url: "/repos/#{owner}/#{repo}/branches/#{branch}/protection/required_pull_request_reviews",
      body: body,
      method: :patch,
      request: [{"application/json", :map}],
      response: [
        {200, {GitHub.ProtectedBranch.PullRequestReview, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Update a release

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/repos#update-a-release)

  """
  @spec update_release(String.t(), String.t(), integer, map, keyword) ::
          {:ok, GitHub.Release.t()} | {:error, GitHub.Error.t()}
  def update_release(owner, repo, release_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, release_id: release_id],
      call: {GitHub.Repos, :update_release},
      url: "/repos/#{owner}/#{repo}/releases/#{release_id}",
      body: body,
      method: :patch,
      request: [{"application/json", :map}],
      response: [{200, {GitHub.Release, :t}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Update a release asset

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/repos#update-a-release-asset)

  """
  @spec update_release_asset(String.t(), String.t(), integer, map, keyword) ::
          {:ok, GitHub.Release.Asset.t()} | {:error, GitHub.Error.t()}
  def update_release_asset(owner, repo, asset_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, asset_id: asset_id],
      call: {GitHub.Repos, :update_release_asset},
      url: "/repos/#{owner}/#{repo}/releases/assets/#{asset_id}",
      body: body,
      method: :patch,
      request: [{"application/json", :map}],
      response: [{200, {GitHub.Release.Asset, :t}}],
      opts: opts
    })
  end

  @doc """
  Update status check protection

  ## Resources

    * [API method documentation](https://docs.github.com/rest/branches/branch-protection#update-status-check-protection)

  """
  @spec update_status_check_protection(String.t(), String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.StatusCheckPolicy.t()} | {:error, GitHub.Error.t()}
  def update_status_check_protection(owner, repo, branch, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, branch: branch],
      call: {GitHub.Repos, :update_status_check_protection},
      url: "/repos/#{owner}/#{repo}/branches/#{branch}/protection/required_status_checks",
      body: body,
      method: :patch,
      request: [{"application/json", :map}],
      response: [
        {200, {GitHub.StatusCheckPolicy, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Update a repository webhook

  ## Resources

    * [API method documentation](https://docs.github.com/rest/webhooks/repos#update-a-repository-webhook)

  """
  @spec update_webhook(String.t(), String.t(), integer, map, keyword) ::
          {:ok, GitHub.Hook.t()} | {:error, GitHub.Error.t()}
  def update_webhook(owner, repo, hook_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, hook_id: hook_id],
      call: {GitHub.Repos, :update_webhook},
      url: "/repos/#{owner}/#{repo}/hooks/#{hook_id}",
      body: body,
      method: :patch,
      request: [{"application/json", :map}],
      response: [
        {200, {GitHub.Hook, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Update a webhook configuration for a repository

  ## Resources

    * [API method documentation](https://docs.github.com/rest/webhooks/repo-config#update-a-webhook-configuration-for-a-repository)

  """
  @spec update_webhook_config_for_repo(String.t(), String.t(), integer, map, keyword) ::
          {:ok, GitHub.Webhook.Config.t()} | {:error, GitHub.Error.t()}
  def update_webhook_config_for_repo(owner, repo, hook_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, hook_id: hook_id],
      call: {GitHub.Repos, :update_webhook_config_for_repo},
      url: "/repos/#{owner}/#{repo}/hooks/#{hook_id}/config",
      body: body,
      method: :patch,
      request: [{"application/json", :map}],
      response: [{200, {GitHub.Webhook.Config, :t}}],
      opts: opts
    })
  end

  @doc """
  Upload a release asset

  ## Options

    * `name` (String.t()): 
    * `label` (String.t()): 

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/repos#upload-a-release-asset)

  """
  @spec upload_release_asset(String.t(), String.t(), integer, String.t(), keyword) ::
          {:ok, GitHub.Release.Asset.t()} | {:error, GitHub.Error.t()}
  def upload_release_asset(owner, repo, release_id, body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:label, :name])

    client.request(%{
      args: [owner: owner, repo: repo, release_id: release_id],
      call: {GitHub.Repos, :upload_release_asset},
      url: "/repos/#{owner}/#{repo}/releases/#{release_id}/assets",
      body: body,
      method: :post,
      query: query,
      request: [{"application/octet-stream", :string}],
      response: [{201, {GitHub.Release.Asset, :t}}, {422, nil}],
      opts: opts
    })
  end
end
