defmodule GitHub.Reactions do
  @moduledoc """
  Provides API endpoints related to reactions
  """

  @default_client GitHub.Client

  @doc """
  Create reaction for a commit comment

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/reactions#create-reaction-for-a-commit-comment)

  """
  @spec create_for_commit_comment(String.t(), String.t(), integer, map, keyword) ::
          {:ok, GitHub.Reaction.t()} | {:error, GitHub.Error.t()}
  def create_for_commit_comment(owner, repo, comment_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, comment_id: comment_id],
      url: "/repos/#{owner}/#{repo}/comments/#{comment_id}/reactions",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {200, {GitHub.Reaction, :t}},
        {201, {GitHub.Reaction, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Create reaction for an issue

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/reactions#create-reaction-for-an-issue)

  """
  @spec create_for_issue(String.t(), String.t(), integer, map, keyword) ::
          {:ok, GitHub.Reaction.t()} | {:error, GitHub.Error.t()}
  def create_for_issue(owner, repo, issue_number, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, issue_number: issue_number],
      url: "/repos/#{owner}/#{repo}/issues/#{issue_number}/reactions",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {200, {GitHub.Reaction, :t}},
        {201, {GitHub.Reaction, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Create reaction for an issue comment

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/reactions#create-reaction-for-an-issue-comment)

  """
  @spec create_for_issue_comment(String.t(), String.t(), integer, map, keyword) ::
          {:ok, GitHub.Reaction.t()} | {:error, GitHub.Error.t()}
  def create_for_issue_comment(owner, repo, comment_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, comment_id: comment_id],
      url: "/repos/#{owner}/#{repo}/issues/comments/#{comment_id}/reactions",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {200, {GitHub.Reaction, :t}},
        {201, {GitHub.Reaction, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Create reaction for a pull request review comment

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/reactions#create-reaction-for-a-pull-request-review-comment)

  """
  @spec create_for_pull_request_review_comment(String.t(), String.t(), integer, map, keyword) ::
          {:ok, GitHub.Reaction.t()} | {:error, GitHub.Error.t()}
  def create_for_pull_request_review_comment(owner, repo, comment_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, comment_id: comment_id],
      url: "/repos/#{owner}/#{repo}/pulls/comments/#{comment_id}/reactions",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {200, {GitHub.Reaction, :t}},
        {201, {GitHub.Reaction, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Create reaction for a release

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/reactions/#create-reaction-for-a-release)

  """
  @spec create_for_release(String.t(), String.t(), integer, map, keyword) ::
          {:ok, GitHub.Reaction.t()} | {:error, GitHub.Error.t()}
  def create_for_release(owner, repo, release_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, release_id: release_id],
      url: "/repos/#{owner}/#{repo}/releases/#{release_id}/reactions",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {200, {GitHub.Reaction, :t}},
        {201, {GitHub.Reaction, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Create reaction for a team discussion comment

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/reactions#create-reaction-for-a-team-discussion-comment)

  """
  @spec create_for_team_discussion_comment_in_org(
          String.t(),
          String.t(),
          integer,
          integer,
          map,
          keyword
        ) :: {:ok, GitHub.Reaction.t()} | {:error, GitHub.Error.t()}
  def create_for_team_discussion_comment_in_org(
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
      url:
        "/orgs/#{org}/teams/#{team_slug}/discussions/#{discussion_number}/comments/#{comment_number}/reactions",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, {GitHub.Reaction, :t}}, {201, {GitHub.Reaction, :t}}],
      opts: opts
    })
  end

  @doc """
  Create reaction for a team discussion comment (Legacy)

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/reactions/#create-reaction-for-a-team-discussion-comment-legacy)

  """
  @spec create_for_team_discussion_comment_legacy(integer, integer, integer, map, keyword) ::
          {:ok, GitHub.Reaction.t()} | {:error, GitHub.Error.t()}
  def create_for_team_discussion_comment_legacy(
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
      url:
        "/teams/#{team_id}/discussions/#{discussion_number}/comments/#{comment_number}/reactions",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{201, {GitHub.Reaction, :t}}],
      opts: opts
    })
  end

  @doc """
  Create reaction for a team discussion

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/reactions#create-reaction-for-a-team-discussion)

  """
  @spec create_for_team_discussion_in_org(String.t(), String.t(), integer, map, keyword) ::
          {:ok, GitHub.Reaction.t()} | {:error, GitHub.Error.t()}
  def create_for_team_discussion_in_org(org, team_slug, discussion_number, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org, team_slug: team_slug, discussion_number: discussion_number],
      url: "/orgs/#{org}/teams/#{team_slug}/discussions/#{discussion_number}/reactions",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{200, {GitHub.Reaction, :t}}, {201, {GitHub.Reaction, :t}}],
      opts: opts
    })
  end

  @doc """
  Create reaction for a team discussion (Legacy)

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/reactions/#create-reaction-for-a-team-discussion-legacy)

  """
  @spec create_for_team_discussion_legacy(integer, integer, map, keyword) ::
          {:ok, GitHub.Reaction.t()} | {:error, GitHub.Error.t()}
  def create_for_team_discussion_legacy(team_id, discussion_number, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [team_id: team_id, discussion_number: discussion_number],
      url: "/teams/#{team_id}/discussions/#{discussion_number}/reactions",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{201, {GitHub.Reaction, :t}}],
      opts: opts
    })
  end

  @doc """
  Delete a commit comment reaction

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/reactions#delete-a-commit-comment-reaction)

  """
  @spec delete_for_commit_comment(String.t(), String.t(), integer, integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def delete_for_commit_comment(owner, repo, comment_id, reaction_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, comment_id: comment_id, reaction_id: reaction_id],
      url: "/repos/#{owner}/#{repo}/comments/#{comment_id}/reactions/#{reaction_id}",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Delete an issue reaction

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/reactions#delete-an-issue-reaction)

  """
  @spec delete_for_issue(String.t(), String.t(), integer, integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def delete_for_issue(owner, repo, issue_number, reaction_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, issue_number: issue_number, reaction_id: reaction_id],
      url: "/repos/#{owner}/#{repo}/issues/#{issue_number}/reactions/#{reaction_id}",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Delete an issue comment reaction

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/reactions#delete-an-issue-comment-reaction)

  """
  @spec delete_for_issue_comment(String.t(), String.t(), integer, integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def delete_for_issue_comment(owner, repo, comment_id, reaction_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, comment_id: comment_id, reaction_id: reaction_id],
      url: "/repos/#{owner}/#{repo}/issues/comments/#{comment_id}/reactions/#{reaction_id}",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Delete a pull request comment reaction

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/reactions#delete-a-pull-request-comment-reaction)

  """
  @spec delete_for_pull_request_comment(String.t(), String.t(), integer, integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def delete_for_pull_request_comment(owner, repo, comment_id, reaction_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, comment_id: comment_id, reaction_id: reaction_id],
      url: "/repos/#{owner}/#{repo}/pulls/comments/#{comment_id}/reactions/#{reaction_id}",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Delete a release reaction

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/reactions/#delete-a-release-reaction)

  """
  @spec delete_for_release(String.t(), String.t(), integer, integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def delete_for_release(owner, repo, release_id, reaction_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, release_id: release_id, reaction_id: reaction_id],
      url: "/repos/#{owner}/#{repo}/releases/#{release_id}/reactions/#{reaction_id}",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Delete team discussion reaction

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/reactions#delete-team-discussion-reaction)

  """
  @spec delete_for_team_discussion(String.t(), String.t(), integer, integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def delete_for_team_discussion(org, team_slug, discussion_number, reaction_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [
        org: org,
        team_slug: team_slug,
        discussion_number: discussion_number,
        reaction_id: reaction_id
      ],
      url:
        "/orgs/#{org}/teams/#{team_slug}/discussions/#{discussion_number}/reactions/#{reaction_id}",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Delete team discussion comment reaction

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/reactions#delete-team-discussion-comment-reaction)

  """
  @spec delete_for_team_discussion_comment(
          String.t(),
          String.t(),
          integer,
          integer,
          integer,
          keyword
        ) :: :ok | {:error, GitHub.Error.t()}
  def delete_for_team_discussion_comment(
        org,
        team_slug,
        discussion_number,
        comment_number,
        reaction_id,
        opts \\ []
      ) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [
        org: org,
        team_slug: team_slug,
        discussion_number: discussion_number,
        comment_number: comment_number,
        reaction_id: reaction_id
      ],
      url:
        "/orgs/#{org}/teams/#{team_slug}/discussions/#{discussion_number}/comments/#{comment_number}/reactions/#{reaction_id}",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  List reactions for a commit comment

  ## Options

    * `content` (String.t()): Returns a single [reaction type](https://docs.github.com/rest/reference/reactions#reaction-types). Omit this parameter to list all reactions to a commit comment.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/reactions#list-reactions-for-a-commit-comment)

  """
  @spec list_for_commit_comment(String.t(), String.t(), integer, keyword) ::
          {:ok, [GitHub.Reaction.t()]} | {:error, GitHub.Error.t()}
  def list_for_commit_comment(owner, repo, comment_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:content, :page, :per_page])

    client.request(%{
      args: [owner: owner, repo: repo, comment_id: comment_id],
      url: "/repos/#{owner}/#{repo}/comments/#{comment_id}/reactions",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.Reaction, :t}}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  List reactions for an issue

  ## Options

    * `content` (String.t()): Returns a single [reaction type](https://docs.github.com/rest/reference/reactions#reaction-types). Omit this parameter to list all reactions to an issue.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/reactions#list-reactions-for-an-issue)

  """
  @spec list_for_issue(String.t(), String.t(), integer, keyword) ::
          {:ok, [GitHub.Reaction.t()]} | {:error, GitHub.Error.t()}
  def list_for_issue(owner, repo, issue_number, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:content, :page, :per_page])

    client.request(%{
      args: [owner: owner, repo: repo, issue_number: issue_number],
      url: "/repos/#{owner}/#{repo}/issues/#{issue_number}/reactions",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.Reaction, :t}}},
        {404, {GitHub.BasicError, :t}},
        {410, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List reactions for an issue comment

  ## Options

    * `content` (String.t()): Returns a single [reaction type](https://docs.github.com/rest/reference/reactions#reaction-types). Omit this parameter to list all reactions to an issue comment.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/reactions#list-reactions-for-an-issue-comment)

  """
  @spec list_for_issue_comment(String.t(), String.t(), integer, keyword) ::
          {:ok, [GitHub.Reaction.t()]} | {:error, GitHub.Error.t()}
  def list_for_issue_comment(owner, repo, comment_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:content, :page, :per_page])

    client.request(%{
      args: [owner: owner, repo: repo, comment_id: comment_id],
      url: "/repos/#{owner}/#{repo}/issues/comments/#{comment_id}/reactions",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.Reaction, :t}}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  List reactions for a pull request review comment

  ## Options

    * `content` (String.t()): Returns a single [reaction type](https://docs.github.com/rest/reference/reactions#reaction-types). Omit this parameter to list all reactions to a pull request review comment.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/reactions#list-reactions-for-a-pull-request-review-comment)

  """
  @spec list_for_pull_request_review_comment(String.t(), String.t(), integer, keyword) ::
          {:ok, [GitHub.Reaction.t()]} | {:error, GitHub.Error.t()}
  def list_for_pull_request_review_comment(owner, repo, comment_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:content, :page, :per_page])

    client.request(%{
      args: [owner: owner, repo: repo, comment_id: comment_id],
      url: "/repos/#{owner}/#{repo}/pulls/comments/#{comment_id}/reactions",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.Reaction, :t}}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  List reactions for a release

  ## Options

    * `content` (String.t()): Returns a single [reaction type](https://docs.github.com/rest/reference/reactions#reaction-types). Omit this parameter to list all reactions to a release.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/reactions/#list-reactions-for-a-release)

  """
  @spec list_for_release(String.t(), String.t(), integer, keyword) ::
          {:ok, [GitHub.Reaction.t()]} | {:error, GitHub.Error.t()}
  def list_for_release(owner, repo, release_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:content, :page, :per_page])

    client.request(%{
      args: [owner: owner, repo: repo, release_id: release_id],
      url: "/repos/#{owner}/#{repo}/releases/#{release_id}/reactions",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.Reaction, :t}}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  List reactions for a team discussion comment

  ## Options

    * `content` (String.t()): Returns a single [reaction type](https://docs.github.com/rest/reference/reactions#reaction-types). Omit this parameter to list all reactions to a team discussion comment.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/reactions#list-reactions-for-a-team-discussion-comment)

  """
  @spec list_for_team_discussion_comment_in_org(String.t(), String.t(), integer, integer, keyword) ::
          {:ok, [GitHub.Reaction.t()]} | {:error, GitHub.Error.t()}
  def list_for_team_discussion_comment_in_org(
        org,
        team_slug,
        discussion_number,
        comment_number,
        opts \\ []
      ) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:content, :page, :per_page])

    client.request(%{
      args: [
        org: org,
        team_slug: team_slug,
        discussion_number: discussion_number,
        comment_number: comment_number
      ],
      url:
        "/orgs/#{org}/teams/#{team_slug}/discussions/#{discussion_number}/comments/#{comment_number}/reactions",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.Reaction, :t}}}],
      opts: opts
    })
  end

  @doc """
  List reactions for a team discussion comment (Legacy)

  ## Options

    * `content` (String.t()): Returns a single [reaction type](https://docs.github.com/rest/reference/reactions#reaction-types). Omit this parameter to list all reactions to a team discussion comment.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/reactions/#list-reactions-for-a-team-discussion-comment-legacy)

  """
  @spec list_for_team_discussion_comment_legacy(integer, integer, integer, keyword) ::
          {:ok, [GitHub.Reaction.t()]} | {:error, GitHub.Error.t()}
  def list_for_team_discussion_comment_legacy(
        team_id,
        discussion_number,
        comment_number,
        opts \\ []
      ) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:content, :page, :per_page])

    client.request(%{
      args: [
        team_id: team_id,
        discussion_number: discussion_number,
        comment_number: comment_number
      ],
      url:
        "/teams/#{team_id}/discussions/#{discussion_number}/comments/#{comment_number}/reactions",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.Reaction, :t}}}],
      opts: opts
    })
  end

  @doc """
  List reactions for a team discussion

  ## Options

    * `content` (String.t()): Returns a single [reaction type](https://docs.github.com/rest/reference/reactions#reaction-types). Omit this parameter to list all reactions to a team discussion.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/reactions#list-reactions-for-a-team-discussion)

  """
  @spec list_for_team_discussion_in_org(String.t(), String.t(), integer, keyword) ::
          {:ok, [GitHub.Reaction.t()]} | {:error, GitHub.Error.t()}
  def list_for_team_discussion_in_org(org, team_slug, discussion_number, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:content, :page, :per_page])

    client.request(%{
      args: [org: org, team_slug: team_slug, discussion_number: discussion_number],
      url: "/orgs/#{org}/teams/#{team_slug}/discussions/#{discussion_number}/reactions",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.Reaction, :t}}}],
      opts: opts
    })
  end

  @doc """
  List reactions for a team discussion (Legacy)

  ## Options

    * `content` (String.t()): Returns a single [reaction type](https://docs.github.com/rest/reference/reactions#reaction-types). Omit this parameter to list all reactions to a team discussion.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/reactions/#list-reactions-for-a-team-discussion-legacy)

  """
  @spec list_for_team_discussion_legacy(integer, integer, keyword) ::
          {:ok, [GitHub.Reaction.t()]} | {:error, GitHub.Error.t()}
  def list_for_team_discussion_legacy(team_id, discussion_number, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:content, :page, :per_page])

    client.request(%{
      args: [team_id: team_id, discussion_number: discussion_number],
      url: "/teams/#{team_id}/discussions/#{discussion_number}/reactions",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.Reaction, :t}}}],
      opts: opts
    })
  end
end
