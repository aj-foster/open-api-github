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
        {204, :null},
        {304, :null},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {409, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Add app access restrictions

  Protected branches are available in public repositories with GitHub Free and GitHub Free for organizations, and in public and private repositories with GitHub Pro, GitHub Team, GitHub Enterprise Cloud, and GitHub Enterprise Server. For more information, see [GitHub's products](https://docs.github.com/github/getting-started-with-github/githubs-products) in the GitHub Help documentation.

  Grants the specified apps push access for this branch. Only installed GitHub Apps with `write` access to the `contents` permission can be added as authorized actors on a protected branch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/branches/branch-protection#add-app-access-restrictions)

  """
  @spec add_app_access_restrictions(
          String.t(),
          String.t(),
          String.t(),
          map | [String.t()],
          keyword
        ) :: {:ok, [GitHub.App.t()]} | {:error, GitHub.Error.t()}
  def add_app_access_restrictions(owner, repo, branch, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, branch: branch, body: body],
      call: {GitHub.Repos, :add_app_access_restrictions},
      url: "/repos/#{owner}/#{repo}/branches/#{branch}/protection/restrictions/apps",
      body: body,
      method: :post,
      request: [{"application/json", {:union, [:map, [string: :generic]]}}],
      response: [{200, [{GitHub.App, :t}]}, {422, {GitHub.ValidationError, :t}}],
      opts: opts
    })
  end

  @doc """
  Add a repository collaborator

  This endpoint triggers [notifications](https://docs.github.com/github/managing-subscriptions-and-notifications-on-github/about-notifications). Creating content too quickly using this endpoint may result in secondary rate limiting. See "[Secondary rate limits](https://docs.github.com/rest/overview/resources-in-the-rest-api#secondary-rate-limits)" and "[Dealing with secondary rate limits](https://docs.github.com/rest/guides/best-practices-for-integrators#dealing-with-secondary-rate-limits)" for details.

  Adding an outside collaborator may be restricted by enterprise administrators. For more information, see "[Enforcing repository management policies in your enterprise](https://docs.github.com/admin/policies/enforcing-policies-for-your-enterprise/enforcing-repository-management-policies-in-your-enterprise#enforcing-a-policy-for-inviting-outside-collaborators-to-repositories)."

  For more information on permission levels, see "[Repository permission levels for an organization](https://docs.github.com/github/setting-up-and-managing-organizations-and-teams/repository-permission-levels-for-an-organization#permission-levels-for-repositories-owned-by-an-organization)". There are restrictions on which permissions can be granted to organization members when an organization base role is in place. In this case, the permission being given must be equal to or higher than the org base permission. Otherwise, the request will fail with:

  ```
  Cannot assign {member} permission of {role name}
  ```

  Note that, if you choose not to pass any parameters, you'll need to set `Content-Length` to zero when calling out to this endpoint. For more information, see "[HTTP verbs](https://docs.github.com/rest/overview/resources-in-the-rest-api#http-verbs)."

  The invitee will receive a notification that they have been invited to the repository, which they must accept or decline. They may do this via the notifications page, the email they receive, or by using the [API](https://docs.github.com/rest/collaborators/invitations).

  **Updating an existing collaborator's permission level**

  The endpoint can also be used to change the permissions of an existing collaborator without first removing and re-adding the collaborator. To change the permissions, use the same endpoint and pass a different `permission` parameter. The response will be a `204`, with no other indication that the permission level changed.

  **Rate limits**

  You are limited to sending 50 invitations to a repository per 24 hour period. Note there is no limit if you are inviting organization members to an organization repository.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/collaborators/collaborators#add-a-repository-collaborator)

  """
  @spec add_collaborator(String.t(), String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.Repository.Invitation.t()} | {:error, GitHub.Error.t()}
  def add_collaborator(owner, repo, username, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, username: username, body: body],
      call: {GitHub.Repos, :add_collaborator},
      url: "/repos/#{owner}/#{repo}/collaborators/#{username}",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [
        {201, {GitHub.Repository.Invitation, :t}},
        {204, :null},
        {403, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Add status check contexts

  Protected branches are available in public repositories with GitHub Free and GitHub Free for organizations, and in public and private repositories with GitHub Pro, GitHub Team, GitHub Enterprise Cloud, and GitHub Enterprise Server. For more information, see [GitHub's products](https://docs.github.com/github/getting-started-with-github/githubs-products) in the GitHub Help documentation.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/branches/branch-protection#add-status-check-contexts)

  """
  @spec add_status_check_contexts(String.t(), String.t(), String.t(), map | [String.t()], keyword) ::
          {:ok, [String.t()]} | {:error, GitHub.Error.t()}
  def add_status_check_contexts(owner, repo, branch, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, branch: branch, body: body],
      call: {GitHub.Repos, :add_status_check_contexts},
      url:
        "/repos/#{owner}/#{repo}/branches/#{branch}/protection/required_status_checks/contexts",
      body: body,
      method: :post,
      request: [{"application/json", {:union, [:map, [string: :generic]]}}],
      response: [
        {200, [string: :generic]},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Add team access restrictions

  Protected branches are available in public repositories with GitHub Free and GitHub Free for organizations, and in public and private repositories with GitHub Pro, GitHub Team, GitHub Enterprise Cloud, and GitHub Enterprise Server. For more information, see [GitHub's products](https://docs.github.com/github/getting-started-with-github/githubs-products) in the GitHub Help documentation.

  Grants the specified teams push access for this branch. You can also give push access to child teams.

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
      args: [owner: owner, repo: repo, branch: branch, body: body],
      call: {GitHub.Repos, :add_team_access_restrictions},
      url: "/repos/#{owner}/#{repo}/branches/#{branch}/protection/restrictions/teams",
      body: body,
      method: :post,
      request: [{"application/json", {:union, [:map, [string: :generic]]}}],
      response: [{200, [{GitHub.Team, :t}]}, {422, {GitHub.ValidationError, :t}}],
      opts: opts
    })
  end

  @doc """
  Add user access restrictions

  Protected branches are available in public repositories with GitHub Free and GitHub Free for organizations, and in public and private repositories with GitHub Pro, GitHub Team, GitHub Enterprise Cloud, and GitHub Enterprise Server. For more information, see [GitHub's products](https://docs.github.com/github/getting-started-with-github/githubs-products) in the GitHub Help documentation.

  Grants the specified people push access for this branch.

  | Type    | Description                                                                                                                   |
  | ------- | ----------------------------------------------------------------------------------------------------------------------------- |
  | `array` | Usernames for people who can have push access. **Note**: The list of users, apps, and teams in total is limited to 100 items. |

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
      args: [owner: owner, repo: repo, branch: branch, body: body],
      call: {GitHub.Repos, :add_user_access_restrictions},
      url: "/repos/#{owner}/#{repo}/branches/#{branch}/protection/restrictions/users",
      body: body,
      method: :post,
      request: [{"application/json", {:union, [:map, [string: :generic]]}}],
      response: [{200, [{GitHub.User, :simple}]}, {422, {GitHub.ValidationError, :t}}],
      opts: opts
    })
  end

  @doc """
  Check if automated security fixes are enabled for a repository

  Shows whether automated security fixes are enabled, disabled or paused for a repository. The authenticated user must have admin read access to the repository. For more information, see "[Configuring automated security fixes](https://docs.github.com/articles/configuring-automated-security-fixes)".

  ## Resources

    * [API method documentation](https://docs.github.com/rest/repos/repos#check-if-automated-security-fixes-are-enabled-for-a-repository)

  """
  @spec check_automated_security_fixes(String.t(), String.t(), keyword) ::
          {:ok, GitHub.Check.AutomatedSecurityFixes.t()} | {:error, GitHub.Error.t()}
  def check_automated_security_fixes(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :check_automated_security_fixes},
      url: "/repos/#{owner}/#{repo}/automated-security-fixes",
      method: :get,
      response: [{200, {GitHub.Check.AutomatedSecurityFixes, :t}}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Check if a user is a repository collaborator

  For organization-owned repositories, the list of collaborators includes outside collaborators, organization members that are direct collaborators, organization members with access through team memberships, organization members with access through default organization permissions, and organization owners.

  Team members will include the members of child teams.

  You must authenticate using an access token with the `read:org` and `repo` scopes with push access to use this
  endpoint. GitHub Apps must have the `members` organization permission and `metadata` repository permission to use this
  endpoint.

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
      response: [{204, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Check if vulnerability alerts are enabled for a repository

  Shows whether dependency alerts are enabled or disabled for a repository. The authenticated user must have admin read access to the repository. For more information, see "[About security alerts for vulnerable dependencies](https://docs.github.com/articles/about-security-alerts-for-vulnerable-dependencies)".

  ## Resources

    * [API method documentation](https://docs.github.com/rest/repos/repos#check-if-vulnerability-alerts-are-enabled-for-a-repository)

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
      response: [{204, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  List CODEOWNERS errors

  List any syntax errors that are detected in the CODEOWNERS
  file.

  For more information about the correct CODEOWNERS syntax,
  see "[About code owners](https://docs.github.com/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-code-owners)."

  ## Options

    * `ref`: A branch, tag or commit name used to determine which version of the CODEOWNERS file to use. Default: the repository's default branch (e.g. `main`)

  ## Resources

    * [API method documentation](https://docs.github.com/rest/repos/repos#list-codeowners-errors)

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
      response: [{200, {GitHub.CodeownersErrors, :t}}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Compare two commits

  Compares two commits against one another. You can compare branches in the same repository, or you can compare branches that exist in different repositories within the same repository network, including fork branches. For more information about how to view a repository's network, see "[Understanding connections between repositories](https://docs.github.com/repositories/viewing-activity-and-data-for-your-repository/understanding-connections-between-repositories)."

  This endpoint is equivalent to running the `git log BASE..HEAD` command, but it returns commits in a different order. The `git log BASE..HEAD` command returns commits in reverse chronological order, whereas the API returns commits in chronological order. You can pass the appropriate [media type](https://docs.github.com/rest/overview/media-types/#commits-commit-comparison-and-pull-requests) to fetch diff and patch formats.

  The API response includes details about the files that were changed between the two commits. This includes the status of the change (if a file was added, removed, modified, or renamed), and details of the change itself. For example, files with a `renamed` status have a `previous_filename` field showing the previous filename of the file, and files with a `modified` status have a `patch` field showing the changes made to the file.

  When calling this endpoint without any paging parameter (`per_page` or `page`), the returned list is limited to 250 commits, and the last commit in the list is the most recent of the entire comparison.

  **Working with large comparisons**

  To process a response with a large number of commits, use a query parameter (`per_page` or `page`) to paginate the results. When using pagination:

  - The list of changed files is only shown on the first page of results, but it includes all changed files for the entire comparison.
  - The results are returned in chronological order, but the last commit in the returned list may not be the most recent one in the entire set if there are more pages of results.

  For more information on working with pagination, see "[Using pagination in the REST API](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api)."

  **Signature verification object**

  The response will include a `verification` object that describes the result of verifying the commit's signature. The `verification` object includes the following fields:

  | Name | Type | Description |
  | ---- | ---- | ----------- |
  | `verified` | `boolean` | Indicates whether GitHub considers the signature in this commit to be verified. |
  | `reason` | `string` | The reason for verified value. Possible values and their meanings are enumerated in table below. |
  | `signature` | `string` | The signature that was extracted from the commit. |
  | `payload` | `string` | The value that was signed. |

  These are the possible values for `reason` in the `verification` object:

  | Value | Description |
  | ----- | ----------- |
  | `expired_key` | The key that made the signature is expired. |
  | `not_signing_key` | The "signing" flag is not among the usage flags in the GPG key that made the signature. |
  | `gpgverify_error` | There was an error communicating with the signature verification service. |
  | `gpgverify_unavailable` | The signature verification service is currently unavailable. |
  | `unsigned` | The object does not include a signature. |
  | `unknown_signature_type` | A non-PGP signature was found in the commit. |
  | `no_user` | No user was associated with the `committer` email address in the commit. |
  | `unverified_email` | The `committer` email address in the commit was associated with a user, but the email address is not verified on their account. |
  | `bad_email` | The `committer` email address in the commit is not included in the identities of the PGP key that made the signature. |
  | `unknown_key` | The key that made the signature has not been registered with any user's account. |
  | `malformed_signature` | There was an error parsing the signature. |
  | `invalid` | The signature could not be cryptographically verified using the key whose key-id was found in the signature. |
  | `valid` | None of the above errors applied, so the signature is considered to be verified. |

  ## Options

    * `page`: Page number of the results to fetch.
    * `per_page`: The number of results per page (max 100).

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

  Users with admin access to the repository can create an autolink.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/repos/autolinks#create-an-autolink-reference-for-a-repository)

  """
  @spec create_autolink(String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.Autolink.t()} | {:error, GitHub.Error.t()}
  def create_autolink(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, body: body],
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

  Create a comment for a commit using its `:commit_sha`.

  This endpoint triggers [notifications](https://docs.github.com/github/managing-subscriptions-and-notifications-on-github/about-notifications). Creating content too quickly using this endpoint may result in secondary rate limiting. See "[Secondary rate limits](https://docs.github.com/rest/overview/resources-in-the-rest-api#secondary-rate-limits)" and "[Dealing with secondary rate limits](https://docs.github.com/rest/guides/best-practices-for-integrators#dealing-with-secondary-rate-limits)" for details.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/commits/comments#create-a-commit-comment)

  """
  @spec create_commit_comment(String.t(), String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.Commit.Comment.t()} | {:error, GitHub.Error.t()}
  def create_commit_comment(owner, repo, commit_sha, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, commit_sha: commit_sha, body: body],
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

  Protected branches are available in public repositories with GitHub Free and GitHub Free for organizations, and in public and private repositories with GitHub Pro, GitHub Team, GitHub Enterprise Cloud, and GitHub Enterprise Server. For more information, see [GitHub's products](https://docs.github.com/github/getting-started-with-github/githubs-products) in the GitHub Help documentation.

  When authenticated with admin or owner permissions to the repository, you can use this endpoint to require signed commits on a branch. You must enable branch protection to require signed commits.

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

  Users with push access in a repository can create commit statuses for a given SHA.

  Note: there is a limit of 1000 statuses per `sha` and `context` within a repository. Attempts to create more than 1000 statuses will result in a validation error.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/commits/statuses#create-a-commit-status)

  """
  @spec create_commit_status(String.t(), String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.Status.t()} | {:error, GitHub.Error.t()}
  def create_commit_status(owner, repo, sha, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, sha: sha, body: body],
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

  You can create a read-only deploy key.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/deploy-keys/deploy-keys#create-a-deploy-key)

  """
  @spec create_deploy_key(String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.DeployKey.t()} | {:error, GitHub.Error.t()}
  def create_deploy_key(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, body: body],
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

  Deployments offer a few configurable parameters with certain defaults.

  The `ref` parameter can be any named branch, tag, or SHA. At GitHub we often deploy branches and verify them
  before we merge a pull request.

  The `environment` parameter allows deployments to be issued to different runtime environments. Teams often have
  multiple environments for verifying their applications, such as `production`, `staging`, and `qa`. This parameter
  makes it easier to track which environments have requested deployments. The default environment is `production`.

  The `auto_merge` parameter is used to ensure that the requested ref is not behind the repository's default branch. If
  the ref _is_ behind the default branch for the repository, we will attempt to merge it for you. If the merge succeeds,
  the API will return a successful merge commit. If merge conflicts prevent the merge from succeeding, the API will
  return a failure response.

  By default, [commit statuses](https://docs.github.com/rest/commits/statuses) for every submitted context must be in a `success`
  state. The `required_contexts` parameter allows you to specify a subset of contexts that must be `success`, or to
  specify contexts that have not yet been submitted. You are not required to use commit statuses to deploy. If you do
  not require any contexts or create any commit statuses, the deployment will always succeed.

  The `payload` parameter is available for any extra information that a deployment system might need. It is a JSON text
  field that will be passed on when a deployment event is dispatched.

  The `task` parameter is used by the deployment system to allow different execution paths. In the web world this might
  be `deploy:migrations` to run schema changes on the system. In the compiled world this could be a flag to compile an
  application with debugging enabled.

  Users with `repo` or `repo_deployment` scopes can create a deployment for a given ref.

  Merged branch response:

  You will see this response when GitHub automatically merges the base branch into the topic branch instead of creating
  a deployment. This auto-merge happens when:
  *   Auto-merge option is enabled in the repository
  *   Topic branch does not include the latest changes on the base branch, which is `master` in the response example
  *   There are no merge conflicts

  If there are no new commits in the base branch, a new request to create a deployment should give a successful
  response.

  Merge conflict response:

  This error happens when the `auto_merge` option is enabled and when the default branch (in this case `master`), can't
  be merged into the branch that's being deployed (in this case `topic-branch`), due to merge conflicts.

  Failed commit status checks:

  This error happens when the `required_contexts` parameter indicates that one or more contexts need to have a `success`
  status for the commit to be deployed, but one or more of the required contexts do not have a state of `success`.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/deployments/deployments#create-a-deployment)

  """
  @spec create_deployment(String.t(), String.t(), map, keyword) ::
          {:ok, map | GitHub.Deployment.t()} | {:error, GitHub.Error.t()}
  def create_deployment(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, body: body],
      call: {GitHub.Repos, :create_deployment},
      url: "/repos/#{owner}/#{repo}/deployments",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {201, {GitHub.Deployment, :t}},
        {202, :map},
        {409, :null},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Create a deployment branch policy

  Creates a deployment branch policy for an environment.

  You must authenticate using an access token with the `repo` scope to use this endpoint. GitHub Apps must have the `administration:write` permission for the repository to use this endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/deployments/branch-policies#create-a-deployment-branch-policy)

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
      args: [owner: owner, repo: repo, environment_name: environment_name, body: body],
      call: {GitHub.Repos, :create_deployment_branch_policy},
      url: "/repos/#{owner}/#{repo}/environments/#{environment_name}/deployment-branch-policies",
      body: body,
      method: :post,
      request: [{"application/json", {GitHub.Deployment.BranchPolicyNamePattern, :t}}],
      response: [{200, {GitHub.Deployment.BranchPolicy, :t}}, {303, :null}, {404, :null}],
      opts: opts
    })
  end

  @doc """
  Create a custom deployment protection rule on an environment

  Enable a custom deployment protection rule for an environment.

  You must authenticate using an access token with the `repo` scope to use this endpoint. Enabling a custom protection rule requires admin or owner permissions to the repository. GitHub Apps must have the `actions:write` permission to use this endpoint.

  For more information about the app that is providing this custom deployment rule, see the [documentation for the `GET /apps/{app_slug}` endpoint](https://docs.github.com/rest/apps/apps#get-an-app).

  ## Resources

    * [API method documentation](https://docs.github.com/rest/deployments/protection-rules#create-a-custom-deployment-protection-rule-on-an-environment)

  """
  @spec create_deployment_protection_rule(String.t(), String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.Deployment.ProtectionRule.t()} | {:error, GitHub.Error.t()}
  def create_deployment_protection_rule(environment_name, repo, owner, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [environment_name: environment_name, repo: repo, owner: owner, body: body],
      call: {GitHub.Repos, :create_deployment_protection_rule},
      url: "/repos/#{owner}/#{repo}/environments/#{environment_name}/deployment_protection_rules",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{201, {GitHub.Deployment.ProtectionRule, :t}}],
      opts: opts
    })
  end

  @doc """
  Create a deployment status

  Users with `push` access can create deployment statuses for a given deployment.

  GitHub Apps require `read & write` access to "Deployments" and `read-only` access to "Repo contents" (for private repos). OAuth apps require the `repo_deployment` scope.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/deployments/statuses#create-a-deployment-status)

  """
  @spec create_deployment_status(String.t(), String.t(), integer, map, keyword) ::
          {:ok, GitHub.Deployment.Status.t()} | {:error, GitHub.Error.t()}
  def create_deployment_status(owner, repo, deployment_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, deployment_id: deployment_id, body: body],
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

  You can use this endpoint to trigger a webhook event called `repository_dispatch` when you want activity that happens outside of GitHub to trigger a GitHub Actions workflow or GitHub App webhook. You must configure your GitHub Actions workflow or GitHub App to run when the `repository_dispatch` event occurs. For an example `repository_dispatch` webhook payload, see "[RepositoryDispatchEvent](https://docs.github.com/webhooks/event-payloads/#repository_dispatch)."

  The `client_payload` parameter is available for any extra information that your workflow might need. This parameter is a JSON payload that will be passed on when the webhook event is dispatched. For example, the `client_payload` can include a message that a user would like to send using a GitHub Actions workflow. Or the `client_payload` can be used as a test to debug your workflow.

  This endpoint requires write access to the repository by providing either:

    - Personal access tokens with `repo` scope. For more information, see "[Creating a personal access token for the command line](https://docs.github.com/articles/creating-a-personal-access-token-for-the-command-line)" in the GitHub Help documentation.
    - GitHub Apps with both `metadata:read` and `contents:read&write` permissions.

  This input example shows how you can use the `client_payload` as a test to debug your workflow.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/repos/repos#create-a-repository-dispatch-event)

  """
  @spec create_dispatch_event(String.t(), String.t(), map, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def create_dispatch_event(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, body: body],
      call: {GitHub.Repos, :create_dispatch_event},
      url: "/repos/#{owner}/#{repo}/dispatches",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{204, :null}, {422, {GitHub.ValidationError, :t}}],
      opts: opts
    })
  end

  @doc """
  Create a repository for the authenticated user

  Creates a new repository for the authenticated user.

  **OAuth scope requirements**

  When using [OAuth](https://docs.github.com/apps/building-oauth-apps/understanding-scopes-for-oauth-apps/), authorizations must include:

  *   `public_repo` scope or `repo` scope to create a public repository. Note: For GitHub AE, use `repo` scope to create an internal repository.
  *   `repo` scope to create a private repository.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/repos/repos#create-a-repository-for-the-authenticated-user)

  """
  @spec create_for_authenticated_user(map, keyword) ::
          {:ok, GitHub.Repository.t()} | {:error, GitHub.Error.t()}
  def create_for_authenticated_user(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {GitHub.Repos, :create_for_authenticated_user},
      url: "/user/repos",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {201, {GitHub.Repository, :t}},
        {304, :null},
        {400, {:union, [{GitHub.BasicError, :t}, {GitHub.SCIM.Error, :t}]}},
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

  Create a fork for the authenticated user.

  **Note**: Forking a Repository happens asynchronously. You may have to wait a short period of time before you can access the git objects. If this takes longer than 5 minutes, be sure to contact [GitHub Support](https://support.github.com/contact?tags=dotcom-rest-api).

  **Note**: Although this endpoint works with GitHub Apps, the GitHub App must be installed on the destination account with access to all repositories and on the source account with access to the source repository.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/repos/forks#create-a-fork)

  """
  @spec create_fork(String.t(), String.t(), map | nil, keyword) ::
          {:ok, GitHub.Repository.full()} | {:error, GitHub.Error.t()}
  def create_fork(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, body: body],
      call: {GitHub.Repos, :create_fork},
      url: "/repos/#{owner}/#{repo}/forks",
      body: body,
      method: :post,
      request: [{"application/json", {:union, [:map, :null]}}],
      response: [
        {202, {GitHub.Repository, :full}},
        {400, {:union, [{GitHub.BasicError, :t}, {GitHub.SCIM.Error, :t}]}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Create an organization repository

  Creates a new repository in the specified organization. The authenticated user must be a member of the organization.

  **OAuth scope requirements**

  When using [OAuth](https://docs.github.com/apps/building-oauth-apps/understanding-scopes-for-oauth-apps/), authorizations must include:

  *   `public_repo` scope or `repo` scope to create a public repository. Note: For GitHub AE, use `repo` scope to create an internal repository.
  *   `repo` scope to create a private repository

  ## Resources

    * [API method documentation](https://docs.github.com/rest/repos/repos#create-an-organization-repository)

  """
  @spec create_in_org(String.t(), map, keyword) ::
          {:ok, GitHub.Repository.t()} | {:error, GitHub.Error.t()}
  def create_in_org(org, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, body: body],
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

  Create or update an environment with protection rules, such as required reviewers. For more information about environment protection rules, see "[Environments](https://docs.github.com/actions/reference/environments#environment-protection-rules)."

  **Note:** To create or update name patterns that branches must match in order to deploy to this environment, see "[Deployment branch policies](https://docs.github.com/rest/deployments/branch-policies)."

  **Note:** To create or update secrets for an environment, see "[GitHub Actions secrets](https://docs.github.com/rest/actions/secrets)."

  You must authenticate using an access token with the `repo` scope to use this endpoint. GitHub Apps must have the `administration:write` permission for the repository to use this endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/deployments/environments#create-or-update-an-environment)

  """
  @spec create_or_update_environment(String.t(), String.t(), String.t(), map | nil, keyword) ::
          {:ok, GitHub.Environment.t()} | {:error, GitHub.Error.t()}
  def create_or_update_environment(owner, repo, environment_name, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, environment_name: environment_name, body: body],
      call: {GitHub.Repos, :create_or_update_environment},
      url: "/repos/#{owner}/#{repo}/environments/#{environment_name}",
      body: body,
      method: :put,
      request: [{"application/json", {:union, [:map, :null]}}],
      response: [{200, {GitHub.Environment, :t}}, {422, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Create or update file contents

  Creates a new file or replaces an existing file in a repository. You must authenticate using an access token with the `repo` scope to use this endpoint. If you want to modify files in the `.github/workflows` directory, you must authenticate using an access token with the `workflow` scope.

  **Note:** If you use this endpoint and the "[Delete a file](https://docs.github.com/rest/repos/contents/#delete-a-file)" endpoint in parallel, the concurrent requests will conflict and you will receive errors. You must use these endpoints serially instead.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/repos/contents#create-or-update-file-contents)

  """
  @spec create_or_update_file_contents(String.t(), String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.FileCommit.t()} | {:error, GitHub.Error.t()}
  def create_or_update_file_contents(owner, repo, path, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, path: path, body: body],
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
  Create an organization repository ruleset

  Create a repository ruleset for an organization.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/rules#create-an-organization-repository-ruleset)

  """
  @spec create_org_ruleset(String.t(), map, keyword) ::
          {:ok, GitHub.Repository.Ruleset.t()} | {:error, GitHub.Error.t()}
  def create_org_ruleset(org, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, body: body],
      call: {GitHub.Repos, :create_org_ruleset},
      url: "/orgs/#{org}/rulesets",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {201, {GitHub.Repository.Ruleset, :t}},
        {404, {GitHub.BasicError, :t}},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Create a GitHub Pages deployment

  Create a GitHub Pages deployment for a repository.

  Users must have write permissions. GitHub Apps must have the `pages:write` permission to use this endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/pages/pages#create-a-github-pages-deployment)

  """
  @spec create_pages_deployment(String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.Pages.Deployment.t()} | {:error, GitHub.Error.t()}
  def create_pages_deployment(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, body: body],
      call: {GitHub.Repos, :create_pages_deployment},
      url: "/repos/#{owner}/#{repo}/pages/deployment",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {200, {GitHub.Pages.Deployment, :t}},
        {400, {:union, [{GitHub.BasicError, :t}, {GitHub.SCIM.Error, :t}]}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Create a GitHub Pages site

  Configures a GitHub Pages site. For more information, see "[About GitHub Pages](https://docs.github.com/github/working-with-github-pages/about-github-pages)."

  To use this endpoint, you must be a repository administrator, maintainer, or have the 'manage GitHub Pages settings' permission. A token with the `repo` scope or Pages write permission is required. GitHub Apps must have the `administration:write` and `pages:write` permissions.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/pages/pages#create-a-apiname-pages-site)

  """
  @spec create_pages_site(String.t(), String.t(), map | nil, keyword) ::
          {:ok, GitHub.Page.t()} | {:error, GitHub.Error.t()}
  def create_pages_site(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, body: body],
      call: {GitHub.Repos, :create_pages_site},
      url: "/repos/#{owner}/#{repo}/pages",
      body: body,
      method: :post,
      request: [{"application/json", {:union, [:map, :null]}}],
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

  Users with push access to the repository can create a release.

  This endpoint triggers [notifications](https://docs.github.com/github/managing-subscriptions-and-notifications-on-github/about-notifications). Creating content too quickly using this endpoint may result in secondary rate limiting. See "[Secondary rate limits](https://docs.github.com/rest/overview/resources-in-the-rest-api#secondary-rate-limits)" and "[Dealing with secondary rate limits](https://docs.github.com/rest/guides/best-practices-for-integrators#dealing-with-secondary-rate-limits)" for details.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/releases/releases#create-a-release)

  """
  @spec create_release(String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.Release.t()} | {:error, GitHub.Error.t()}
  def create_release(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, body: body],
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
  Create a repository ruleset

  Create a ruleset for a repository.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/repos/rules#create-a-repository-ruleset)

  """
  @spec create_repo_ruleset(String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.Repository.Ruleset.t()} | {:error, GitHub.Error.t()}
  def create_repo_ruleset(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, body: body],
      call: {GitHub.Repos, :create_repo_ruleset},
      url: "/repos/#{owner}/#{repo}/rulesets",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {201, {GitHub.Repository.Ruleset, :t}},
        {404, {GitHub.BasicError, :t}},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Create a tag protection state for a repository

  This creates a tag protection state for a repository.
  This endpoint is only available to repository administrators.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/repos/tags#create-a-tag-protection-state-for-a-repository)

  """
  @spec create_tag_protection(String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.TagProtection.t()} | {:error, GitHub.Error.t()}
  def create_tag_protection(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, body: body],
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

  Creates a new repository using a repository template. Use the `template_owner` and `template_repo` route parameters to specify the repository to use as the template. If the repository is not public, the authenticated user must own or be a member of an organization that owns the repository. To check if a repository is available to use as a template, get the repository's information using the [Get a repository](https://docs.github.com/rest/repos/repos#get-a-repository) endpoint and check that the `is_template` key is `true`.

  **OAuth scope requirements**

  When using [OAuth](https://docs.github.com/apps/building-oauth-apps/understanding-scopes-for-oauth-apps/), authorizations must include:

  *   `public_repo` scope or `repo` scope to create a public repository. Note: For GitHub AE, use `repo` scope to create an internal repository.
  *   `repo` scope to create a private repository

  ## Resources

    * [API method documentation](https://docs.github.com/rest/repos/repos#create-a-repository-using-a-template)

  """
  @spec create_using_template(String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.Repository.t()} | {:error, GitHub.Error.t()}
  def create_using_template(template_owner, template_repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [template_owner: template_owner, template_repo: template_repo, body: body],
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

  Repositories can have multiple webhooks installed. Each webhook should have a unique `config`. Multiple webhooks can
  share the same `config` as long as those webhooks do not have any `events` that overlap.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/webhooks/repos#create-a-repository-webhook)

  """
  @spec create_webhook(String.t(), String.t(), map | nil, keyword) ::
          {:ok, GitHub.Hook.t()} | {:error, GitHub.Error.t()}
  def create_webhook(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, body: body],
      call: {GitHub.Repos, :create_webhook},
      url: "/repos/#{owner}/#{repo}/hooks",
      body: body,
      method: :post,
      request: [{"application/json", {:union, [:map, :null]}}],
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
        {204, :null},
        {304, :null},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {409, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Delete a repository

  Deleting a repository requires admin access. If OAuth is used, the `delete_repo` scope is required.

  If an organization owner has configured the organization to prevent members from deleting organization-owned
  repositories, you will get a `403 Forbidden` response.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/repos/repos#delete-a-repository)

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
        {204, :null},
        {307, {GitHub.BasicError, :t}},
        {403, :map},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Delete access restrictions

  Protected branches are available in public repositories with GitHub Free and GitHub Free for organizations, and in public and private repositories with GitHub Pro, GitHub Team, GitHub Enterprise Cloud, and GitHub Enterprise Server. For more information, see [GitHub's products](https://docs.github.com/github/getting-started-with-github/githubs-products) in the GitHub Help documentation.

  Disables the ability to restrict who can push to this branch.

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
      response: [{204, :null}],
      opts: opts
    })
  end

  @doc """
  Delete admin branch protection

  Protected branches are available in public repositories with GitHub Free and GitHub Free for organizations, and in public and private repositories with GitHub Pro, GitHub Team, GitHub Enterprise Cloud, and GitHub Enterprise Server. For more information, see [GitHub's products](https://docs.github.com/github/getting-started-with-github/githubs-products) in the GitHub Help documentation.

  Removing admin enforcement requires admin or owner permissions to the repository and branch protection to be enabled.

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
      response: [{204, :null}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Delete an environment

  You must authenticate using an access token with the repo scope to use this endpoint.

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
      response: [{204, :null}],
      opts: opts
    })
  end

  @doc """
  Delete an autolink reference from a repository

  This deletes a single autolink reference by ID that was configured for the given repository.

  Information about autolinks are only available to repository administrators.

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
      response: [{204, :null}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Delete branch protection

  Protected branches are available in public repositories with GitHub Free and GitHub Free for organizations, and in public and private repositories with GitHub Pro, GitHub Team, GitHub Enterprise Cloud, and GitHub Enterprise Server. For more information, see [GitHub's products](https://docs.github.com/github/getting-started-with-github/githubs-products) in the GitHub Help documentation.

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
      response: [{204, :null}, {403, {GitHub.BasicError, :t}}],
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
      response: [{204, :null}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Delete commit signature protection

  Protected branches are available in public repositories with GitHub Free and GitHub Free for organizations, and in public and private repositories with GitHub Pro, GitHub Team, GitHub Enterprise Cloud, and GitHub Enterprise Server. For more information, see [GitHub's products](https://docs.github.com/github/getting-started-with-github/githubs-products) in the GitHub Help documentation.

  When authenticated with admin or owner permissions to the repository, you can use this endpoint to disable required signed commits on a branch. You must enable branch protection to require signed commits.

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
      response: [{204, :null}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Delete a deploy key

  Deploy keys are immutable. If you need to update a key, remove the key and create a new one instead.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/deploy-keys/deploy-keys#delete-a-deploy-key)

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
      response: [{204, :null}],
      opts: opts
    })
  end

  @doc """
  Delete a deployment

  If the repository only has one deployment, you can delete the deployment regardless of its status. If the repository has more than one deployment, you can only delete inactive deployments. This ensures that repositories with multiple deployments will always have an active deployment. Anyone with `repo` or `repo_deployment` scopes can delete a deployment.

  To set a deployment as inactive, you must:

  *   Create a new deployment that is active so that the system has a record of the current state, then delete the previously active deployment.
  *   Mark the active deployment as inactive by adding any non-successful deployment status.

  For more information, see "[Create a deployment](https://docs.github.com/rest/deployments/deployments/#create-a-deployment)" and "[Create a deployment status](https://docs.github.com/rest/deployments/statuses#create-a-deployment-status)."

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
        {204, :null},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :simple}}
      ],
      opts: opts
    })
  end

  @doc """
  Delete a deployment branch policy

  Deletes a deployment branch policy for an environment.

  You must authenticate using an access token with the `repo` scope to use this endpoint. GitHub Apps must have the `administration:write` permission for the repository to use this endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/deployments/branch-policies#delete-a-deployment-branch-policy)

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
      response: [{204, :null}],
      opts: opts
    })
  end

  @doc """
  Delete a file

  Deletes a file in a repository.

  You can provide an additional `committer` parameter, which is an object containing information about the committer. Or, you can provide an `author` parameter, which is an object containing information about the author.

  The `author` section is optional and is filled in with the `committer` information if omitted. If the `committer` information is omitted, the authenticated user's information is used.

  You must provide values for both `name` and `email`, whether you choose to use `author` or `committer`. Otherwise, you'll receive a `422` status code.

  **Note:** If you use this endpoint and the "[Create or update file contents](https://docs.github.com/rest/repos/contents/#create-or-update-file-contents)" endpoint in parallel, the concurrent requests will conflict and you will receive errors. You must use these endpoints serially instead.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/repos/contents#delete-a-file)

  """
  @spec delete_file(String.t(), String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.FileCommit.t()} | {:error, GitHub.Error.t()}
  def delete_file(owner, repo, path, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, path: path, body: body],
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
      response: [{204, :null}],
      opts: opts
    })
  end

  @doc """
  Delete an organization repository ruleset

  Delete a ruleset for an organization.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/rules#delete-an-organization-repository-ruleset)

  """
  @spec delete_org_ruleset(String.t(), integer, keyword) :: :ok | {:error, GitHub.Error.t()}
  def delete_org_ruleset(org, ruleset_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, ruleset_id: ruleset_id],
      call: {GitHub.Repos, :delete_org_ruleset},
      url: "/orgs/#{org}/rulesets/#{ruleset_id}",
      method: :delete,
      response: [{204, :null}, {404, {GitHub.BasicError, :t}}, {500, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Delete a GitHub Pages site

  Deletes a GitHub Pages site. For more information, see "[About GitHub Pages](https://docs.github.com/github/working-with-github-pages/about-github-pages).

  To use this endpoint, you must be a repository administrator, maintainer, or have the 'manage GitHub Pages settings' permission. A token with the `repo` scope or Pages write permission is required. GitHub Apps must have the `administration:write` and `pages:write` permissions.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/pages/pages#delete-a-apiname-pages-site)

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
        {204, :null},
        {404, {GitHub.BasicError, :t}},
        {409, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Delete pull request review protection

  Protected branches are available in public repositories with GitHub Free and GitHub Free for organizations, and in public and private repositories with GitHub Pro, GitHub Team, GitHub Enterprise Cloud, and GitHub Enterprise Server. For more information, see [GitHub's products](https://docs.github.com/github/getting-started-with-github/githubs-products) in the GitHub Help documentation.

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
      response: [{204, :null}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Delete a release

  Users with push access to the repository can delete a release.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/releases/releases#delete-a-release)

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
      response: [{204, :null}],
      opts: opts
    })
  end

  @doc """
  Delete a release asset

  ## Resources

    * [API method documentation](https://docs.github.com/rest/releases/assets#delete-a-release-asset)

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
      response: [{204, :null}],
      opts: opts
    })
  end

  @doc """
  Delete a repository ruleset

  Delete a ruleset for a repository.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/repos/rules#delete-a-repository-ruleset)

  """
  @spec delete_repo_ruleset(String.t(), String.t(), integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def delete_repo_ruleset(owner, repo, ruleset_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, ruleset_id: ruleset_id],
      call: {GitHub.Repos, :delete_repo_ruleset},
      url: "/repos/#{owner}/#{repo}/rulesets/#{ruleset_id}",
      method: :delete,
      response: [{204, :null}, {404, {GitHub.BasicError, :t}}, {500, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Delete a tag protection state for a repository

  This deletes a tag protection state for a repository.
  This endpoint is only available to repository administrators.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/repos/tags#delete-a-tag-protection-state-for-a-repository)

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
      response: [{204, :null}, {403, {GitHub.BasicError, :t}}, {404, {GitHub.BasicError, :t}}],
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
      response: [{204, :null}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Disable automated security fixes

  Disables automated security fixes for a repository. The authenticated user must have admin access to the repository. For more information, see "[Configuring automated security fixes](https://docs.github.com/articles/configuring-automated-security-fixes)".

  ## Resources

    * [API method documentation](https://docs.github.com/rest/repos/repos#disable-automated-security-fixes)

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
      response: [{204, :null}],
      opts: opts
    })
  end

  @doc """
  Disable a custom protection rule for an environment

  Disables a custom deployment protection rule for an environment.

  You must authenticate using an access token with the `repo` scope to use this endpoint. Removing a custom protection rule requires admin or owner permissions to the repository. GitHub Apps must have the `actions:write` permission to use this endpoint. For more information, see "[Get an app](https://docs.github.com/rest/apps/apps#get-an-app)".

  ## Resources

    * [API method documentation](https://docs.github.com/rest/deployments/protection-rules#disable-a-custom-protection-rule-for-an-environment)

  """
  @spec disable_deployment_protection_rule(String.t(), String.t(), String.t(), integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def disable_deployment_protection_rule(
        environment_name,
        repo,
        owner,
        protection_rule_id,
        opts \\ []
      ) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [
        environment_name: environment_name,
        repo: repo,
        owner: owner,
        protection_rule_id: protection_rule_id
      ],
      call: {GitHub.Repos, :disable_deployment_protection_rule},
      url:
        "/repos/#{owner}/#{repo}/environments/#{environment_name}/deployment_protection_rules/#{protection_rule_id}",
      method: :delete,
      response: [{204, :null}],
      opts: opts
    })
  end

  @doc """
  Disable private vulnerability reporting for a repository

  Disables private vulnerability reporting for a repository. The authenticated user must have admin access to the repository. For more information, see "[Privately reporting a security vulnerability](https://docs.github.com/code-security/security-advisories/guidance-on-reporting-and-writing/privately-reporting-a-security-vulnerability)".

  ## Resources

    * [API method documentation](https://docs.github.com/rest/repos/repos#disable-private-vulnerability-reporting-for-a-repository)

  """
  @spec disable_private_vulnerability_reporting(String.t(), String.t(), keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def disable_private_vulnerability_reporting(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :disable_private_vulnerability_reporting},
      url: "/repos/#{owner}/#{repo}/private-vulnerability-reporting",
      method: :delete,
      response: [
        {204, :null},
        {422, {:union, [{GitHub.BasicError, :t}, {GitHub.SCIM.Error, :t}]}}
      ],
      opts: opts
    })
  end

  @doc """
  Disable vulnerability alerts

  Disables dependency alerts and the dependency graph for a repository.
  The authenticated user must have admin access to the repository. For more information,
  see "[About security alerts for vulnerable dependencies](https://docs.github.com/articles/about-security-alerts-for-vulnerable-dependencies)".

  ## Resources

    * [API method documentation](https://docs.github.com/rest/repos/repos#disable-vulnerability-alerts)

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
      response: [{204, :null}],
      opts: opts
    })
  end

  @doc """
  Download a repository archive (tar)

  Gets a redirect URL to download a tar archive for a repository. If you omit `:ref`, the repository’s default branch (usually
  `main`) will be used. Please make sure your HTTP framework is configured to follow redirects or you will need to use
  the `Location` header to make a second `GET` request.
  **Note**: For private repositories, these links are temporary and expire after five minutes.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/repos/contents#download-a-repository-archive-tar)

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
      response: [{302, :null}],
      opts: opts
    })
  end

  @doc """
  Download a repository archive (zip)

  Gets a redirect URL to download a zip archive for a repository. If you omit `:ref`, the repository’s default branch (usually
  `main`) will be used. Please make sure your HTTP framework is configured to follow redirects or you will need to use
  the `Location` header to make a second `GET` request.

  **Note**: For private repositories, these links are temporary and expire after five minutes. If the repository is empty, you will receive a 404 when you follow the redirect.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/repos/contents#download-a-repository-archive-zip)

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
      response: [{302, :null}],
      opts: opts
    })
  end

  @doc """
  Enable automated security fixes

  Enables automated security fixes for a repository. The authenticated user must have admin access to the repository. For more information, see "[Configuring automated security fixes](https://docs.github.com/articles/configuring-automated-security-fixes)".

  ## Resources

    * [API method documentation](https://docs.github.com/rest/repos/repos#enable-automated-security-fixes)

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
      response: [{204, :null}],
      opts: opts
    })
  end

  @doc """
  Enable private vulnerability reporting for a repository

  Enables private vulnerability reporting for a repository. The authenticated user must have admin access to the repository. For more information, see "[Privately reporting a security vulnerability](https://docs.github.com/code-security/security-advisories/guidance-on-reporting-and-writing/privately-reporting-a-security-vulnerability)."

  ## Resources

    * [API method documentation](https://docs.github.com/rest/repos/repos#enable-private-vulnerability-reporting-for-a-repository)

  """
  @spec enable_private_vulnerability_reporting(String.t(), String.t(), keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def enable_private_vulnerability_reporting(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :enable_private_vulnerability_reporting},
      url: "/repos/#{owner}/#{repo}/private-vulnerability-reporting",
      method: :put,
      response: [
        {204, :null},
        {422, {:union, [{GitHub.BasicError, :t}, {GitHub.SCIM.Error, :t}]}}
      ],
      opts: opts
    })
  end

  @doc """
  Enable vulnerability alerts

  Enables dependency alerts and the dependency graph for a repository. The authenticated user must have admin access to the repository. For more information, see "[About security alerts for vulnerable dependencies](https://docs.github.com/articles/about-security-alerts-for-vulnerable-dependencies)".

  ## Resources

    * [API method documentation](https://docs.github.com/rest/repos/repos#enable-vulnerability-alerts)

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
      response: [{204, :null}],
      opts: opts
    })
  end

  @doc """
  Generate release notes content for a release

  Generate a name and body describing a [release](https://docs.github.com/rest/releases/releases#get-a-release). The body content will be markdown formatted and contain information like the changes since last release and users who contributed. The generated release notes are not saved anywhere. They are intended to be generated and used when creating a new release.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/releases/releases#generate-release-notes-content-for-a-release)

  """
  @spec generate_release_notes(String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.Release.NotesContent.t()} | {:error, GitHub.Error.t()}
  def generate_release_notes(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, body: body],
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

  The `parent` and `source` objects are present when the repository is a fork. `parent` is the repository this repository was forked from, `source` is the ultimate source for the network.

  **Note:** In order to see the `security_and_analysis` block for a repository you must have admin permissions for the repository or be an owner or security manager for the organization that owns the repository. For more information, see "[Managing security managers in your organization](https://docs.github.com/organizations/managing-peoples-access-to-your-organization-with-roles/managing-security-managers-in-your-organization)."

  ## Resources

    * [API method documentation](https://docs.github.com/rest/repos/repos#get-a-repository)

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

  Protected branches are available in public repositories with GitHub Free and GitHub Free for organizations, and in public and private repositories with GitHub Pro, GitHub Team, GitHub Enterprise Cloud, and GitHub Enterprise Server. For more information, see [GitHub's products](https://docs.github.com/github/getting-started-with-github/githubs-products) in the GitHub Help documentation.

  Lists who has access to this protected branch.

  **Note**: Users, apps, and teams `restrictions` are only available for organization-owned repositories.

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

  Protected branches are available in public repositories with GitHub Free and GitHub Free for organizations, and in public and private repositories with GitHub Pro, GitHub Team, GitHub Enterprise Cloud, and GitHub Enterprise Server. For more information, see [GitHub's products](https://docs.github.com/github/getting-started-with-github/githubs-products) in the GitHub Help documentation.

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
  Get all deployment protection rules for an environment

  Gets all custom deployment protection rules that are enabled for an environment. Anyone with read access to the repository can use this endpoint. If the repository is private and you want to use a personal access token (classic), you must use an access token with the `repo` scope. GitHub Apps and fine-grained personal access tokens must have the `actions:read` permission to use this endpoint. For more information about environments, see "[Using environments for deployment](https://docs.github.com/en/actions/deployment/targeting-different-environments/using-environments-for-deployment)."

  For more information about the app that is providing this custom deployment rule, see the [documentation for the `GET /apps/{app_slug}` endpoint](https://docs.github.com/rest/apps/apps#get-an-app).

  ## Resources

    * [API method documentation](https://docs.github.com/rest/deployments/protection-rules#get-all-deployment-protection-rules-for-an-environment)

  """
  @spec get_all_deployment_protection_rules(String.t(), String.t(), String.t(), keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def get_all_deployment_protection_rules(environment_name, repo, owner, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [environment_name: environment_name, repo: repo, owner: owner],
      call: {GitHub.Repos, :get_all_deployment_protection_rules},
      url: "/repos/#{owner}/#{repo}/environments/#{environment_name}/deployment_protection_rules",
      method: :get,
      response: [{200, :map}],
      opts: opts
    })
  end

  @doc """
  List environments

  Lists the environments for a repository.

  Anyone with read access to the repository can use this endpoint. If the repository is private, you must use an access token with the `repo` scope. GitHub Apps must have the `actions:read` permission to use this endpoint.

  ## Options

    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.

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

  Protected branches are available in public repositories with GitHub Free and GitHub Free for organizations, and in public and private repositories with GitHub Pro, GitHub Team, GitHub Enterprise Cloud, and GitHub Enterprise Server. For more information, see [GitHub's products](https://docs.github.com/github/getting-started-with-github/githubs-products) in the GitHub Help documentation.

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
      response: [{200, [string: :generic]}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Get all repository topics

  ## Options

    * `page`: Page number of the results to fetch.
    * `per_page`: The number of results per page (max 100).

  ## Resources

    * [API method documentation](https://docs.github.com/rest/repos/repos#get-all-repository-topics)

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

  Protected branches are available in public repositories with GitHub Free and GitHub Free for organizations, and in public and private repositories with GitHub Pro, GitHub Team, GitHub Enterprise Cloud, and GitHub Enterprise Server. For more information, see [GitHub's products](https://docs.github.com/github/getting-started-with-github/githubs-products) in the GitHub Help documentation.

  Lists the GitHub Apps that have push access to this branch. Only installed GitHub Apps with `write` access to the `contents` permission can be added as authorized actors on a protected branch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/branches/branch-protection#get-apps-with-access-to-the-protected-branch)

  """
  @spec get_apps_with_access_to_protected_branch(String.t(), String.t(), String.t(), keyword) ::
          {:ok, [GitHub.App.t()]} | {:error, GitHub.Error.t()}
  def get_apps_with_access_to_protected_branch(owner, repo, branch, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, branch: branch],
      call: {GitHub.Repos, :get_apps_with_access_to_protected_branch},
      url: "/repos/#{owner}/#{repo}/branches/#{branch}/protection/restrictions/apps",
      method: :get,
      response: [{200, [{GitHub.App, :t}]}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Get an autolink reference of a repository

  This returns a single autolink reference by ID that was configured for the given repository.

  Information about autolinks are only available to repository administrators.

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

  Protected branches are available in public repositories with GitHub Free and GitHub Free for organizations, and in public and private repositories with GitHub Pro, GitHub Team, GitHub Enterprise Cloud, and GitHub Enterprise Server. For more information, see [GitHub's products](https://docs.github.com/github/getting-started-with-github/githubs-products) in the GitHub Help documentation.

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
  Get rules for a branch

  Returns all active rules that apply to the specified branch. The branch does not need to exist; rules that would apply
  to a branch with that name will be returned. All active rules that apply will be returned, regardless of the level
  at which they are configured (e.g. repository or organization). Rules in rulesets with "evaluate" or "disabled"
  enforcement statuses are not returned.

  ## Options

    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/repos/rules#get-rules-for-a-branch)

  """
  @spec get_branch_rules(String.t(), String.t(), String.t(), keyword) ::
          {:ok, [map]} | {:error, GitHub.Error.t()}
  def get_branch_rules(owner, repo, branch, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [owner: owner, repo: repo, branch: branch],
      call: {GitHub.Repos, :get_branch_rules},
      url: "/repos/#{owner}/#{repo}/rules/branches/#{branch}",
      method: :get,
      query: query,
      response: [{200, [:map]}],
      opts: opts
    })
  end

  @doc """
  Get repository clones

  Get the total number of clones and breakdown per day or week for the last 14 days. Timestamps are aligned to UTC midnight of the beginning of the day or week. Week begins on Monday.

  ## Options

    * `per`: The time frame to display results for.

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

  Returns a weekly aggregate of the number of additions and deletions pushed to a repository.

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
      response: [{200, [[:integer]]}, {202, :map}, {204, :null}],
      opts: opts
    })
  end

  @doc """
  Get repository permissions for a user

  Checks the repository permission of a collaborator. The possible repository
  permissions are `admin`, `write`, `read`, and `none`.

  *Note*: The `permission` attribute provides the legacy base roles of `admin`, `write`, `read`, and `none`, where the
  `maintain` role is mapped to `write` and the `triage` role is mapped to `read`. To determine the role assigned to the
  collaborator, see the `role_name` attribute, which will provide the full role name, including custom roles. The
  `permissions` hash can also be used to determine which base level of access the collaborator has to the repository.

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

  Users with pull access in a repository can access a combined view of commit statuses for a given ref. The ref can be a SHA, a branch name, or a tag name.


  Additionally, a combined `state` is returned. The `state` is one of:

  *   **failure** if any of the contexts report as `error` or `failure`
  *   **pending** if there are no statuses or a context is `pending`
  *   **success** if the latest status for all contexts is `success`

  ## Options

    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.

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

  Returns the contents of a single commit reference. You must have `read` access for the repository to use this endpoint.

  **Note:** If there are more than 300 files in the commit diff, the response will include pagination link headers for the remaining files, up to a limit of 3000 files. Each page contains the static commit information, and the only changes are to the file listing.

  You can pass the appropriate [media type](https://docs.github.com/rest/overview/media-types/#commits-commit-comparison-and-pull-requests) to  fetch `diff` and `patch` formats. Diffs with binary data will have no `patch` property.

  To return only the SHA-1 hash of the commit reference, you can provide the `sha` custom [media type](https://docs.github.com/rest/overview/media-types/#commits-commit-comparison-and-pull-requests) in the `Accept` header. You can use this endpoint to check if a remote reference's SHA-1 hash is the same as your local reference's SHA-1 hash by providing the local SHA-1 reference as the ETag.

  **Signature verification object**

  The response will include a `verification` object that describes the result of verifying the commit's signature. The following fields are included in the `verification` object:

  | Name | Type | Description |
  | ---- | ---- | ----------- |
  | `verified` | `boolean` | Indicates whether GitHub considers the signature in this commit to be verified. |
  | `reason` | `string` | The reason for verified value. Possible values and their meanings are enumerated in table below. |
  | `signature` | `string` | The signature that was extracted from the commit. |
  | `payload` | `string` | The value that was signed. |

  These are the possible values for `reason` in the `verification` object:

  | Value | Description |
  | ----- | ----------- |
  | `expired_key` | The key that made the signature is expired. |
  | `not_signing_key` | The "signing" flag is not among the usage flags in the GPG key that made the signature. |
  | `gpgverify_error` | There was an error communicating with the signature verification service. |
  | `gpgverify_unavailable` | The signature verification service is currently unavailable. |
  | `unsigned` | The object does not include a signature. |
  | `unknown_signature_type` | A non-PGP signature was found in the commit. |
  | `no_user` | No user was associated with the `committer` email address in the commit. |
  | `unverified_email` | The `committer` email address in the commit was associated with a user, but the email address is not verified on their account. |
  | `bad_email` | The `committer` email address in the commit is not included in the identities of the PGP key that made the signature. |
  | `unknown_key` | The key that made the signature has not been registered with any user's account. |
  | `malformed_signature` | There was an error parsing the signature. |
  | `invalid` | The signature could not be cryptographically verified using the key whose key-id was found in the signature. |
  | `valid` | None of the above errors applied, so the signature is considered to be verified. |

  ## Options

    * `page`: Page number of the results to fetch.
    * `per_page`: The number of results per page (max 100).

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

  Returns the last year of commit activity grouped by week. The `days` array is a group of commits per day, starting on `Sunday`.

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
      response: [{200, [{GitHub.Commit.Activity, :t}]}, {202, :map}, {204, :null}],
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

  Protected branches are available in public repositories with GitHub Free and GitHub Free for organizations, and in public and private repositories with GitHub Pro, GitHub Team, GitHub Enterprise Cloud, and GitHub Enterprise Server. For more information, see [GitHub's products](https://docs.github.com/github/getting-started-with-github/githubs-products) in the GitHub Help documentation.

  When authenticated with admin or owner permissions to the repository, you can use this endpoint to check whether a branch requires signed commits. An enabled status of `true` indicates you must sign commits on this branch. For more information, see [Signing commits with GPG](https://docs.github.com/articles/signing-commits-with-gpg) in GitHub Help.

  **Note**: You must enable branch protection to require signed commits.

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

  Returns all community profile metrics for a repository. The repository cannot be a fork.

  The returned metrics include an overall health score, the repository description, the presence of documentation, the
  detected code of conduct, the detected license, and the presence of ISSUE\_TEMPLATE, PULL\_REQUEST\_TEMPLATE,
  README, and CONTRIBUTING files.

  The `health_percentage` score is defined as a percentage of how many of
  the recommended community health files are present. For more information, see
  "[About community profiles for public repositories](https://docs.github.com/communities/setting-up-your-project-for-healthy-contributions/about-community-profiles-for-public-repositories)."

  `content_reports_enabled` is only returned for organization-owned repositories.

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

  Gets the contents of a file or directory in a repository. Specify the file path or directory in `:path`. If you omit
  `:path`, you will receive the contents of the repository's root directory. See the description below regarding what the API response includes for directories. 

  Files and symlinks support [a custom media type](https://docs.github.com/rest/overview/media-types) for
  retrieving the raw content or rendered HTML (when supported). All content types support [a custom media
  type](https://docs.github.com/rest/overview/media-types) to ensure the content is returned in a consistent
  object format.

  **Notes**:
  *   To get a repository's contents recursively, you can [recursively get the tree](https://docs.github.com/rest/git/trees#get-a-tree).
  *   This API has an upper limit of 1,000 files for a directory. If you need to retrieve more files, use the [Git Trees
  API](https://docs.github.com/rest/git/trees#get-a-tree).
   *  Download URLs expire and are meant to be used just once. To ensure the download URL does not expire, please use the contents API to obtain a fresh download URL for each download.
   Size limits:
  If the requested file's size is:
  * 1 MB or smaller: All features of this endpoint are supported.
  * Between 1-100 MB: Only the `raw` or `object` [custom media types](https://docs.github.com/rest/repos/contents#custom-media-types-for-repository-contents) are supported. Both will work as normal, except that when using the `object` media type, the `content` field will be an empty string and the `encoding` field will be `"none"`. To get the contents of these larger files, use the `raw` media type.
   * Greater than 100 MB: This endpoint is not supported.

   If the content is a directory:
  The response will be an array of objects, one object for each item in the directory.
  When listing the contents of a directory, submodules have their "type" specified as "file". Logically, the value
  _should_ be "submodule". This behavior exists in API v3 [for backwards compatibility purposes](https://git.io/v1YCW).
  In the next major version of the API, the type will be returned as "submodule".

   If the content is a symlink: 
  If the requested `:path` points to a symlink, and the symlink's target is a normal file in the repository, then the
  API responds with the content of the file (in the format shown in the example. Otherwise, the API responds with an object 
  describing the symlink itself.

   If the content is a submodule:
  The `submodule_git_url` identifies the location of the submodule repository, and the `sha` identifies a specific
  commit within the submodule repository. Git uses the given URL when cloning the submodule repository, and checks out
  the submodule at that specific commit.

  If the submodule repository is not hosted on github.com, the Git URLs (`git_url` and `_links["git"]`) and the
  github.com URLs (`html_url` and `_links["html"]`) will have null values.

  ## Options

    * `ref`: The name of the commit/branch/tag. Default: the repository’s default branch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/repos/contents#get-repository-content)

  """
  @spec get_content(String.t(), String.t(), String.t(), keyword) ::
          {:ok, map | GitHub.Content.File.t() | GitHub.Content.Tree.t() | [map]}
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
        {200, {:union, [:map, {GitHub.Content.File, :t}, {GitHub.Content.Tree, :t}, [:map]]}},
        {302, :null},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get all contributor commit activity


  Returns the `total` number of commits authored by the contributor. In addition, the response includes a Weekly Hash (`weeks` array) with the following information:

  *   `w` - Start of the week, given as a [Unix timestamp](http://en.wikipedia.org/wiki/Unix_time).
  *   `a` - Number of additions
  *   `d` - Number of deletions
  *   `c` - Number of commits

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
      response: [{200, [{GitHub.ContributorActivity, :t}]}, {202, :map}, {204, :null}],
      opts: opts
    })
  end

  @doc """
  Get a custom deployment protection rule

  Gets an enabled custom deployment protection rule for an environment. Anyone with read access to the repository can use this endpoint. If the repository is private and you want to use a personal access token (classic), you must use an access token with the `repo` scope. GitHub Apps and fine-grained personal access tokens must have the `actions:read` permission to use this endpoint. For more information about environments, see "[Using environments for deployment](https://docs.github.com/en/actions/deployment/targeting-different-environments/using-environments-for-deployment)."

  For more information about the app that is providing this custom deployment rule, see [`GET /apps/{app_slug}`](https://docs.github.com/rest/apps/apps#get-an-app).

  ## Resources

    * [API method documentation](https://docs.github.com/rest/deployments/protection-rules#get-a-custom-deployment-protection-rule)

  """
  @spec get_custom_deployment_protection_rule(
          String.t(),
          String.t(),
          String.t(),
          integer,
          keyword
        ) :: {:ok, GitHub.Deployment.ProtectionRule.t()} | {:error, GitHub.Error.t()}
  def get_custom_deployment_protection_rule(
        owner,
        repo,
        environment_name,
        protection_rule_id,
        opts \\ []
      ) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [
        owner: owner,
        repo: repo,
        environment_name: environment_name,
        protection_rule_id: protection_rule_id
      ],
      call: {GitHub.Repos, :get_custom_deployment_protection_rule},
      url:
        "/repos/#{owner}/#{repo}/environments/#{environment_name}/deployment_protection_rules/#{protection_rule_id}",
      method: :get,
      response: [{200, {GitHub.Deployment.ProtectionRule, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a deploy key

  ## Resources

    * [API method documentation](https://docs.github.com/rest/deploy-keys/deploy-keys#get-a-deploy-key)

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

  Gets a deployment branch policy for an environment.

  Anyone with read access to the repository can use this endpoint. If the repository is private, you must use an access token with the `repo` scope. GitHub Apps must have the `actions:read` permission to use this endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/deployments/branch-policies#get-a-deployment-branch-policy)

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

  Users with pull access can view a deployment status for a deployment:

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

  **Note:** To get information about name patterns that branches must match in order to deploy to this environment, see "[Get a deployment branch policy](https://docs.github.com/rest/deployments/branch-policies#get-a-deployment-branch-policy)."

  Anyone with read access to the repository can use this endpoint. If the
  repository is private, you must use an access token with the `repo` scope. GitHub
  Apps must have the `actions:read` permission to use this endpoint.

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

  Gets information about the single most recent build of a GitHub Pages site.

  A token with the `repo` scope is required. GitHub Apps must have the `pages:read` permission.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/pages/pages#get-latest-pages-build)

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

  View the latest published full release for the repository.

  The latest release is the most recent non-prerelease, non-draft release, sorted by the `created_at` attribute. The `created_at` attribute is the date of the commit used for the release, and not the date when the release was drafted or published.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/releases/releases#get-the-latest-release)

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
  Get an organization repository ruleset

  Get a repository ruleset for an organization.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/rules#get-an-organization-repository-ruleset)

  """
  @spec get_org_ruleset(String.t(), integer, keyword) ::
          {:ok, GitHub.Repository.Ruleset.t()} | {:error, GitHub.Error.t()}
  def get_org_ruleset(org, ruleset_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, ruleset_id: ruleset_id],
      call: {GitHub.Repos, :get_org_ruleset},
      url: "/orgs/#{org}/rulesets/#{ruleset_id}",
      method: :get,
      response: [
        {200, {GitHub.Repository.Ruleset, :t}},
        {404, {GitHub.BasicError, :t}},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get all organization repository rulesets

  Get all the repository rulesets for an organization.

  ## Options

    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/rules#get-all-organization-repository-rulesets)

  """
  @spec get_org_rulesets(String.t(), keyword) ::
          {:ok, [GitHub.Repository.Ruleset.t()]} | {:error, GitHub.Error.t()}
  def get_org_rulesets(org, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [org: org],
      call: {GitHub.Repos, :get_org_rulesets},
      url: "/orgs/#{org}/rulesets",
      method: :get,
      query: query,
      response: [
        {200, [{GitHub.Repository.Ruleset, :t}]},
        {404, {GitHub.BasicError, :t}},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get a GitHub Pages site

  Gets information about a GitHub Pages site.

  A token with the `repo` scope is required. GitHub Apps must have the `pages:read` permission.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/pages/pages#get-a-apiname-pages-site)

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

  Gets information about a GitHub Pages build.

  A token with the `repo` scope is required. GitHub Apps must have the `pages:read` permission.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/pages/pages#get-apiname-pages-build)

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

  Gets a health check of the DNS settings for the `CNAME` record configured for a repository's GitHub Pages.

  The first request to this endpoint returns a `202 Accepted` status and starts an asynchronous background task to get the results for the domain. After the background task completes, subsequent requests to this endpoint return a `200 OK` status with the health check results in the response.

  To use this endpoint, you must be a repository administrator, maintainer, or have the 'manage GitHub Pages settings' permission. A token with the `repo` scope or Pages write permission is required. GitHub Apps must have the `administrative:write` and `pages:write` permissions.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/pages/pages#get-a-dns-health-check-for-github-pages)

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
        {400, :null},
        {404, {GitHub.BasicError, :t}},
        {422, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Get the weekly commit count

  Returns the total commit counts for the `owner` and total commit counts in `all`. `all` is everyone combined, including the `owner` in the last 52 weeks. If you'd like to get the commit counts for non-owners, you can subtract `owner` from `all`.

  The array order is oldest week (index 0) to most recent week.

  The most recent week is seven days ago at UTC midnight to today at UTC midnight.

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

  Protected branches are available in public repositories with GitHub Free and GitHub Free for organizations, and in public and private repositories with GitHub Pro, GitHub Team, GitHub Enterprise Cloud, and GitHub Enterprise Server. For more information, see [GitHub's products](https://docs.github.com/github/getting-started-with-github/githubs-products) in the GitHub Help documentation.

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

  Each array contains the day number, hour number, and number of commits:

  *   `0-6`: Sunday - Saturday
  *   `0-23`: Hour of day
  *   Number of commits

  For example, `[2, 14, 25]` indicates that there were 25 total commits, during the 2:00pm hour on Tuesdays. All times are based on the time zone of individual commits.

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
      response: [{200, [[:integer]]}, {204, :null}],
      opts: opts
    })
  end

  @doc """
  Get a repository README

  Gets the preferred README for a repository.

  READMEs support [custom media types](https://docs.github.com/rest/overview/media-types) for retrieving the raw content or rendered HTML.

  ## Options

    * `ref`: The name of the commit/branch/tag. Default: the repository’s default branch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/repos/contents#get-a-repository-readme)

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

  Gets the README from a repository directory.

  READMEs support [custom media types](https://docs.github.com/rest/overview/media-types) for retrieving the raw content or rendered HTML.

  ## Options

    * `ref`: The name of the commit/branch/tag. Default: the repository’s default branch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/repos/contents#get-a-repository-readme-for-a-directory)

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

  **Note:** This returns an `upload_url` key corresponding to the endpoint for uploading release assets. This key is a [hypermedia resource](https://docs.github.com/rest/overview/resources-in-the-rest-api#hypermedia).

  ## Resources

    * [API method documentation](https://docs.github.com/rest/releases/releases#get-a-release)

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
      response: [{200, {GitHub.Release, :t}}, {401, :null}],
      opts: opts
    })
  end

  @doc """
  Get a release asset

  To download the asset's binary content, set the `Accept` header of the request to [`application/octet-stream`](https://docs.github.com/rest/overview/media-types). The API will either redirect the client to the location, or stream it directly if possible. API clients should handle both a `200` or `302` response.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/releases/assets#get-a-release-asset)

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
      response: [{200, {GitHub.Release.Asset, :t}}, {302, :null}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a release by tag name

  Get a published release with the specified tag.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/releases/releases#get-a-release-by-tag-name)

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
  Get a repository ruleset

  Get a ruleset for a repository.

  ## Options

    * `includes_parents`: Include rulesets configured at higher levels that apply to this repository

  ## Resources

    * [API method documentation](https://docs.github.com/rest/repos/rules#get-a-repository-ruleset)

  """
  @spec get_repo_ruleset(String.t(), String.t(), integer, keyword) ::
          {:ok, GitHub.Repository.Ruleset.t()} | {:error, GitHub.Error.t()}
  def get_repo_ruleset(owner, repo, ruleset_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:includes_parents])

    client.request(%{
      args: [owner: owner, repo: repo, ruleset_id: ruleset_id],
      call: {GitHub.Repos, :get_repo_ruleset},
      url: "/repos/#{owner}/#{repo}/rulesets/#{ruleset_id}",
      method: :get,
      query: query,
      response: [
        {200, {GitHub.Repository.Ruleset, :t}},
        {404, {GitHub.BasicError, :t}},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get all repository rulesets

  Get all the rulesets for a repository.

  ## Options

    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.
    * `includes_parents`: Include rulesets configured at higher levels that apply to this repository

  ## Resources

    * [API method documentation](https://docs.github.com/rest/repos/rules#get-all-repository-rulesets)

  """
  @spec get_repo_rulesets(String.t(), String.t(), keyword) ::
          {:ok, [GitHub.Repository.Ruleset.t()]} | {:error, GitHub.Error.t()}
  def get_repo_rulesets(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:includes_parents, :page, :per_page])

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :get_repo_rulesets},
      url: "/repos/#{owner}/#{repo}/rulesets",
      method: :get,
      query: query,
      response: [
        {200, [{GitHub.Repository.Ruleset, :t}]},
        {404, {GitHub.BasicError, :t}},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get status checks protection

  Protected branches are available in public repositories with GitHub Free and GitHub Free for organizations, and in public and private repositories with GitHub Pro, GitHub Team, GitHub Enterprise Cloud, and GitHub Enterprise Server. For more information, see [GitHub's products](https://docs.github.com/github/getting-started-with-github/githubs-products) in the GitHub Help documentation.

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

  Protected branches are available in public repositories with GitHub Free and GitHub Free for organizations, and in public and private repositories with GitHub Pro, GitHub Team, GitHub Enterprise Cloud, and GitHub Enterprise Server. For more information, see [GitHub's products](https://docs.github.com/github/getting-started-with-github/githubs-products) in the GitHub Help documentation.

  Lists the teams who have push access to this branch. The list includes child teams.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/branches/branch-protection#get-teams-with-access-to-the-protected-branch)

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
      response: [{200, [{GitHub.Team, :t}]}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Get top referral paths

  Get the top 10 popular contents over the last 14 days.

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
      response: [{200, [{GitHub.Content.Traffic, :t}]}, {403, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Get top referral sources

  Get the top 10 referrers over the last 14 days.

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
      response: [{200, [{GitHub.ReferrerTraffic, :t}]}, {403, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Get users with access to the protected branch

  Protected branches are available in public repositories with GitHub Free and GitHub Free for organizations, and in public and private repositories with GitHub Pro, GitHub Team, GitHub Enterprise Cloud, and GitHub Enterprise Server. For more information, see [GitHub's products](https://docs.github.com/github/getting-started-with-github/githubs-products) in the GitHub Help documentation.

  Lists the people who have push access to this branch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/branches/branch-protection#get-users-with-access-to-the-protected-branch)

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
      response: [{200, [{GitHub.User, :simple}]}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Get page views

  Get the total number of views and breakdown per day or week for the last 14 days. Timestamps are aligned to UTC midnight of the beginning of the day or week. Week begins on Monday.

  ## Options

    * `per`: The time frame to display results for.

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

  Returns a webhook configured in a repository. To get only the webhook `config` properties, see "[Get a webhook configuration for a repository](https://docs.github.com/rest/webhooks/repo-config#get-a-webhook-configuration-for-a-repository)."

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

  Returns the webhook configuration for a repository. To get more information about the webhook, including the `active` state and `events`, use "[Get a repository webhook](https://docs.github.com/rest/webhooks/repos#get-a-repository-webhook)."

  Access tokens must have the `read:repo_hook` or `repo` scope, and GitHub Apps must have the `repository_hooks:read` permission.

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

  Returns a delivery for a webhook configured in a repository.

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
        {400, {:union, [{GitHub.BasicError, :t}, {GitHub.SCIM.Error, :t}]}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List repository activities

  Lists a detailed history of changes to a repository, such as pushes, merges, force pushes, and branch changes, and associates these changes with commits and users.

  For more information about viewing repository activity,
  see "[Viewing repository activity](https://docs.github.com/repositories/viewing-activity-and-data-for-your-repository/viewing-repository-activity)."

  ## Options

    * `direction`: The direction to sort the results by.
    * `per_page`: The number of results per page (max 100).
    * `before`: A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for results before this cursor.
    * `after`: A cursor, as given in the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers). If specified, the query only searches for results after this cursor.
    * `ref`: The Git reference for the activities you want to list.
      
      The `ref` for a branch can be formatted either as `refs/heads/BRANCH_NAME` or `BRANCH_NAME`, where `BRANCH_NAME` is the name of your branch.
    * `actor`: The GitHub username to use to filter by the actor who performed the activity.
    * `time_period`: The time period to filter by.
      
      For example, `day` will filter for activity that occurred in the past 24 hours, and `week` will filter for activity that occurred in the past 7 days (168 hours).
    * `activity_type`: The activity type to filter by.
      
      For example, you can choose to filter by "force_push", to see all force pushes to the repository.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/repos/repos#list-repository-activities)

  """
  @spec list_activities(String.t(), String.t(), keyword) ::
          {:ok, [GitHub.Activity.t()]} | {:error, GitHub.Error.t()}
  def list_activities(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    query =
      Keyword.take(opts, [
        :activity_type,
        :actor,
        :after,
        :before,
        :direction,
        :per_page,
        :ref,
        :time_period
      ])

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :list_activities},
      url: "/repos/#{owner}/#{repo}/activity",
      method: :get,
      query: query,
      response: [{200, [{GitHub.Activity, :t}]}, {422, {GitHub.ValidationError, :simple}}],
      opts: opts
    })
  end

  @doc """
  List all autolinks of a repository

  This returns a list of autolinks configured for the given repository.

  Information about autolinks are only available to repository administrators.

  ## Options

    * `page`: Page number of the results to fetch.

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
      response: [{200, [{GitHub.Autolink, :t}]}],
      opts: opts
    })
  end

  @doc """
  List branches

  ## Options

    * `protected`: Setting to `true` returns only protected branches. When set to `false`, only unprotected branches are returned. Omitting this parameter returns all branches.
    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.

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
      response: [{200, [{GitHub.ShortBranch, :t}]}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  List branches for HEAD commit

  Protected branches are available in public repositories with GitHub Free and GitHub Free for organizations, and in public and private repositories with GitHub Pro, GitHub Team, GitHub Enterprise Cloud, and GitHub Enterprise Server. For more information, see [GitHub's products](https://docs.github.com/github/getting-started-with-github/githubs-products) in the GitHub Help documentation.

  Returns all branches where the given commit SHA is the HEAD, or latest commit for the branch.

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
      response: [{200, [{GitHub.Branch.Short, :t}]}, {422, {GitHub.ValidationError, :t}}],
      opts: opts
    })
  end

  @doc """
  List repository collaborators

  For organization-owned repositories, the list of collaborators includes outside collaborators, organization members that are direct collaborators, organization members with access through team memberships, organization members with access through default organization permissions, and organization owners.
  Organization members with write, maintain, or admin privileges on the organization-owned repository can use this endpoint.

  Team members will include the members of child teams.

  You must authenticate using an access token with the `read:org` and `repo` scopes with push access to use this
  endpoint. GitHub Apps must have the `members` organization permission and `metadata` repository permission to use this
  endpoint.

  ## Options

    * `affiliation`: Filter collaborators returned by their affiliation. `outside` means all outside collaborators of an organization-owned repository. `direct` means all collaborators with permissions to an organization-owned repository, regardless of organization membership status. `all` means all collaborators the authenticated user can see.
    * `permission`: Filter collaborators by the permissions they have on the repository. If not specified, all collaborators will be returned.
    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.

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
      response: [{200, [{GitHub.Collaborator, :t}]}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  List commit comments

  Use the `:commit_sha` to specify the commit that will have its comments listed.

  ## Options

    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.

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
      response: [{200, [{GitHub.Commit.Comment, :t}]}],
      opts: opts
    })
  end

  @doc """
  List commit comments for a repository

  Commit Comments use [these custom media types](https://docs.github.com/rest/overview/media-types). You can read more about the use of media types in the API [here](https://docs.github.com/rest/overview/media-types/).

  Comments are ordered by ascending ID.

  ## Options

    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.

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
      response: [{200, [{GitHub.Commit.Comment, :t}]}],
      opts: opts
    })
  end

  @doc """
  List commit statuses for a reference

  Users with pull access in a repository can view commit statuses for a given ref. The ref can be a SHA, a branch name, or a tag name. Statuses are returned in reverse chronological order. The first status in the list will be the latest one.

  This resource is also available via a legacy route: `GET /repos/:owner/:repo/statuses/:ref`.

  ## Options

    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.

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
      response: [{200, [{GitHub.Status, :t}]}, {301, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  List commits

  **Signature verification object**

  The response will include a `verification` object that describes the result of verifying the commit's signature. The following fields are included in the `verification` object:

  | Name | Type | Description |
  | ---- | ---- | ----------- |
  | `verified` | `boolean` | Indicates whether GitHub considers the signature in this commit to be verified. |
  | `reason` | `string` | The reason for verified value. Possible values and their meanings are enumerated in table below. |
  | `signature` | `string` | The signature that was extracted from the commit. |
  | `payload` | `string` | The value that was signed. |

  These are the possible values for `reason` in the `verification` object:

  | Value | Description |
  | ----- | ----------- |
  | `expired_key` | The key that made the signature is expired. |
  | `not_signing_key` | The "signing" flag is not among the usage flags in the GPG key that made the signature. |
  | `gpgverify_error` | There was an error communicating with the signature verification service. |
  | `gpgverify_unavailable` | The signature verification service is currently unavailable. |
  | `unsigned` | The object does not include a signature. |
  | `unknown_signature_type` | A non-PGP signature was found in the commit. |
  | `no_user` | No user was associated with the `committer` email address in the commit. |
  | `unverified_email` | The `committer` email address in the commit was associated with a user, but the email address is not verified on their account. |
  | `bad_email` | The `committer` email address in the commit is not included in the identities of the PGP key that made the signature. |
  | `unknown_key` | The key that made the signature has not been registered with any user's account. |
  | `malformed_signature` | There was an error parsing the signature. |
  | `invalid` | The signature could not be cryptographically verified using the key whose key-id was found in the signature. |
  | `valid` | None of the above errors applied, so the signature is considered to be verified. |

  ## Options

    * `sha`: SHA or branch to start listing commits from. Default: the repository’s default branch (usually `main`).
    * `path`: Only commits containing this file path will be returned.
    * `author`: GitHub username or email address to use to filter by commit author.
    * `committer`: GitHub username or email address to use to filter by commit committer.
    * `since`: Only show results that were last updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    * `until`: Only commits before this date will be returned. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/commits/commits#list-commits)

  """
  @spec list_commits(String.t(), String.t(), keyword) ::
          {:ok, [GitHub.Commit.t()]} | {:error, GitHub.Error.t()}
  def list_commits(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    query =
      Keyword.take(opts, [:author, :committer, :page, :path, :per_page, :sha, :since, :until])

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :list_commits},
      url: "/repos/#{owner}/#{repo}/commits",
      method: :get,
      query: query,
      response: [
        {200, [{GitHub.Commit, :t}]},
        {400, {:union, [{GitHub.BasicError, :t}, {GitHub.SCIM.Error, :t}]}},
        {404, {GitHub.BasicError, :t}},
        {409, {GitHub.BasicError, :t}},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List repository contributors

  Lists contributors to the specified repository and sorts them by the number of commits per contributor in descending order. This endpoint may return information that is a few hours old because the GitHub REST API caches contributor data to improve performance.

  GitHub identifies contributors by author email address. This endpoint groups contribution counts by GitHub user, which includes all associated email addresses. To improve performance, only the first 500 author email addresses in the repository link to GitHub users. The rest will appear as anonymous contributors without associated GitHub user information.

  ## Options

    * `anon`: Set to `1` or `true` to include anonymous contributors in results.
    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/repos/repos#list-repository-contributors)

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
        {200, [{GitHub.Contributor, :t}]},
        {204, :null},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List custom deployment rule integrations available for an environment

  Gets all custom deployment protection rule integrations that are available for an environment. Anyone with read access to the repository can use this endpoint. If the repository is private and you want to use a personal access token (classic), you must use an access token with the `repo` scope. GitHub Apps and fine-grained personal access tokens must have the `actions:read` permission to use this endpoint.

  For more information about environments, see "[Using environments for deployment](https://docs.github.com/en/actions/deployment/targeting-different-environments/using-environments-for-deployment)."

  For more information about the app that is providing this custom deployment rule, see "[GET an app](https://docs.github.com/rest/apps/apps#get-an-app)".

  ## Options

    * `page`: Page number of the results to fetch.
    * `per_page`: The number of results per page (max 100).

  ## Resources

    * [API method documentation](https://docs.github.com/rest/deployments/protection-rules#list-custom-deployment-rule-integrations-available-for-an-environment)

  """
  @spec list_custom_deployment_rule_integrations(String.t(), String.t(), String.t(), keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def list_custom_deployment_rule_integrations(environment_name, repo, owner, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [environment_name: environment_name, repo: repo, owner: owner],
      call: {GitHub.Repos, :list_custom_deployment_rule_integrations},
      url:
        "/repos/#{owner}/#{repo}/environments/#{environment_name}/deployment_protection_rules/apps",
      method: :get,
      query: query,
      response: [{200, :map}],
      opts: opts
    })
  end

  @doc """
  List deploy keys

  ## Options

    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/deploy-keys/deploy-keys#list-deploy-keys)

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
      response: [{200, [{GitHub.DeployKey, :t}]}],
      opts: opts
    })
  end

  @doc """
  List deployment branch policies

  Lists the deployment branch policies for an environment.

  Anyone with read access to the repository can use this endpoint. If the repository is private, you must use an access token with the `repo` scope. GitHub Apps must have the `actions:read` permission to use this endpoint.

  ## Options

    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.

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

  Users with pull access can view deployment statuses for a deployment:

  ## Options

    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.

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
      response: [{200, [{GitHub.Deployment.Status, :t}]}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  List deployments

  Simple filtering of deployments is available via query parameters:

  ## Options

    * `sha`: The SHA recorded at creation time.
    * `ref`: The name of the ref. This can be a branch, tag, or SHA.
    * `task`: The name of the task for the deployment (e.g., `deploy` or `deploy:migrations`).
    * `environment`: The name of the environment that was deployed to (e.g., `staging` or `production`).
    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.

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
      response: [{200, [{GitHub.Deployment, :t}]}],
      opts: opts
    })
  end

  @doc """
  List repositories for the authenticated user

  Lists repositories that the authenticated user has explicit permission (`:read`, `:write`, or `:admin`) to access.

  The authenticated user has explicit permission to access repositories they own, repositories where they are a collaborator, and repositories that they can access through an organization membership.

  ## Options

    * `visibility`: Limit results to repositories with the specified visibility.
    * `affiliation`: Comma-separated list of values. Can include:  
       * `owner`: Repositories that are owned by the authenticated user.  
       * `collaborator`: Repositories that the user has been added to as a collaborator.  
       * `organization_member`: Repositories that the user has access to through being a member of an organization. This includes every repository on every team that the user is on.
    * `type`: Limit results to repositories of the specified type. Will cause a `422` error if used in the same request as **visibility** or **affiliation**.
    * `sort`: The property to sort the results by.
    * `direction`: The order to sort by. Default: `asc` when using `full_name`, otherwise `desc`.
    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.
    * `since`: Only show repositories updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    * `before`: Only show repositories updated before the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/repos/repos#list-repositories-for-the-authenticated-user)

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
      args: [],
      call: {GitHub.Repos, :list_for_authenticated_user},
      url: "/user/repos",
      method: :get,
      query: query,
      response: [
        {200, [{GitHub.Repository, :t}]},
        {304, :null},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List organization repositories

  Lists repositories for the specified organization.

  **Note:** In order to see the `security_and_analysis` block for a repository you must have admin permissions for the repository or be an owner or security manager for the organization that owns the repository. For more information, see "[Managing security managers in your organization](https://docs.github.com/organizations/managing-peoples-access-to-your-organization-with-roles/managing-security-managers-in-your-organization)."

  ## Options

    * `type`: Specifies the types of repositories you want returned.
    * `sort`: The property to sort the results by.
    * `direction`: The order to sort by. Default: `asc` when using `full_name`, otherwise `desc`.
    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/repos/repos#list-organization-repositories)

  """
  @spec list_for_org(String.t(), keyword) ::
          {:ok, [GitHub.Repository.minimal()]} | {:error, GitHub.Error.t()}
  def list_for_org(org, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:direction, :page, :per_page, :sort, :type])

    client.request(%{
      args: [org: org],
      call: {GitHub.Repos, :list_for_org},
      url: "/orgs/#{org}/repos",
      method: :get,
      query: query,
      response: [{200, [{GitHub.Repository, :minimal}]}],
      opts: opts
    })
  end

  @doc """
  List repositories for a user

  Lists public repositories for the specified user. Note: For GitHub AE, this endpoint will list internal repositories for the specified user.

  ## Options

    * `type`: Limit results to repositories of the specified type.
    * `sort`: The property to sort the results by.
    * `direction`: The order to sort by. Default: `asc` when using `full_name`, otherwise `desc`.
    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/repos/repos#list-repositories-for-a-user)

  """
  @spec list_for_user(String.t(), keyword) ::
          {:ok, [GitHub.Repository.minimal()]} | {:error, GitHub.Error.t()}
  def list_for_user(username, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:direction, :page, :per_page, :sort, :type])

    client.request(%{
      args: [username: username],
      call: {GitHub.Repos, :list_for_user},
      url: "/users/#{username}/repos",
      method: :get,
      query: query,
      response: [{200, [{GitHub.Repository, :minimal}]}],
      opts: opts
    })
  end

  @doc """
  List forks

  ## Options

    * `sort`: The sort order. `stargazers` will sort by star count.
    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/repos/forks#list-forks)

  """
  @spec list_forks(String.t(), String.t(), keyword) ::
          {:ok, [GitHub.Repository.minimal()]} | {:error, GitHub.Error.t()}
  def list_forks(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page, :sort])

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Repos, :list_forks},
      url: "/repos/#{owner}/#{repo}/forks",
      method: :get,
      query: query,
      response: [
        {200, [{GitHub.Repository, :minimal}]},
        {400, {:union, [{GitHub.BasicError, :t}, {GitHub.SCIM.Error, :t}]}}
      ],
      opts: opts
    })
  end

  @doc """
  List repository invitations

  When authenticating as a user with admin rights to a repository, this endpoint will list all currently open repository invitations.

  ## Options

    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.

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
      response: [{200, [{GitHub.Repository.Invitation, :t}]}],
      opts: opts
    })
  end

  @doc """
  List repository invitations for the authenticated user

  When authenticating as a user, this endpoint will list all currently open repository invitations for that user.

  ## Options

    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/collaborators/invitations#list-repository-invitations-for-the-authenticated-user)

  """
  @spec list_invitations_for_authenticated_user(keyword) ::
          {:ok, [GitHub.Repository.Invitation.t()]} | {:error, GitHub.Error.t()}
  def list_invitations_for_authenticated_user(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [],
      call: {GitHub.Repos, :list_invitations_for_authenticated_user},
      url: "/user/repository_invitations",
      method: :get,
      query: query,
      response: [
        {200, [{GitHub.Repository.Invitation, :t}]},
        {304, :null},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List repository languages

  Lists languages for the specified repository. The value shown for each language is the number of bytes of code written in that language.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/repos/repos#list-repository-languages)

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

  Lists builts of a GitHub Pages site.

  A token with the `repo` scope is required. GitHub Apps must have the `pages:read` permission.

  ## Options

    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/pages/pages#list-apiname-pages-builds)

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
      response: [{200, [{GitHub.Pages.Build, :t}]}],
      opts: opts
    })
  end

  @doc """
  List public repositories

  Lists all public repositories in the order that they were created.

  Note:
  - For GitHub Enterprise Server, this endpoint will only list repositories available to all users on the enterprise.
  - Pagination is powered exclusively by the `since` parameter. Use the [Link header](https://docs.github.com/rest/guides/using-pagination-in-the-rest-api#using-link-headers) to get the URL for the next page of repositories.

  ## Options

    * `since`: A repository ID. Only return repositories with an ID greater than this ID.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/repos/repos#list-public-repositories)

  """
  @spec list_public(keyword) :: {:ok, [GitHub.Repository.minimal()]} | {:error, GitHub.Error.t()}
  def list_public(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:since])

    client.request(%{
      args: [],
      call: {GitHub.Repos, :list_public},
      url: "/repositories",
      method: :get,
      query: query,
      response: [
        {200, [{GitHub.Repository, :minimal}]},
        {304, :null},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List pull requests associated with a commit

  Lists the merged pull request that introduced the commit to the repository. If the commit is not present in the default branch, will only return open pull requests associated with the commit.

  To list the open or merged pull requests associated with a branch, you can set the `commit_sha` parameter to the branch name.

  ## Options

    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.

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
      response: [{200, [{GitHub.PullRequest, :simple}]}],
      opts: opts
    })
  end

  @doc """
  List release assets

  ## Options

    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/releases/assets#list-release-assets)

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
      response: [{200, [{GitHub.Release.Asset, :t}]}],
      opts: opts
    })
  end

  @doc """
  List releases

  This returns a list of releases, which does not include regular Git tags that have not been associated with a release. To get a list of Git tags, use the [Repository Tags API](https://docs.github.com/rest/repos/repos#list-repository-tags).

  Information about published releases are available to everyone. Only users with push access will receive listings for draft releases.

  ## Options

    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/releases/releases#list-releases)

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
      response: [{200, [{GitHub.Release, :t}]}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  List tag protection states for a repository

  This returns the tag protection states of a repository.

  This information is only available to repository administrators.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/repos/tags#list-tag-protection-states-for-a-repository)

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
        {200, [{GitHub.TagProtection, :t}]},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List repository tags

  ## Options

    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/repos/repos#list-repository-tags)

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
      response: [{200, [{GitHub.Tag, :t}]}],
      opts: opts
    })
  end

  @doc """
  List repository teams

  Lists the teams that have access to the specified repository and that are also visible to the authenticated user.

  For a public repository, a team is listed only if that team added the public repository explicitly.

  Personal access tokens require the following scopes:
  * `public_repo` to call this endpoint on a public repository
  * `repo` to call this endpoint on a private repository (this scope also includes public repositories)

  This endpoint is not compatible with fine-grained personal access tokens.

  ## Options

    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/repos/repos#list-repository-teams)

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
      response: [{200, [{GitHub.Team, :t}]}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  List deliveries for a repository webhook

  Returns a list of webhook deliveries for a webhook configured in a repository.

  ## Options

    * `per_page`: The number of results per page (max 100).
    * `cursor`: Used for pagination: the starting delivery from which the page of deliveries is fetched. Refer to the `link` header for the next and previous page cursors.
    * `redelivery`

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
        {200, [{GitHub.Hook.DeliveryItem, :t}]},
        {400, {:union, [{GitHub.BasicError, :t}, {GitHub.SCIM.Error, :t}]}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List repository webhooks

  Lists webhooks for a repository. `last response` may return null if there have not been any deliveries within 30 days.

  ## Options

    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.

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
      response: [{200, [{GitHub.Hook, :t}]}, {404, {GitHub.BasicError, :t}}],
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
      args: [owner: owner, repo: repo, body: body],
      call: {GitHub.Repos, :merge},
      url: "/repos/#{owner}/#{repo}/merges",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {201, {GitHub.Commit, :t}},
        {204, :null},
        {403, {GitHub.BasicError, :t}},
        {404, :null},
        {409, :null},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Sync a fork branch with the upstream repository

  Sync a branch of a forked repository to keep it up-to-date with the upstream repository.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/branches/branches#sync-a-fork-branch-with-the-upstream-repository)

  """
  @spec merge_upstream(String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.MergedUpstream.t()} | {:error, GitHub.Error.t()}
  def merge_upstream(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, body: body],
      call: {GitHub.Repos, :merge_upstream},
      url: "/repos/#{owner}/#{repo}/merge-upstream",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, {GitHub.MergedUpstream, :t}}, {409, :null}, {422, :null}],
      opts: opts
    })
  end

  @doc """
  Ping a repository webhook

  This will trigger a [ping event](https://docs.github.com/webhooks/#ping-event) to be sent to the hook.

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
      response: [{204, :null}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Redeliver a delivery for a repository webhook

  Redeliver a webhook delivery for a webhook configured in a repository.

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
      response: [
        {202, :map},
        {400, {:union, [{GitHub.BasicError, :t}, {GitHub.SCIM.Error, :t}]}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Remove app access restrictions

  Protected branches are available in public repositories with GitHub Free and GitHub Free for organizations, and in public and private repositories with GitHub Pro, GitHub Team, GitHub Enterprise Cloud, and GitHub Enterprise Server. For more information, see [GitHub's products](https://docs.github.com/github/getting-started-with-github/githubs-products) in the GitHub Help documentation.

  Removes the ability of an app to push to this branch. Only installed GitHub Apps with `write` access to the `contents` permission can be added as authorized actors on a protected branch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/branches/branch-protection#remove-app-access-restrictions)

  """
  @spec remove_app_access_restrictions(
          String.t(),
          String.t(),
          String.t(),
          map | [String.t()],
          keyword
        ) :: {:ok, [GitHub.App.t()]} | {:error, GitHub.Error.t()}
  def remove_app_access_restrictions(owner, repo, branch, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, branch: branch, body: body],
      call: {GitHub.Repos, :remove_app_access_restrictions},
      url: "/repos/#{owner}/#{repo}/branches/#{branch}/protection/restrictions/apps",
      body: body,
      method: :delete,
      request: [{"application/json", {:union, [:map, [string: :generic]]}}],
      response: [{200, [{GitHub.App, :t}]}, {422, {GitHub.ValidationError, :t}}],
      opts: opts
    })
  end

  @doc """
  Remove a repository collaborator

  Removes a collaborator from a repository.

  To use this endpoint, the authenticated user must either be an administrator of the repository or target themselves for removal.

  This endpoint also:
  - Cancels any outstanding invitations
  - Unasigns the user from any issues
  - Removes access to organization projects if the user is not an organization member and is not a collaborator on any other organization repositories.
  - Unstars the repository
  - Updates access permissions to packages

  Removing a user as a collaborator has the following effects on forks:
   - If the user had access to a fork through their membership to this repository, the user will also be removed from the fork.
   - If the user had their own fork of the repository, the fork will be deleted.
   - If the user still has read access to the repository, open pull requests by this user from a fork will be denied.

  **Note**: A user can still have access to the repository through organization permissions like base repository permissions.

  Although the API responds immediately, the additional permission updates might take some extra time to complete in the background.

  For more information on fork permissions, see "[About permissions and visibility of forks](https://docs.github.com/pull-requests/collaborating-with-pull-requests/working-with-forks/about-permissions-and-visibility-of-forks)".

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
      response: [
        {204, :null},
        {403, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Remove status check contexts

  Protected branches are available in public repositories with GitHub Free and GitHub Free for organizations, and in public and private repositories with GitHub Pro, GitHub Team, GitHub Enterprise Cloud, and GitHub Enterprise Server. For more information, see [GitHub's products](https://docs.github.com/github/getting-started-with-github/githubs-products) in the GitHub Help documentation.

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
      args: [owner: owner, repo: repo, branch: branch, body: body],
      call: {GitHub.Repos, :remove_status_check_contexts},
      url:
        "/repos/#{owner}/#{repo}/branches/#{branch}/protection/required_status_checks/contexts",
      body: body,
      method: :delete,
      request: [{"application/json", {:union, [:map, [string: :generic]]}}],
      response: [
        {200, [string: :generic]},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Remove status check protection

  Protected branches are available in public repositories with GitHub Free and GitHub Free for organizations, and in public and private repositories with GitHub Pro, GitHub Team, GitHub Enterprise Cloud, and GitHub Enterprise Server. For more information, see [GitHub's products](https://docs.github.com/github/getting-started-with-github/githubs-products) in the GitHub Help documentation.

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
      response: [{204, :null}],
      opts: opts
    })
  end

  @doc """
  Remove team access restrictions

  Protected branches are available in public repositories with GitHub Free and GitHub Free for organizations, and in public and private repositories with GitHub Pro, GitHub Team, GitHub Enterprise Cloud, and GitHub Enterprise Server. For more information, see [GitHub's products](https://docs.github.com/github/getting-started-with-github/githubs-products) in the GitHub Help documentation.

  Removes the ability of a team to push to this branch. You can also remove push access for child teams.

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
      args: [owner: owner, repo: repo, branch: branch, body: body],
      call: {GitHub.Repos, :remove_team_access_restrictions},
      url: "/repos/#{owner}/#{repo}/branches/#{branch}/protection/restrictions/teams",
      body: body,
      method: :delete,
      request: [{"application/json", {:union, [:map, [string: :generic]]}}],
      response: [{200, [{GitHub.Team, :t}]}, {422, {GitHub.ValidationError, :t}}],
      opts: opts
    })
  end

  @doc """
  Remove user access restrictions

  Protected branches are available in public repositories with GitHub Free and GitHub Free for organizations, and in public and private repositories with GitHub Pro, GitHub Team, GitHub Enterprise Cloud, and GitHub Enterprise Server. For more information, see [GitHub's products](https://docs.github.com/github/getting-started-with-github/githubs-products) in the GitHub Help documentation.

  Removes the ability of a user to push to this branch.

  | Type    | Description                                                                                                                                   |
  | ------- | --------------------------------------------------------------------------------------------------------------------------------------------- |
  | `array` | Usernames of the people who should no longer have push access. **Note**: The list of users, apps, and teams in total is limited to 100 items. |

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
      args: [owner: owner, repo: repo, branch: branch, body: body],
      call: {GitHub.Repos, :remove_user_access_restrictions},
      url: "/repos/#{owner}/#{repo}/branches/#{branch}/protection/restrictions/users",
      body: body,
      method: :delete,
      request: [{"application/json", {:union, [:map, [string: :generic]]}}],
      response: [{200, [{GitHub.User, :simple}]}, {422, {GitHub.ValidationError, :t}}],
      opts: opts
    })
  end

  @doc """
  Rename a branch

  Renames a branch in a repository.

  **Note:** Although the API responds immediately, the branch rename process might take some extra time to complete in the background. You won't be able to push to the old branch name while the rename process is in progress. For more information, see "[Renaming a branch](https://docs.github.com/github/administering-a-repository/renaming-a-branch)".

  The permissions required to use this endpoint depends on whether you are renaming the default branch.

  To rename a non-default branch:

  * Users must have push access.
  * GitHub Apps must have the `contents:write` repository permission.

  To rename the default branch:

  * Users must have admin or owner permissions.
  * GitHub Apps must have the `administration:write` repository permission.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/branches/branches#rename-a-branch)

  """
  @spec rename_branch(String.t(), String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.Branch.WithProtection.t()} | {:error, GitHub.Error.t()}
  def rename_branch(owner, repo, branch, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, branch: branch, body: body],
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

    * [API method documentation](https://docs.github.com/rest/repos/repos#replace-all-repository-topics)

  """
  @spec replace_all_topics(String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.Topic.t()} | {:error, GitHub.Error.t()}
  def replace_all_topics(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, body: body],
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

  You can request that your site be built from the latest revision on the default branch. This has the same effect as pushing a commit to your default branch, but does not require an additional commit. Manually triggering page builds can be helpful when diagnosing build warnings and failures.

  Build requests are limited to one concurrent build per repository and one concurrent build per requester. If you request a build while another is still in progress, the second request will be queued until the first completes.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/pages/pages#request-a-apiname-pages-build)

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

  Protected branches are available in public repositories with GitHub Free and GitHub Free for organizations, and in public and private repositories with GitHub Pro, GitHub Team, GitHub Enterprise Cloud, and GitHub Enterprise Server. For more information, see [GitHub's products](https://docs.github.com/github/getting-started-with-github/githubs-products) in the GitHub Help documentation.

  Adding admin enforcement requires admin or owner permissions to the repository and branch protection to be enabled.

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

  Protected branches are available in public repositories with GitHub Free and GitHub Free for organizations, and in public and private repositories with GitHub Pro, GitHub Team, GitHub Enterprise Cloud, and GitHub Enterprise Server. For more information, see [GitHub's products](https://docs.github.com/github/getting-started-with-github/githubs-products) in the GitHub Help documentation.

  Replaces the list of apps that have push access to this branch. This removes all apps that previously had push access and grants push access to the new list of apps. Only installed GitHub Apps with `write` access to the `contents` permission can be added as authorized actors on a protected branch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/branches/branch-protection#set-app-access-restrictions)

  """
  @spec set_app_access_restrictions(
          String.t(),
          String.t(),
          String.t(),
          map | [String.t()],
          keyword
        ) :: {:ok, [GitHub.App.t()]} | {:error, GitHub.Error.t()}
  def set_app_access_restrictions(owner, repo, branch, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, branch: branch, body: body],
      call: {GitHub.Repos, :set_app_access_restrictions},
      url: "/repos/#{owner}/#{repo}/branches/#{branch}/protection/restrictions/apps",
      body: body,
      method: :put,
      request: [{"application/json", {:union, [:map, [string: :generic]]}}],
      response: [{200, [{GitHub.App, :t}]}, {422, {GitHub.ValidationError, :t}}],
      opts: opts
    })
  end

  @doc """
  Set status check contexts

  Protected branches are available in public repositories with GitHub Free and GitHub Free for organizations, and in public and private repositories with GitHub Pro, GitHub Team, GitHub Enterprise Cloud, and GitHub Enterprise Server. For more information, see [GitHub's products](https://docs.github.com/github/getting-started-with-github/githubs-products) in the GitHub Help documentation.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/branches/branch-protection#set-status-check-contexts)

  """
  @spec set_status_check_contexts(String.t(), String.t(), String.t(), map | [String.t()], keyword) ::
          {:ok, [String.t()]} | {:error, GitHub.Error.t()}
  def set_status_check_contexts(owner, repo, branch, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, branch: branch, body: body],
      call: {GitHub.Repos, :set_status_check_contexts},
      url:
        "/repos/#{owner}/#{repo}/branches/#{branch}/protection/required_status_checks/contexts",
      body: body,
      method: :put,
      request: [{"application/json", {:union, [:map, [string: :generic]]}}],
      response: [
        {200, [string: :generic]},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Set team access restrictions

  Protected branches are available in public repositories with GitHub Free and GitHub Free for organizations, and in public and private repositories with GitHub Pro, GitHub Team, GitHub Enterprise Cloud, and GitHub Enterprise Server. For more information, see [GitHub's products](https://docs.github.com/github/getting-started-with-github/githubs-products) in the GitHub Help documentation.

  Replaces the list of teams that have push access to this branch. This removes all teams that previously had push access and grants push access to the new list of teams. Team restrictions include child teams.

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
      args: [owner: owner, repo: repo, branch: branch, body: body],
      call: {GitHub.Repos, :set_team_access_restrictions},
      url: "/repos/#{owner}/#{repo}/branches/#{branch}/protection/restrictions/teams",
      body: body,
      method: :put,
      request: [{"application/json", {:union, [:map, [string: :generic]]}}],
      response: [{200, [{GitHub.Team, :t}]}, {422, {GitHub.ValidationError, :t}}],
      opts: opts
    })
  end

  @doc """
  Set user access restrictions

  Protected branches are available in public repositories with GitHub Free and GitHub Free for organizations, and in public and private repositories with GitHub Pro, GitHub Team, GitHub Enterprise Cloud, and GitHub Enterprise Server. For more information, see [GitHub's products](https://docs.github.com/github/getting-started-with-github/githubs-products) in the GitHub Help documentation.

  Replaces the list of people that have push access to this branch. This removes all people that previously had push access and grants push access to the new list of people.

  | Type    | Description                                                                                                                   |
  | ------- | ----------------------------------------------------------------------------------------------------------------------------- |
  | `array` | Usernames for people who can have push access. **Note**: The list of users, apps, and teams in total is limited to 100 items. |

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
      args: [owner: owner, repo: repo, branch: branch, body: body],
      call: {GitHub.Repos, :set_user_access_restrictions},
      url: "/repos/#{owner}/#{repo}/branches/#{branch}/protection/restrictions/users",
      body: body,
      method: :put,
      request: [{"application/json", {:union, [:map, [string: :generic]]}}],
      response: [{200, [{GitHub.User, :simple}]}, {422, {GitHub.ValidationError, :t}}],
      opts: opts
    })
  end

  @doc """
  Test the push repository webhook

  This will trigger the hook with the latest push to the current repository if the hook is subscribed to `push` events. If the hook is not subscribed to `push` events, the server will respond with 204 but no test POST will be generated.

  **Note**: Previously `/repos/:owner/:repo/hooks/:hook_id/test`

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
      response: [{204, :null}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Transfer a repository

  A transfer request will need to be accepted by the new owner when transferring a personal repository to another user. The response will contain the original `owner`, and the transfer will continue asynchronously. For more details on the requirements to transfer personal and organization-owned repositories, see [about repository transfers](https://docs.github.com/articles/about-repository-transfers/).
  You must use a personal access token (classic) or an OAuth token for this endpoint. An installation access token or a fine-grained personal access token cannot be used because they are only granted access to a single account.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/repos/repos#transfer-a-repository)

  """
  @spec transfer(String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.Repository.minimal()} | {:error, GitHub.Error.t()}
  def transfer(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, body: body],
      call: {GitHub.Repos, :transfer},
      url: "/repos/#{owner}/#{repo}/transfer",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{202, {GitHub.Repository, :minimal}}],
      opts: opts
    })
  end

  @doc """
  Update a repository

  **Note**: To edit a repository's topics, use the [Replace all repository topics](https://docs.github.com/rest/repos/repos#replace-all-repository-topics) endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/repos/repos#update-a-repository)

  """
  @spec update(String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.Repository.full()} | {:error, GitHub.Error.t()}
  def update(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, body: body],
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

  Protected branches are available in public repositories with GitHub Free and GitHub Free for organizations, and in public and private repositories with GitHub Pro, GitHub Team, GitHub Enterprise Cloud, and GitHub Enterprise Server. For more information, see [GitHub's products](https://docs.github.com/github/getting-started-with-github/githubs-products) in the GitHub Help documentation.

  Protecting a branch requires admin or owner permissions to the repository.

  **Note**: Passing new arrays of `users` and `teams` replaces their previous values.

  **Note**: The list of users, apps, and teams in total is limited to 100 items.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/branches/branch-protection#update-branch-protection)

  """
  @spec update_branch_protection(String.t(), String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.ProtectedBranch.t()} | {:error, GitHub.Error.t()}
  def update_branch_protection(owner, repo, branch, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, branch: branch, body: body],
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
      args: [owner: owner, repo: repo, comment_id: comment_id, body: body],
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

  Updates a deployment branch policy for an environment.

  You must authenticate using an access token with the `repo` scope to use this endpoint. GitHub Apps must have the `administration:write` permission for the repository to use this endpoint.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/deployments/branch-policies#update-a-deployment-branch-policy)

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
        branch_policy_id: branch_policy_id,
        body: body
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

  Updates information for a GitHub Pages site. For more information, see "[About GitHub Pages](https://docs.github.com/github/working-with-github-pages/about-github-pages).

  To use this endpoint, you must be a repository administrator, maintainer, or have the 'manage GitHub Pages settings' permission. A token with the `repo` scope or Pages write permission is required. GitHub Apps must have the `administration:write` and `pages:write` permissions.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/pages/pages#update-information-about-a-apiname-pages-site)

  """
  @spec update_information_about_pages_site(String.t(), String.t(), map, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def update_information_about_pages_site(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, body: body],
      call: {GitHub.Repos, :update_information_about_pages_site},
      url: "/repos/#{owner}/#{repo}/pages",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [
        {204, :null},
        {400, {:union, [{GitHub.BasicError, :t}, {GitHub.SCIM.Error, :t}]}},
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
      args: [owner: owner, repo: repo, invitation_id: invitation_id, body: body],
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
  Update an organization repository ruleset

  Update a ruleset for an organization.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/orgs/rules#update-an-organization-repository-ruleset)

  """
  @spec update_org_ruleset(String.t(), integer, map, keyword) ::
          {:ok, GitHub.Repository.Ruleset.t()} | {:error, GitHub.Error.t()}
  def update_org_ruleset(org, ruleset_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, ruleset_id: ruleset_id, body: body],
      call: {GitHub.Repos, :update_org_ruleset},
      url: "/orgs/#{org}/rulesets/#{ruleset_id}",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [
        {200, {GitHub.Repository.Ruleset, :t}},
        {404, {GitHub.BasicError, :t}},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Update pull request review protection

  Protected branches are available in public repositories with GitHub Free and GitHub Free for organizations, and in public and private repositories with GitHub Pro, GitHub Team, GitHub Enterprise Cloud, and GitHub Enterprise Server. For more information, see [GitHub's products](https://docs.github.com/github/getting-started-with-github/githubs-products) in the GitHub Help documentation.

  Updating pull request review enforcement requires admin or owner permissions to the repository and branch protection to be enabled.

  **Note**: Passing new arrays of `users` and `teams` replaces their previous values.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/branches/branch-protection#update-pull-request-review-protection)

  """
  @spec update_pull_request_review_protection(String.t(), String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.ProtectedBranch.PullRequestReview.t()} | {:error, GitHub.Error.t()}
  def update_pull_request_review_protection(owner, repo, branch, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, branch: branch, body: body],
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

  Users with push access to the repository can edit a release.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/releases/releases#update-a-release)

  """
  @spec update_release(String.t(), String.t(), integer, map, keyword) ::
          {:ok, GitHub.Release.t()} | {:error, GitHub.Error.t()}
  def update_release(owner, repo, release_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, release_id: release_id, body: body],
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

  Users with push access to the repository can edit a release asset.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/releases/assets#update-a-release-asset)

  """
  @spec update_release_asset(String.t(), String.t(), integer, map, keyword) ::
          {:ok, GitHub.Release.Asset.t()} | {:error, GitHub.Error.t()}
  def update_release_asset(owner, repo, asset_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, asset_id: asset_id, body: body],
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
  Update a repository ruleset

  Update a ruleset for a repository.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/repos/rules#update-a-repository-ruleset)

  """
  @spec update_repo_ruleset(String.t(), String.t(), integer, map, keyword) ::
          {:ok, GitHub.Repository.Ruleset.t()} | {:error, GitHub.Error.t()}
  def update_repo_ruleset(owner, repo, ruleset_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, ruleset_id: ruleset_id, body: body],
      call: {GitHub.Repos, :update_repo_ruleset},
      url: "/repos/#{owner}/#{repo}/rulesets/#{ruleset_id}",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [
        {200, {GitHub.Repository.Ruleset, :t}},
        {404, {GitHub.BasicError, :t}},
        {500, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Update status check protection

  Protected branches are available in public repositories with GitHub Free and GitHub Free for organizations, and in public and private repositories with GitHub Pro, GitHub Team, GitHub Enterprise Cloud, and GitHub Enterprise Server. For more information, see [GitHub's products](https://docs.github.com/github/getting-started-with-github/githubs-products) in the GitHub Help documentation.

  Updating required status checks requires admin or owner permissions to the repository and branch protection to be enabled.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/branches/branch-protection#update-status-check-protection)

  """
  @spec update_status_check_protection(String.t(), String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.StatusCheckPolicy.t()} | {:error, GitHub.Error.t()}
  def update_status_check_protection(owner, repo, branch, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, branch: branch, body: body],
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

  Updates a webhook configured in a repository. If you previously had a `secret` set, you must provide the same `secret` or set a new `secret` or the secret will be removed. If you are only updating individual webhook `config` properties, use "[Update a webhook configuration for a repository](https://docs.github.com/rest/webhooks/repo-config#update-a-webhook-configuration-for-a-repository)."

  ## Resources

    * [API method documentation](https://docs.github.com/rest/webhooks/repos#update-a-repository-webhook)

  """
  @spec update_webhook(String.t(), String.t(), integer, map, keyword) ::
          {:ok, GitHub.Hook.t()} | {:error, GitHub.Error.t()}
  def update_webhook(owner, repo, hook_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, hook_id: hook_id, body: body],
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

  Updates the webhook configuration for a repository. To update more information about the webhook, including the `active` state and `events`, use "[Update a repository webhook](https://docs.github.com/rest/webhooks/repos#update-a-repository-webhook)."

  Access tokens must have the `write:repo_hook` or `repo` scope, and GitHub Apps must have the `repository_hooks:write` permission.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/webhooks/repo-config#update-a-webhook-configuration-for-a-repository)

  """
  @spec update_webhook_config_for_repo(String.t(), String.t(), integer, map, keyword) ::
          {:ok, GitHub.Webhook.Config.t()} | {:error, GitHub.Error.t()}
  def update_webhook_config_for_repo(owner, repo, hook_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, hook_id: hook_id, body: body],
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

  This endpoint makes use of [a Hypermedia relation](https://docs.github.com/rest/overview/resources-in-the-rest-api#hypermedia) to determine which URL to access. The endpoint you call to upload release assets is specific to your release. Use the `upload_url` returned in
  the response of the [Create a release endpoint](https://docs.github.com/rest/releases/releases#create-a-release) to upload a release asset.

  You need to use an HTTP client which supports [SNI](http://en.wikipedia.org/wiki/Server_Name_Indication) to make calls to this endpoint.

  Most libraries will set the required `Content-Length` header automatically. Use the required `Content-Type` header to provide the media type of the asset. For a list of media types, see [Media Types](https://www.iana.org/assignments/media-types/media-types.xhtml). For example: 

  `application/zip`

  GitHub expects the asset data in its raw binary form, rather than JSON. You will send the raw binary content of the asset as the request body. Everything else about the endpoint is the same as the rest of the API. For example,
  you'll still need to pass your authentication to be able to upload an asset.

  When an upstream failure occurs, you will receive a `502 Bad Gateway` status. This may leave an empty asset with a state of `starter`. It can be safely deleted.

  **Notes:**
  *   GitHub renames asset filenames that have special characters, non-alphanumeric characters, and leading or trailing periods. The "[List release assets](https://docs.github.com/rest/releases/assets#list-release-assets)"
  endpoint lists the renamed filenames. For more information and help, contact [GitHub Support](https://support.github.com/contact?tags=dotcom-rest-api).
  *   To find the `release_id` query the [`GET /repos/{owner}/{repo}/releases/latest` endpoint](https://docs.github.com/rest/releases/releases#get-the-latest-release). 
  *   If you upload an asset with the same filename as another uploaded asset, you'll receive an error and must delete the old file before you can re-upload the new asset.

  ## Options

    * `name`
    * `label`

  ## Resources

    * [API method documentation](https://docs.github.com/rest/releases/assets#upload-a-release-asset)

  """
  @spec upload_release_asset(String.t(), String.t(), integer, String.t(), keyword) ::
          {:ok, GitHub.Release.Asset.t()} | {:error, GitHub.Error.t()}
  def upload_release_asset(owner, repo, release_id, body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:label, :name])

    client.request(%{
      args: [owner: owner, repo: repo, release_id: release_id, body: body],
      call: {GitHub.Repos, :upload_release_asset},
      url: "/repos/#{owner}/#{repo}/releases/#{release_id}/assets",
      body: body,
      method: :post,
      query: query,
      request: [{"application/octet-stream", {:string, :generic}}],
      response: [{201, {GitHub.Release.Asset, :t}}, {422, :null}],
      opts: opts
    })
  end
end
