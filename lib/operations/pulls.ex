defmodule GitHub.Pulls do
  @moduledoc """
  Provides API endpoints related to pulls
  """

  @default_client GitHub.Client

  @doc """
  Check if a pull request has been merged

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/pulls#check-if-a-pull-request-has-been-merged)

  """
  @spec check_if_merged(String.t(), String.t(), integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def check_if_merged(owner, repo, pull_number, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, pull_number: pull_number],
      call: {GitHub.Pulls, :check_if_merged},
      url: "/repos/#{owner}/#{repo}/pulls/#{pull_number}/merge",
      method: :get,
      response: [{204, nil}, {404, nil}],
      opts: opts
    })
  end

  @doc """
  Create a pull request

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/pulls#create-a-pull-request)

  """
  @spec create(String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.PullRequest.t()} | {:error, GitHub.Error.t()}
  def create(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Pulls, :create},
      url: "/repos/#{owner}/#{repo}/pulls",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {201, {GitHub.PullRequest, :t}},
        {403, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Create a reply for a review comment

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/pulls#create-a-reply-for-a-review-comment)

  """
  @spec create_reply_for_review_comment(String.t(), String.t(), integer, integer, map, keyword) ::
          {:ok, GitHub.PullRequest.ReviewComment.t()} | {:error, GitHub.Error.t()}
  def create_reply_for_review_comment(owner, repo, pull_number, comment_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, pull_number: pull_number, comment_id: comment_id],
      call: {GitHub.Pulls, :create_reply_for_review_comment},
      url: "/repos/#{owner}/#{repo}/pulls/#{pull_number}/comments/#{comment_id}/replies",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{201, {GitHub.PullRequest.ReviewComment, :t}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Create a review for a pull request

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/pulls#create-a-review-for-a-pull-request)

  """
  @spec create_review(String.t(), String.t(), integer, map, keyword) ::
          {:ok, GitHub.PullRequest.Review.t()} | {:error, GitHub.Error.t()}
  def create_review(owner, repo, pull_number, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, pull_number: pull_number],
      call: {GitHub.Pulls, :create_review},
      url: "/repos/#{owner}/#{repo}/pulls/#{pull_number}/reviews",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {200, {GitHub.PullRequest.Review, :t}},
        {403, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :simple}}
      ],
      opts: opts
    })
  end

  @doc """
  Create a review comment for a pull request

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/pulls#create-a-review-comment-for-a-pull-request)

  """
  @spec create_review_comment(String.t(), String.t(), integer, map, keyword) ::
          {:ok, GitHub.PullRequest.ReviewComment.t()} | {:error, GitHub.Error.t()}
  def create_review_comment(owner, repo, pull_number, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, pull_number: pull_number],
      call: {GitHub.Pulls, :create_review_comment},
      url: "/repos/#{owner}/#{repo}/pulls/#{pull_number}/comments",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {201, {GitHub.PullRequest.ReviewComment, :t}},
        {403, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Delete a pending review for a pull request

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/pulls#delete-a-pending-review-for-a-pull-request)

  """
  @spec delete_pending_review(String.t(), String.t(), integer, integer, keyword) ::
          {:ok, GitHub.PullRequest.Review.t()} | {:error, GitHub.Error.t()}
  def delete_pending_review(owner, repo, pull_number, review_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, pull_number: pull_number, review_id: review_id],
      call: {GitHub.Pulls, :delete_pending_review},
      url: "/repos/#{owner}/#{repo}/pulls/#{pull_number}/reviews/#{review_id}",
      method: :delete,
      response: [
        {200, {GitHub.PullRequest.Review, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :simple}}
      ],
      opts: opts
    })
  end

  @doc """
  Delete a review comment for a pull request

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/pulls#delete-a-review-comment-for-a-pull-request)

  """
  @spec delete_review_comment(String.t(), String.t(), integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def delete_review_comment(owner, repo, comment_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, comment_id: comment_id],
      call: {GitHub.Pulls, :delete_review_comment},
      url: "/repos/#{owner}/#{repo}/pulls/comments/#{comment_id}",
      method: :delete,
      response: [{204, nil}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Dismiss a review for a pull request

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/pulls#dismiss-a-review-for-a-pull-request)

  """
  @spec dismiss_review(String.t(), String.t(), integer, integer, map, keyword) ::
          {:ok, GitHub.PullRequest.Review.t()} | {:error, GitHub.Error.t()}
  def dismiss_review(owner, repo, pull_number, review_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, pull_number: pull_number, review_id: review_id],
      call: {GitHub.Pulls, :dismiss_review},
      url: "/repos/#{owner}/#{repo}/pulls/#{pull_number}/reviews/#{review_id}/dismissals",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [
        {200, {GitHub.PullRequest.Review, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :simple}}
      ],
      opts: opts
    })
  end

  @doc """
  Get a pull request

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/pulls#get-a-pull-request)

  """
  @spec get(String.t(), String.t(), integer, keyword) ::
          {:ok, GitHub.PullRequest.t()} | {:error, GitHub.Error.t()}
  def get(owner, repo, pull_number, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, pull_number: pull_number],
      call: {GitHub.Pulls, :get},
      url: "/repos/#{owner}/#{repo}/pulls/#{pull_number}",
      method: :get,
      response: [
        {200, {GitHub.PullRequest, :t}},
        {304, nil},
        {404, {GitHub.BasicError, :t}},
        {500, {GitHub.BasicError, :t}},
        {503, :map}
      ],
      opts: opts
    })
  end

  @doc """
  Get a review for a pull request

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/pulls#get-a-review-for-a-pull-request)

  """
  @spec get_review(String.t(), String.t(), integer, integer, keyword) ::
          {:ok, GitHub.PullRequest.Review.t()} | {:error, GitHub.Error.t()}
  def get_review(owner, repo, pull_number, review_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, pull_number: pull_number, review_id: review_id],
      call: {GitHub.Pulls, :get_review},
      url: "/repos/#{owner}/#{repo}/pulls/#{pull_number}/reviews/#{review_id}",
      method: :get,
      response: [{200, {GitHub.PullRequest.Review, :t}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a review comment for a pull request

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/pulls#get-a-review-comment-for-a-pull-request)

  """
  @spec get_review_comment(String.t(), String.t(), integer, keyword) ::
          {:ok, GitHub.PullRequest.ReviewComment.t()} | {:error, GitHub.Error.t()}
  def get_review_comment(owner, repo, comment_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, comment_id: comment_id],
      call: {GitHub.Pulls, :get_review_comment},
      url: "/repos/#{owner}/#{repo}/pulls/comments/#{comment_id}",
      method: :get,
      response: [{200, {GitHub.PullRequest.ReviewComment, :t}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  List pull requests

  ## Options

    * `state` (String.t()): Either `open`, `closed`, or `all` to filter by state.
    * `head` (String.t()): Filter pulls by head user or head organization and branch name in the format of `user:ref-name` or `organization:ref-name`. For example: `github:new-script-format` or `octocat:test-branch`.
    * `base` (String.t()): Filter pulls by base branch name. Example: `gh-pages`.
    * `sort` (String.t()): What to sort results by. `popularity` will sort by the number of comments. `long-running` will sort by date created and will limit the results to pull requests that have been open for more than a month and have had activity within the past month.
    * `direction` (String.t()): The direction of the sort. Default: `desc` when sort is `created` or sort is not specified, otherwise `asc`.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/pulls#list-pull-requests)

  """
  @spec list(String.t(), String.t(), keyword) ::
          {:ok, [GitHub.PullRequest.simple()]} | {:error, GitHub.Error.t()}
  def list(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:base, :direction, :head, :page, :per_page, :sort, :state])

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Pulls, :list},
      url: "/repos/#{owner}/#{repo}/pulls",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.PullRequest, :simple}}},
        {304, nil},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List comments for a pull request review

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/pulls#list-comments-for-a-pull-request-review)

  """
  @spec list_comments_for_review(String.t(), String.t(), integer, integer, keyword) ::
          {:ok, [GitHub.ReviewComment.t()]} | {:error, GitHub.Error.t()}
  def list_comments_for_review(owner, repo, pull_number, review_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [owner: owner, repo: repo, pull_number: pull_number, review_id: review_id],
      call: {GitHub.Pulls, :list_comments_for_review},
      url: "/repos/#{owner}/#{repo}/pulls/#{pull_number}/reviews/#{review_id}/comments",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.ReviewComment, :t}}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  List commits on a pull request

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/pulls#list-commits-on-a-pull-request)

  """
  @spec list_commits(String.t(), String.t(), integer, keyword) ::
          {:ok, [GitHub.Commit.t()]} | {:error, GitHub.Error.t()}
  def list_commits(owner, repo, pull_number, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [owner: owner, repo: repo, pull_number: pull_number],
      call: {GitHub.Pulls, :list_commits},
      url: "/repos/#{owner}/#{repo}/pulls/#{pull_number}/commits",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.Commit, :t}}}],
      opts: opts
    })
  end

  @doc """
  List pull requests files

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/pulls#list-pull-requests-files)

  """
  @spec list_files(String.t(), String.t(), integer, keyword) ::
          {:ok, [GitHub.DiffEntry.t()]} | {:error, GitHub.Error.t()}
  def list_files(owner, repo, pull_number, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [owner: owner, repo: repo, pull_number: pull_number],
      call: {GitHub.Pulls, :list_files},
      url: "/repos/#{owner}/#{repo}/pulls/#{pull_number}/files",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.DiffEntry, :t}}},
        {422, {GitHub.ValidationError, :t}},
        {500, {GitHub.BasicError, :t}},
        {503, :map}
      ],
      opts: opts
    })
  end

  @doc """
  Get all requested reviewers for a pull request

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/pulls#get-all-requested-reviewers-for-a-pull-request)

  """
  @spec list_requested_reviewers(String.t(), String.t(), integer, keyword) ::
          {:ok, GitHub.PullRequest.ReviewRequest.t()} | {:error, GitHub.Error.t()}
  def list_requested_reviewers(owner, repo, pull_number, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, pull_number: pull_number],
      call: {GitHub.Pulls, :list_requested_reviewers},
      url: "/repos/#{owner}/#{repo}/pulls/#{pull_number}/requested_reviewers",
      method: :get,
      response: [{200, {GitHub.PullRequest.ReviewRequest, :t}}],
      opts: opts
    })
  end

  @doc """
  List review comments on a pull request

  ## Options

    * `sort` (String.t()): The property to sort the results by. `created` means when the repository was starred. `updated` means when the repository was last pushed to.
    * `direction` (String.t()): The direction to sort results. Ignored without `sort` parameter.
    * `since` (String.t()): Only show notifications updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/pulls#list-review-comments-on-a-pull-request)

  """
  @spec list_review_comments(String.t(), String.t(), integer, keyword) ::
          {:ok, [GitHub.PullRequest.ReviewComment.t()]} | {:error, GitHub.Error.t()}
  def list_review_comments(owner, repo, pull_number, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:direction, :page, :per_page, :since, :sort])

    client.request(%{
      args: [owner: owner, repo: repo, pull_number: pull_number],
      call: {GitHub.Pulls, :list_review_comments},
      url: "/repos/#{owner}/#{repo}/pulls/#{pull_number}/comments",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.PullRequest.ReviewComment, :t}}}],
      opts: opts
    })
  end

  @doc """
  List review comments in a repository

  ## Options

    * `sort` (String.t()): 
    * `direction` (String.t()): The direction to sort results. Ignored without `sort` parameter.
    * `since` (String.t()): Only show notifications updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/pulls#list-review-comments-in-a-repository)

  """
  @spec list_review_comments_for_repo(String.t(), String.t(), keyword) ::
          {:ok, [GitHub.PullRequest.ReviewComment.t()]} | {:error, GitHub.Error.t()}
  def list_review_comments_for_repo(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:direction, :page, :per_page, :since, :sort])

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Pulls, :list_review_comments_for_repo},
      url: "/repos/#{owner}/#{repo}/pulls/comments",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.PullRequest.ReviewComment, :t}}}],
      opts: opts
    })
  end

  @doc """
  List reviews for a pull request

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/pulls#list-reviews-for-a-pull-request)

  """
  @spec list_reviews(String.t(), String.t(), integer, keyword) ::
          {:ok, [GitHub.PullRequest.Review.t()]} | {:error, GitHub.Error.t()}
  def list_reviews(owner, repo, pull_number, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [owner: owner, repo: repo, pull_number: pull_number],
      call: {GitHub.Pulls, :list_reviews},
      url: "/repos/#{owner}/#{repo}/pulls/#{pull_number}/reviews",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.PullRequest.Review, :t}}}],
      opts: opts
    })
  end

  @doc """
  Merge a pull request

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/pulls#merge-a-pull-request)

  """
  @spec merge(String.t(), String.t(), integer, map | nil, keyword) ::
          {:ok, GitHub.PullRequest.MergeResult.t()} | {:error, GitHub.Error.t()}
  def merge(owner, repo, pull_number, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, pull_number: pull_number],
      call: {GitHub.Pulls, :merge},
      url: "/repos/#{owner}/#{repo}/pulls/#{pull_number}/merge",
      body: body,
      method: :put,
      request: [{"application/json", {:nullable, :map}}],
      response: [
        {200, {GitHub.PullRequest.MergeResult, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {405, :map},
        {409, :map},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Remove requested reviewers from a pull request

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/pulls#remove-requested-reviewers-from-a-pull-request)

  """
  @spec remove_requested_reviewers(String.t(), String.t(), integer, map, keyword) ::
          {:ok, GitHub.PullRequest.simple()} | {:error, GitHub.Error.t()}
  def remove_requested_reviewers(owner, repo, pull_number, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, pull_number: pull_number],
      call: {GitHub.Pulls, :remove_requested_reviewers},
      url: "/repos/#{owner}/#{repo}/pulls/#{pull_number}/requested_reviewers",
      body: body,
      method: :delete,
      request: [{"application/json", :map}],
      response: [{200, {GitHub.PullRequest, :simple}}, {422, {GitHub.ValidationError, :t}}],
      opts: opts
    })
  end

  @doc """
  Request reviewers for a pull request

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/pulls#request-reviewers-for-a-pull-request)

  """
  @spec request_reviewers(String.t(), String.t(), integer, map, keyword) ::
          {:ok, GitHub.PullRequest.simple()} | {:error, GitHub.Error.t()}
  def request_reviewers(owner, repo, pull_number, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, pull_number: pull_number],
      call: {GitHub.Pulls, :request_reviewers},
      url: "/repos/#{owner}/#{repo}/pulls/#{pull_number}/requested_reviewers",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{201, {GitHub.PullRequest, :simple}}, {403, {GitHub.BasicError, :t}}, {422, nil}],
      opts: opts
    })
  end

  @doc """
  Submit a review for a pull request

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/pulls#submit-a-review-for-a-pull-request)

  """
  @spec submit_review(String.t(), String.t(), integer, integer, map, keyword) ::
          {:ok, GitHub.PullRequest.Review.t()} | {:error, GitHub.Error.t()}
  def submit_review(owner, repo, pull_number, review_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, pull_number: pull_number, review_id: review_id],
      call: {GitHub.Pulls, :submit_review},
      url: "/repos/#{owner}/#{repo}/pulls/#{pull_number}/reviews/#{review_id}/events",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {200, {GitHub.PullRequest.Review, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :simple}}
      ],
      opts: opts
    })
  end

  @doc """
  Update a pull request

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/pulls/#update-a-pull-request)

  """
  @spec update(String.t(), String.t(), integer, map, keyword) ::
          {:ok, GitHub.PullRequest.t()} | {:error, GitHub.Error.t()}
  def update(owner, repo, pull_number, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, pull_number: pull_number],
      call: {GitHub.Pulls, :update},
      url: "/repos/#{owner}/#{repo}/pulls/#{pull_number}",
      body: body,
      method: :patch,
      request: [{"application/json", :map}],
      response: [
        {200, {GitHub.PullRequest, :t}},
        {403, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Update a pull request branch

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/pulls#update-a-pull-request-branch)

  """
  @spec update_branch(String.t(), String.t(), integer, map | nil, keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def update_branch(owner, repo, pull_number, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, pull_number: pull_number],
      call: {GitHub.Pulls, :update_branch},
      url: "/repos/#{owner}/#{repo}/pulls/#{pull_number}/update-branch",
      body: body,
      method: :put,
      request: [{"application/json", {:nullable, :map}}],
      response: [{202, :map}, {403, {GitHub.BasicError, :t}}, {422, {GitHub.ValidationError, :t}}],
      opts: opts
    })
  end

  @doc """
  Update a review for a pull request

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/pulls#update-a-review-for-a-pull-request)

  """
  @spec update_review(String.t(), String.t(), integer, integer, map, keyword) ::
          {:ok, GitHub.PullRequest.Review.t()} | {:error, GitHub.Error.t()}
  def update_review(owner, repo, pull_number, review_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, pull_number: pull_number, review_id: review_id],
      call: {GitHub.Pulls, :update_review},
      url: "/repos/#{owner}/#{repo}/pulls/#{pull_number}/reviews/#{review_id}",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [{200, {GitHub.PullRequest.Review, :t}}, {422, {GitHub.ValidationError, :simple}}],
      opts: opts
    })
  end

  @doc """
  Update a review comment for a pull request

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/pulls#update-a-review-comment-for-a-pull-request)

  """
  @spec update_review_comment(String.t(), String.t(), integer, map, keyword) ::
          {:ok, GitHub.PullRequest.ReviewComment.t()} | {:error, GitHub.Error.t()}
  def update_review_comment(owner, repo, comment_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, comment_id: comment_id],
      call: {GitHub.Pulls, :update_review_comment},
      url: "/repos/#{owner}/#{repo}/pulls/comments/#{comment_id}",
      body: body,
      method: :patch,
      request: [{"application/json", :map}],
      response: [{200, {GitHub.PullRequest.ReviewComment, :t}}],
      opts: opts
    })
  end
end
