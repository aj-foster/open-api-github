defmodule GitHub.Teams do
  @moduledoc """
  Provides API endpoints related to teams
  """

  @default_client GitHub.Client

  @doc """
  Add team member (Legacy)

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams#add-team-member-legacy)

  """
  @spec add_member_legacy(integer, String.t(), keyword) :: :ok | {:error, GitHub.Error.t()}
  def add_member_legacy(team_id, username, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [team_id: team_id, username: username],
      call: {GitHub.Teams, :add_member_legacy},
      url: "/teams/#{team_id}/members/#{username}",
      method: :put,
      response: [{204, nil}, {403, {GitHub.BasicError, :t}}, {404, nil}, {422, nil}],
      opts: opts
    })
  end

  @doc """
  Add or update team membership for a user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams#add-or-update-team-membership-for-a-user)

  """
  @spec add_or_update_membership_for_user_in_org(String.t(), String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.Team.Membership.t()} | {:error, GitHub.Error.t()}
  def add_or_update_membership_for_user_in_org(org, team_slug, username, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, team_slug: team_slug, username: username],
      call: {GitHub.Teams, :add_or_update_membership_for_user_in_org},
      url: "/orgs/#{org}/teams/#{team_slug}/memberships/#{username}",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [{200, {GitHub.Team.Membership, :t}}, {403, nil}, {422, nil}],
      opts: opts
    })
  end

  @doc """
  Add or update team membership for a user (Legacy)

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams#add-or-update-team-membership-for-a-user-legacy)

  """
  @spec add_or_update_membership_for_user_legacy(integer, String.t(), map, keyword) ::
          {:ok, GitHub.Team.Membership.t()} | {:error, GitHub.Error.t()}
  def add_or_update_membership_for_user_legacy(team_id, username, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [team_id: team_id, username: username],
      call: {GitHub.Teams, :add_or_update_membership_for_user_legacy},
      url: "/teams/#{team_id}/memberships/#{username}",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [
        {200, {GitHub.Team.Membership, :t}},
        {403, nil},
        {404, {GitHub.BasicError, :t}},
        {422, nil}
      ],
      opts: opts
    })
  end

  @doc """
  Add or update team project permissions

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams#add-or-update-team-project-permissions)

  """
  @spec add_or_update_project_permissions_in_org(
          String.t(),
          String.t(),
          integer,
          map | nil,
          keyword
        ) :: :ok | {:error, GitHub.Error.t()}
  def add_or_update_project_permissions_in_org(org, team_slug, project_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, team_slug: team_slug, project_id: project_id],
      call: {GitHub.Teams, :add_or_update_project_permissions_in_org},
      url: "/orgs/#{org}/teams/#{team_slug}/projects/#{project_id}",
      body: body,
      method: :put,
      request: [{"application/json", {:nullable, :map}}],
      response: [{204, nil}, {403, :map}],
      opts: opts
    })
  end

  @doc """
  Add or update team project permissions (Legacy)

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams/#add-or-update-team-project-permissions-legacy)

  """
  @spec add_or_update_project_permissions_legacy(integer, integer, map, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def add_or_update_project_permissions_legacy(team_id, project_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [team_id: team_id, project_id: project_id],
      call: {GitHub.Teams, :add_or_update_project_permissions_legacy},
      url: "/teams/#{team_id}/projects/#{project_id}",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [
        {204, nil},
        {403, :map},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Add or update team repository permissions

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams/#add-or-update-team-repository-permissions)

  """
  @spec add_or_update_repo_permissions_in_org(
          String.t(),
          String.t(),
          String.t(),
          String.t(),
          map,
          keyword
        ) :: :ok | {:error, GitHub.Error.t()}
  def add_or_update_repo_permissions_in_org(org, team_slug, owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, team_slug: team_slug, owner: owner, repo: repo],
      call: {GitHub.Teams, :add_or_update_repo_permissions_in_org},
      url: "/orgs/#{org}/teams/#{team_slug}/repos/#{owner}/#{repo}",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Add or update team repository permissions (Legacy)

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams#add-or-update-team-repository-permissions-legacy)

  """
  @spec add_or_update_repo_permissions_legacy(integer, String.t(), String.t(), map, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def add_or_update_repo_permissions_legacy(team_id, owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [team_id: team_id, owner: owner, repo: repo],
      call: {GitHub.Teams, :add_or_update_repo_permissions_legacy},
      url: "/teams/#{team_id}/repos/#{owner}/#{repo}",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [{204, nil}, {403, {GitHub.BasicError, :t}}, {422, {GitHub.ValidationError, :t}}],
      opts: opts
    })
  end

  @doc """
  Check team permissions for a project

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams#check-team-permissions-for-a-project)

  """
  @spec check_permissions_for_project_in_org(String.t(), String.t(), integer, keyword) ::
          {:ok, GitHub.Team.Project.t()} | {:error, GitHub.Error.t()}
  def check_permissions_for_project_in_org(org, team_slug, project_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, team_slug: team_slug, project_id: project_id],
      call: {GitHub.Teams, :check_permissions_for_project_in_org},
      url: "/orgs/#{org}/teams/#{team_slug}/projects/#{project_id}",
      method: :get,
      response: [{200, {GitHub.Team.Project, :t}}, {404, nil}],
      opts: opts
    })
  end

  @doc """
  Check team permissions for a project (Legacy)

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams/#check-team-permissions-for-a-project-legacy)

  """
  @spec check_permissions_for_project_legacy(integer, integer, keyword) ::
          {:ok, GitHub.Team.Project.t()} | {:error, GitHub.Error.t()}
  def check_permissions_for_project_legacy(team_id, project_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [team_id: team_id, project_id: project_id],
      call: {GitHub.Teams, :check_permissions_for_project_legacy},
      url: "/teams/#{team_id}/projects/#{project_id}",
      method: :get,
      response: [{200, {GitHub.Team.Project, :t}}, {404, nil}],
      opts: opts
    })
  end

  @doc """
  Check team permissions for a repository

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams/#check-team-permissions-for-a-repository)

  """
  @spec check_permissions_for_repo_in_org(String.t(), String.t(), String.t(), String.t(), keyword) ::
          {:ok, GitHub.Team.Repository.t()} | {:error, GitHub.Error.t()}
  def check_permissions_for_repo_in_org(org, team_slug, owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, team_slug: team_slug, owner: owner, repo: repo],
      call: {GitHub.Teams, :check_permissions_for_repo_in_org},
      url: "/orgs/#{org}/teams/#{team_slug}/repos/#{owner}/#{repo}",
      method: :get,
      response: [{200, {GitHub.Team.Repository, :t}}, {204, nil}, {404, nil}],
      opts: opts
    })
  end

  @doc """
  Check team permissions for a repository (Legacy)

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams/#check-team-permissions-for-a-repository-legacy)

  """
  @spec check_permissions_for_repo_legacy(integer, String.t(), String.t(), keyword) ::
          {:ok, GitHub.Team.Repository.t()} | {:error, GitHub.Error.t()}
  def check_permissions_for_repo_legacy(team_id, owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [team_id: team_id, owner: owner, repo: repo],
      call: {GitHub.Teams, :check_permissions_for_repo_legacy},
      url: "/teams/#{team_id}/repos/#{owner}/#{repo}",
      method: :get,
      response: [{200, {GitHub.Team.Repository, :t}}, {204, nil}, {404, nil}],
      opts: opts
    })
  end

  @doc """
  Create a team

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams#create-a-team)

  """
  @spec create(String.t(), map, keyword) ::
          {:ok, GitHub.Team.Full.t()} | {:error, GitHub.Error.t()}
  def create(org, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org],
      call: {GitHub.Teams, :create},
      url: "/orgs/#{org}/teams",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {201, {GitHub.Team.Full, :t}},
        {403, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Create a discussion comment

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams#create-a-discussion-comment)

  """
  @spec create_discussion_comment_in_org(String.t(), String.t(), integer, map, keyword) ::
          {:ok, GitHub.Team.DiscussionComment.t()} | {:error, GitHub.Error.t()}
  def create_discussion_comment_in_org(org, team_slug, discussion_number, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, team_slug: team_slug, discussion_number: discussion_number],
      call: {GitHub.Teams, :create_discussion_comment_in_org},
      url: "/orgs/#{org}/teams/#{team_slug}/discussions/#{discussion_number}/comments",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{201, {GitHub.Team.DiscussionComment, :t}}],
      opts: opts
    })
  end

  @doc """
  Create a discussion comment (Legacy)

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams#create-a-discussion-comment-legacy)

  """
  @spec create_discussion_comment_legacy(integer, integer, map, keyword) ::
          {:ok, GitHub.Team.DiscussionComment.t()} | {:error, GitHub.Error.t()}
  def create_discussion_comment_legacy(team_id, discussion_number, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [team_id: team_id, discussion_number: discussion_number],
      call: {GitHub.Teams, :create_discussion_comment_legacy},
      url: "/teams/#{team_id}/discussions/#{discussion_number}/comments",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{201, {GitHub.Team.DiscussionComment, :t}}],
      opts: opts
    })
  end

  @doc """
  Create a discussion

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams#create-a-discussion)

  """
  @spec create_discussion_in_org(String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.Team.Discussion.t()} | {:error, GitHub.Error.t()}
  def create_discussion_in_org(org, team_slug, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, team_slug: team_slug],
      call: {GitHub.Teams, :create_discussion_in_org},
      url: "/orgs/#{org}/teams/#{team_slug}/discussions",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{201, {GitHub.Team.Discussion, :t}}],
      opts: opts
    })
  end

  @doc """
  Create a discussion (Legacy)

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams#create-a-discussion-legacy)

  """
  @spec create_discussion_legacy(integer, map, keyword) ::
          {:ok, GitHub.Team.Discussion.t()} | {:error, GitHub.Error.t()}
  def create_discussion_legacy(team_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [team_id: team_id],
      call: {GitHub.Teams, :create_discussion_legacy},
      url: "/teams/#{team_id}/discussions",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{201, {GitHub.Team.Discussion, :t}}],
      opts: opts
    })
  end

  @doc """
  Delete a discussion comment

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams#delete-a-discussion-comment)

  """
  @spec delete_discussion_comment_in_org(String.t(), String.t(), integer, integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def delete_discussion_comment_in_org(
        org,
        team_slug,
        discussion_number,
        comment_number,
        opts \\ []
      ) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [
        org: org,
        team_slug: team_slug,
        discussion_number: discussion_number,
        comment_number: comment_number
      ],
      call: {GitHub.Teams, :delete_discussion_comment_in_org},
      url:
        "/orgs/#{org}/teams/#{team_slug}/discussions/#{discussion_number}/comments/#{comment_number}",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Delete a discussion comment (Legacy)

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams#delete-a-discussion-comment-legacy)

  """
  @spec delete_discussion_comment_legacy(integer, integer, integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def delete_discussion_comment_legacy(team_id, discussion_number, comment_number, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [
        team_id: team_id,
        discussion_number: discussion_number,
        comment_number: comment_number
      ],
      call: {GitHub.Teams, :delete_discussion_comment_legacy},
      url: "/teams/#{team_id}/discussions/#{discussion_number}/comments/#{comment_number}",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Delete a discussion

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams#delete-a-discussion)

  """
  @spec delete_discussion_in_org(String.t(), String.t(), integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def delete_discussion_in_org(org, team_slug, discussion_number, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, team_slug: team_slug, discussion_number: discussion_number],
      call: {GitHub.Teams, :delete_discussion_in_org},
      url: "/orgs/#{org}/teams/#{team_slug}/discussions/#{discussion_number}",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Delete a discussion (Legacy)

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams#delete-a-discussion-legacy)

  """
  @spec delete_discussion_legacy(integer, integer, keyword) :: :ok | {:error, GitHub.Error.t()}
  def delete_discussion_legacy(team_id, discussion_number, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [team_id: team_id, discussion_number: discussion_number],
      call: {GitHub.Teams, :delete_discussion_legacy},
      url: "/teams/#{team_id}/discussions/#{discussion_number}",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Delete a team

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams#delete-a-team)

  """
  @spec delete_in_org(String.t(), String.t(), keyword) :: :ok | {:error, GitHub.Error.t()}
  def delete_in_org(org, team_slug, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, team_slug: team_slug],
      call: {GitHub.Teams, :delete_in_org},
      url: "/orgs/#{org}/teams/#{team_slug}",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Delete a team (Legacy)

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams/#delete-a-team-legacy)

  """
  @spec delete_legacy(integer, keyword) :: :ok | {:error, GitHub.Error.t()}
  def delete_legacy(team_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [team_id: team_id],
      call: {GitHub.Teams, :delete_legacy},
      url: "/teams/#{team_id}",
      method: :delete,
      response: [{204, nil}, {404, {GitHub.BasicError, :t}}, {422, {GitHub.ValidationError, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a team by name

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams#get-a-team-by-name)

  """
  @spec get_by_name(String.t(), String.t(), keyword) ::
          {:ok, GitHub.Team.Full.t()} | {:error, GitHub.Error.t()}
  def get_by_name(org, team_slug, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, team_slug: team_slug],
      call: {GitHub.Teams, :get_by_name},
      url: "/orgs/#{org}/teams/#{team_slug}",
      method: :get,
      response: [{200, {GitHub.Team.Full, :t}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a discussion comment

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams#get-a-discussion-comment)

  """
  @spec get_discussion_comment_in_org(String.t(), String.t(), integer, integer, keyword) ::
          {:ok, GitHub.Team.DiscussionComment.t()} | {:error, GitHub.Error.t()}
  def get_discussion_comment_in_org(org, team_slug, discussion_number, comment_number, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [
        org: org,
        team_slug: team_slug,
        discussion_number: discussion_number,
        comment_number: comment_number
      ],
      call: {GitHub.Teams, :get_discussion_comment_in_org},
      url:
        "/orgs/#{org}/teams/#{team_slug}/discussions/#{discussion_number}/comments/#{comment_number}",
      method: :get,
      response: [{200, {GitHub.Team.DiscussionComment, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a discussion comment (Legacy)

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams#get-a-discussion-comment-legacy)

  """
  @spec get_discussion_comment_legacy(integer, integer, integer, keyword) ::
          {:ok, GitHub.Team.DiscussionComment.t()} | {:error, GitHub.Error.t()}
  def get_discussion_comment_legacy(team_id, discussion_number, comment_number, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [
        team_id: team_id,
        discussion_number: discussion_number,
        comment_number: comment_number
      ],
      call: {GitHub.Teams, :get_discussion_comment_legacy},
      url: "/teams/#{team_id}/discussions/#{discussion_number}/comments/#{comment_number}",
      method: :get,
      response: [{200, {GitHub.Team.DiscussionComment, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a discussion

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams#get-a-discussion)

  """
  @spec get_discussion_in_org(String.t(), String.t(), integer, keyword) ::
          {:ok, GitHub.Team.Discussion.t()} | {:error, GitHub.Error.t()}
  def get_discussion_in_org(org, team_slug, discussion_number, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, team_slug: team_slug, discussion_number: discussion_number],
      call: {GitHub.Teams, :get_discussion_in_org},
      url: "/orgs/#{org}/teams/#{team_slug}/discussions/#{discussion_number}",
      method: :get,
      response: [{200, {GitHub.Team.Discussion, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a discussion (Legacy)

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams#get-a-discussion-legacy)

  """
  @spec get_discussion_legacy(integer, integer, keyword) ::
          {:ok, GitHub.Team.Discussion.t()} | {:error, GitHub.Error.t()}
  def get_discussion_legacy(team_id, discussion_number, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [team_id: team_id, discussion_number: discussion_number],
      call: {GitHub.Teams, :get_discussion_legacy},
      url: "/teams/#{team_id}/discussions/#{discussion_number}",
      method: :get,
      response: [{200, {GitHub.Team.Discussion, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a team (Legacy)

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams/#get-a-team-legacy)

  """
  @spec get_legacy(integer, keyword) :: {:ok, GitHub.Team.Full.t()} | {:error, GitHub.Error.t()}
  def get_legacy(team_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [team_id: team_id],
      call: {GitHub.Teams, :get_legacy},
      url: "/teams/#{team_id}",
      method: :get,
      response: [{200, {GitHub.Team.Full, :t}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Get team member (Legacy)

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams#get-team-member-legacy)

  """
  @spec get_member_legacy(integer, String.t(), keyword) :: :ok | {:error, GitHub.Error.t()}
  def get_member_legacy(team_id, username, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [team_id: team_id, username: username],
      call: {GitHub.Teams, :get_member_legacy},
      url: "/teams/#{team_id}/members/#{username}",
      method: :get,
      response: [{204, nil}, {404, nil}],
      opts: opts
    })
  end

  @doc """
  Get team membership for a user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams#get-team-membership-for-a-user)

  """
  @spec get_membership_for_user_in_org(String.t(), String.t(), String.t(), keyword) ::
          {:ok, GitHub.Team.Membership.t()} | {:error, GitHub.Error.t()}
  def get_membership_for_user_in_org(org, team_slug, username, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, team_slug: team_slug, username: username],
      call: {GitHub.Teams, :get_membership_for_user_in_org},
      url: "/orgs/#{org}/teams/#{team_slug}/memberships/#{username}",
      method: :get,
      response: [{200, {GitHub.Team.Membership, :t}}, {404, nil}],
      opts: opts
    })
  end

  @doc """
  Get team membership for a user (Legacy)

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams#get-team-membership-for-a-user-legacy)

  """
  @spec get_membership_for_user_legacy(integer, String.t(), keyword) ::
          {:ok, GitHub.Team.Membership.t()} | {:error, GitHub.Error.t()}
  def get_membership_for_user_legacy(team_id, username, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [team_id: team_id, username: username],
      call: {GitHub.Teams, :get_membership_for_user_legacy},
      url: "/teams/#{team_id}/memberships/#{username}",
      method: :get,
      response: [{200, {GitHub.Team.Membership, :t}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  List teams

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams#list-teams)

  """
  @spec list(String.t(), keyword) :: {:ok, [GitHub.Team.t()]} | {:error, GitHub.Error.t()}
  def list(org, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [org: org],
      call: {GitHub.Teams, :list},
      url: "/orgs/#{org}/teams",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.Team, :t}}}, {403, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  List child teams

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams#list-child-teams)

  """
  @spec list_child_in_org(String.t(), String.t(), keyword) ::
          {:ok, [GitHub.Team.t()]} | {:error, GitHub.Error.t()}
  def list_child_in_org(org, team_slug, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [org: org, team_slug: team_slug],
      call: {GitHub.Teams, :list_child_in_org},
      url: "/orgs/#{org}/teams/#{team_slug}/teams",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.Team, :t}}}],
      opts: opts
    })
  end

  @doc """
  List child teams (Legacy)

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams/#list-child-teams-legacy)

  """
  @spec list_child_legacy(integer, keyword) ::
          {:ok, [GitHub.Team.t()]} | {:error, GitHub.Error.t()}
  def list_child_legacy(team_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [team_id: team_id],
      call: {GitHub.Teams, :list_child_legacy},
      url: "/teams/#{team_id}/teams",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.Team, :t}}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List discussion comments

  ## Options

    * `direction` (String.t()): The direction to sort the results by.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams#list-discussion-comments)

  """
  @spec list_discussion_comments_in_org(String.t(), String.t(), integer, keyword) ::
          {:ok, [GitHub.Team.DiscussionComment.t()]} | {:error, GitHub.Error.t()}
  def list_discussion_comments_in_org(org, team_slug, discussion_number, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:direction, :page, :per_page])

    client.request(%{
      args: [org: org, team_slug: team_slug, discussion_number: discussion_number],
      call: {GitHub.Teams, :list_discussion_comments_in_org},
      url: "/orgs/#{org}/teams/#{team_slug}/discussions/#{discussion_number}/comments",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.Team.DiscussionComment, :t}}}],
      opts: opts
    })
  end

  @doc """
  List discussion comments (Legacy)

  ## Options

    * `direction` (String.t()): The direction to sort the results by.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams#list-discussion-comments-legacy)

  """
  @spec list_discussion_comments_legacy(integer, integer, keyword) ::
          {:ok, [GitHub.Team.DiscussionComment.t()]} | {:error, GitHub.Error.t()}
  def list_discussion_comments_legacy(team_id, discussion_number, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:direction, :page, :per_page])

    client.request(%{
      args: [team_id: team_id, discussion_number: discussion_number],
      call: {GitHub.Teams, :list_discussion_comments_legacy},
      url: "/teams/#{team_id}/discussions/#{discussion_number}/comments",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.Team.DiscussionComment, :t}}}],
      opts: opts
    })
  end

  @doc """
  List discussions

  ## Options

    * `direction` (String.t()): The direction to sort the results by.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.
    * `pinned` (String.t()): Pinned discussions only filter

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams#list-discussions)

  """
  @spec list_discussions_in_org(String.t(), String.t(), keyword) ::
          {:ok, [GitHub.Team.Discussion.t()]} | {:error, GitHub.Error.t()}
  def list_discussions_in_org(org, team_slug, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:direction, :page, :per_page, :pinned])

    client.request(%{
      args: [org: org, team_slug: team_slug],
      call: {GitHub.Teams, :list_discussions_in_org},
      url: "/orgs/#{org}/teams/#{team_slug}/discussions",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.Team.Discussion, :t}}}],
      opts: opts
    })
  end

  @doc """
  List discussions (Legacy)

  ## Options

    * `direction` (String.t()): The direction to sort the results by.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams#list-discussions-legacy)

  """
  @spec list_discussions_legacy(integer, keyword) ::
          {:ok, [GitHub.Team.Discussion.t()]} | {:error, GitHub.Error.t()}
  def list_discussions_legacy(team_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:direction, :page, :per_page])

    client.request(%{
      args: [team_id: team_id],
      call: {GitHub.Teams, :list_discussions_legacy},
      url: "/teams/#{team_id}/discussions",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.Team.Discussion, :t}}}],
      opts: opts
    })
  end

  @doc """
  List teams for the authenticated user

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams#list-teams-for-the-authenticated-user)

  """
  @spec list_for_authenticated_user(keyword) ::
          {:ok, [GitHub.Team.Full.t()]} | {:error, GitHub.Error.t()}
  def list_for_authenticated_user(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      call: {GitHub.Teams, :list_for_authenticated_user},
      url: "/user/teams",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.Team.Full, :t}}},
        {304, nil},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List team members

  ## Options

    * `role` (String.t()): Filters members returned by their role in the team.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams#list-team-members)

  """
  @spec list_members_in_org(String.t(), String.t(), keyword) ::
          {:ok, [GitHub.User.simple()]} | {:error, GitHub.Error.t()}
  def list_members_in_org(org, team_slug, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page, :role])

    client.request(%{
      args: [org: org, team_slug: team_slug],
      call: {GitHub.Teams, :list_members_in_org},
      url: "/orgs/#{org}/teams/#{team_slug}/members",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.User, :simple}}}],
      opts: opts
    })
  end

  @doc """
  List team members (Legacy)

  ## Options

    * `role` (String.t()): Filters members returned by their role in the team.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams#list-team-members-legacy)

  """
  @spec list_members_legacy(integer, keyword) ::
          {:ok, [GitHub.User.simple()]} | {:error, GitHub.Error.t()}
  def list_members_legacy(team_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page, :role])

    client.request(%{
      args: [team_id: team_id],
      call: {GitHub.Teams, :list_members_legacy},
      url: "/teams/#{team_id}/members",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.User, :simple}}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  List pending team invitations

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams#list-pending-team-invitations)

  """
  @spec list_pending_invitations_in_org(String.t(), String.t(), keyword) ::
          {:ok, [GitHub.Organization.Invitation.t()]} | {:error, GitHub.Error.t()}
  def list_pending_invitations_in_org(org, team_slug, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [org: org, team_slug: team_slug],
      call: {GitHub.Teams, :list_pending_invitations_in_org},
      url: "/orgs/#{org}/teams/#{team_slug}/invitations",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.Organization.Invitation, :t}}}],
      opts: opts
    })
  end

  @doc """
  List pending team invitations (Legacy)

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams#list-pending-team-invitations-legacy)

  """
  @spec list_pending_invitations_legacy(integer, keyword) ::
          {:ok, [GitHub.Organization.Invitation.t()]} | {:error, GitHub.Error.t()}
  def list_pending_invitations_legacy(team_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [team_id: team_id],
      call: {GitHub.Teams, :list_pending_invitations_legacy},
      url: "/teams/#{team_id}/invitations",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.Organization.Invitation, :t}}}],
      opts: opts
    })
  end

  @doc """
  List team projects

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams#list-team-projects)

  """
  @spec list_projects_in_org(String.t(), String.t(), keyword) ::
          {:ok, [GitHub.Team.Project.t()]} | {:error, GitHub.Error.t()}
  def list_projects_in_org(org, team_slug, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [org: org, team_slug: team_slug],
      call: {GitHub.Teams, :list_projects_in_org},
      url: "/orgs/#{org}/teams/#{team_slug}/projects",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.Team.Project, :t}}}],
      opts: opts
    })
  end

  @doc """
  List team projects (Legacy)

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams/#list-team-projects-legacy)

  """
  @spec list_projects_legacy(integer, keyword) ::
          {:ok, [GitHub.Team.Project.t()]} | {:error, GitHub.Error.t()}
  def list_projects_legacy(team_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [team_id: team_id],
      call: {GitHub.Teams, :list_projects_legacy},
      url: "/teams/#{team_id}/projects",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.Team.Project, :t}}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  List team repositories

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams#list-team-repositories)

  """
  @spec list_repos_in_org(String.t(), String.t(), keyword) ::
          {:ok, [GitHub.MinimalRepository.t()]} | {:error, GitHub.Error.t()}
  def list_repos_in_org(org, team_slug, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [org: org, team_slug: team_slug],
      call: {GitHub.Teams, :list_repos_in_org},
      url: "/orgs/#{org}/teams/#{team_slug}/repos",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.MinimalRepository, :t}}}],
      opts: opts
    })
  end

  @doc """
  List team repositories (Legacy)

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams/#list-team-repositories-legacy)

  """
  @spec list_repos_legacy(integer, keyword) ::
          {:ok, [GitHub.MinimalRepository.t()]} | {:error, GitHub.Error.t()}
  def list_repos_legacy(team_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [team_id: team_id],
      call: {GitHub.Teams, :list_repos_legacy},
      url: "/teams/#{team_id}/repos",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.MinimalRepository, :t}}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Remove team member (Legacy)

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams#remove-team-member-legacy)

  """
  @spec remove_member_legacy(integer, String.t(), keyword) :: :ok | {:error, GitHub.Error.t()}
  def remove_member_legacy(team_id, username, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [team_id: team_id, username: username],
      call: {GitHub.Teams, :remove_member_legacy},
      url: "/teams/#{team_id}/members/#{username}",
      method: :delete,
      response: [{204, nil}, {404, nil}],
      opts: opts
    })
  end

  @doc """
  Remove team membership for a user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams#remove-team-membership-for-a-user)

  """
  @spec remove_membership_for_user_in_org(String.t(), String.t(), String.t(), keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def remove_membership_for_user_in_org(org, team_slug, username, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, team_slug: team_slug, username: username],
      call: {GitHub.Teams, :remove_membership_for_user_in_org},
      url: "/orgs/#{org}/teams/#{team_slug}/memberships/#{username}",
      method: :delete,
      response: [{204, nil}, {403, nil}],
      opts: opts
    })
  end

  @doc """
  Remove team membership for a user (Legacy)

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams#remove-team-membership-for-a-user-legacy)

  """
  @spec remove_membership_for_user_legacy(integer, String.t(), keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def remove_membership_for_user_legacy(team_id, username, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [team_id: team_id, username: username],
      call: {GitHub.Teams, :remove_membership_for_user_legacy},
      url: "/teams/#{team_id}/memberships/#{username}",
      method: :delete,
      response: [{204, nil}, {403, nil}],
      opts: opts
    })
  end

  @doc """
  Remove a project from a team

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams#remove-a-project-from-a-team)

  """
  @spec remove_project_in_org(String.t(), String.t(), integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def remove_project_in_org(org, team_slug, project_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, team_slug: team_slug, project_id: project_id],
      call: {GitHub.Teams, :remove_project_in_org},
      url: "/orgs/#{org}/teams/#{team_slug}/projects/#{project_id}",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Remove a project from a team (Legacy)

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams/#remove-a-project-from-a-team-legacy)

  """
  @spec remove_project_legacy(integer, integer, keyword) :: :ok | {:error, GitHub.Error.t()}
  def remove_project_legacy(team_id, project_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [team_id: team_id, project_id: project_id],
      call: {GitHub.Teams, :remove_project_legacy},
      url: "/teams/#{team_id}/projects/#{project_id}",
      method: :delete,
      response: [{204, nil}, {404, {GitHub.BasicError, :t}}, {422, {GitHub.ValidationError, :t}}],
      opts: opts
    })
  end

  @doc """
  Remove a repository from a team

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams/#remove-a-repository-from-a-team)

  """
  @spec remove_repo_in_org(String.t(), String.t(), String.t(), String.t(), keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def remove_repo_in_org(org, team_slug, owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, team_slug: team_slug, owner: owner, repo: repo],
      call: {GitHub.Teams, :remove_repo_in_org},
      url: "/orgs/#{org}/teams/#{team_slug}/repos/#{owner}/#{repo}",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Remove a repository from a team (Legacy)

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams/#remove-a-repository-from-a-team-legacy)

  """
  @spec remove_repo_legacy(integer, String.t(), String.t(), keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def remove_repo_legacy(team_id, owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [team_id: team_id, owner: owner, repo: repo],
      call: {GitHub.Teams, :remove_repo_legacy},
      url: "/teams/#{team_id}/repos/#{owner}/#{repo}",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Update a discussion comment

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams#update-a-discussion-comment)

  """
  @spec update_discussion_comment_in_org(String.t(), String.t(), integer, integer, map, keyword) ::
          {:ok, GitHub.Team.DiscussionComment.t()} | {:error, GitHub.Error.t()}
  def update_discussion_comment_in_org(
        org,
        team_slug,
        discussion_number,
        comment_number,
        body,
        opts \\ []
      ) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [
        org: org,
        team_slug: team_slug,
        discussion_number: discussion_number,
        comment_number: comment_number
      ],
      call: {GitHub.Teams, :update_discussion_comment_in_org},
      url:
        "/orgs/#{org}/teams/#{team_slug}/discussions/#{discussion_number}/comments/#{comment_number}",
      body: body,
      method: :patch,
      request: [{"application/json", :map}],
      response: [{200, {GitHub.Team.DiscussionComment, :t}}],
      opts: opts
    })
  end

  @doc """
  Update a discussion comment (Legacy)

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams#update-a-discussion-comment-legacy)

  """
  @spec update_discussion_comment_legacy(integer, integer, integer, map, keyword) ::
          {:ok, GitHub.Team.DiscussionComment.t()} | {:error, GitHub.Error.t()}
  def update_discussion_comment_legacy(
        team_id,
        discussion_number,
        comment_number,
        body,
        opts \\ []
      ) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [
        team_id: team_id,
        discussion_number: discussion_number,
        comment_number: comment_number
      ],
      call: {GitHub.Teams, :update_discussion_comment_legacy},
      url: "/teams/#{team_id}/discussions/#{discussion_number}/comments/#{comment_number}",
      body: body,
      method: :patch,
      request: [{"application/json", :map}],
      response: [{200, {GitHub.Team.DiscussionComment, :t}}],
      opts: opts
    })
  end

  @doc """
  Update a discussion

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams#update-a-discussion)

  """
  @spec update_discussion_in_org(String.t(), String.t(), integer, map, keyword) ::
          {:ok, GitHub.Team.Discussion.t()} | {:error, GitHub.Error.t()}
  def update_discussion_in_org(org, team_slug, discussion_number, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, team_slug: team_slug, discussion_number: discussion_number],
      call: {GitHub.Teams, :update_discussion_in_org},
      url: "/orgs/#{org}/teams/#{team_slug}/discussions/#{discussion_number}",
      body: body,
      method: :patch,
      request: [{"application/json", :map}],
      response: [{200, {GitHub.Team.Discussion, :t}}],
      opts: opts
    })
  end

  @doc """
  Update a discussion (Legacy)

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams#update-a-discussion-legacy)

  """
  @spec update_discussion_legacy(integer, integer, map, keyword) ::
          {:ok, GitHub.Team.Discussion.t()} | {:error, GitHub.Error.t()}
  def update_discussion_legacy(team_id, discussion_number, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [team_id: team_id, discussion_number: discussion_number],
      call: {GitHub.Teams, :update_discussion_legacy},
      url: "/teams/#{team_id}/discussions/#{discussion_number}",
      body: body,
      method: :patch,
      request: [{"application/json", :map}],
      response: [{200, {GitHub.Team.Discussion, :t}}],
      opts: opts
    })
  end

  @doc """
  Update a team

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams#update-a-team)

  """
  @spec update_in_org(String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.Team.Full.t()} | {:error, GitHub.Error.t()}
  def update_in_org(org, team_slug, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, team_slug: team_slug],
      call: {GitHub.Teams, :update_in_org},
      url: "/orgs/#{org}/teams/#{team_slug}",
      body: body,
      method: :patch,
      request: [{"application/json", :map}],
      response: [
        {200, {GitHub.Team.Full, :t}},
        {201, {GitHub.Team.Full, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Update a team (Legacy)

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/teams/#update-a-team-legacy)

  """
  @spec update_legacy(integer, map, keyword) ::
          {:ok, GitHub.Team.Full.t()} | {:error, GitHub.Error.t()}
  def update_legacy(team_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [team_id: team_id],
      call: {GitHub.Teams, :update_legacy},
      url: "/teams/#{team_id}",
      body: body,
      method: :patch,
      request: [{"application/json", :map}],
      response: [
        {200, {GitHub.Team.Full, :t}},
        {201, {GitHub.Team.Full, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end
end
