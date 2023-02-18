defmodule GitHub.Issues do
  @moduledoc """
  Provides API endpoints related to issues
  """

  @default_client GitHub.Client

  @doc """
  Add assignees to an issue

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/issues#add-assignees-to-an-issue)

  """
  @spec add_assignees(String.t(), String.t(), integer, map, keyword) ::
          {:ok, GitHub.Issue.t()} | {:error, GitHub.Error.t()}
  def add_assignees(owner, repo, issue_number, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/repos/#{owner}/#{repo}/issues/#{issue_number}/assignees",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{201, {GitHub.Issue, :t}}],
      opts: opts
    })
  end

  @doc """
  Add labels to an issue

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/issues#add-labels-to-an-issue)

  """
  @spec add_labels(
          String.t(),
          String.t(),
          integer,
          map | String.t() | [map] | [String.t()],
          keyword
        ) :: {:ok, [GitHub.Label.t()]} | {:error, GitHub.Error.t()}
  def add_labels(owner, repo, issue_number, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/repos/#{owner}/#{repo}/issues/#{issue_number}/labels",
      body: body,
      method: :post,
      request: [
        {"application/json", {:union, [:map, {:array, :string}, {:array, :map}, :string]}}
      ],
      response: [
        {200, {:array, {GitHub.Label, :t}}},
        {301, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {410, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Check if a user can be assigned

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/issues#check-if-a-user-can-be-assigned)

  """
  @spec check_user_can_be_assigned(String.t(), String.t(), String.t(), keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def check_user_can_be_assigned(owner, repo, assignee, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/repos/#{owner}/#{repo}/assignees/#{assignee}",
      method: :get,
      response: [{204, nil}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Create an issue

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/issues#create-an-issue)

  """
  @spec create(String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.Issue.t()} | {:error, GitHub.Error.t()}
  def create(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/repos/#{owner}/#{repo}/issues",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {201, {GitHub.Issue, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {410, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}},
        {503, :map}
      ],
      opts: opts
    })
  end

  @doc """
  Create an issue comment

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/issues#create-an-issue-comment)

  """
  @spec create_comment(String.t(), String.t(), integer, map, keyword) ::
          {:ok, GitHub.Issue.Comment.t()} | {:error, GitHub.Error.t()}
  def create_comment(owner, repo, issue_number, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/repos/#{owner}/#{repo}/issues/#{issue_number}/comments",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {201, {GitHub.Issue.Comment, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {410, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Create a label

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/issues#create-a-label)

  """
  @spec create_label(String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.Label.t()} | {:error, GitHub.Error.t()}
  def create_label(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/repos/#{owner}/#{repo}/labels",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {201, {GitHub.Label, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Create a milestone

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/issues#create-a-milestone)

  """
  @spec create_milestone(String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.Milestone.t()} | {:error, GitHub.Error.t()}
  def create_milestone(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/repos/#{owner}/#{repo}/milestones",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {201, {GitHub.Milestone, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Delete an issue comment

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/issues#delete-an-issue-comment)

  """
  @spec delete_comment(String.t(), String.t(), integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def delete_comment(owner, repo, comment_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/repos/#{owner}/#{repo}/issues/comments/#{comment_id}",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Delete a label

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/issues#delete-a-label)

  """
  @spec delete_label(String.t(), String.t(), String.t(), keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def delete_label(owner, repo, name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/repos/#{owner}/#{repo}/labels/#{name}",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Delete a milestone

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/issues#delete-a-milestone)

  """
  @spec delete_milestone(String.t(), String.t(), integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def delete_milestone(owner, repo, milestone_number, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/repos/#{owner}/#{repo}/milestones/#{milestone_number}",
      method: :delete,
      response: [{204, nil}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Get an issue

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/issues#get-an-issue)

  """
  @spec get(String.t(), String.t(), integer, keyword) ::
          {:ok, GitHub.Issue.t()} | {:error, GitHub.Error.t()}
  def get(owner, repo, issue_number, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/repos/#{owner}/#{repo}/issues/#{issue_number}",
      method: :get,
      response: [
        {200, {GitHub.Issue, :t}},
        {301, {GitHub.BasicError, :t}},
        {304, nil},
        {404, {GitHub.BasicError, :t}},
        {410, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get an issue comment

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/issues#get-an-issue-comment)

  """
  @spec get_comment(String.t(), String.t(), integer, keyword) ::
          {:ok, GitHub.Issue.Comment.t()} | {:error, GitHub.Error.t()}
  def get_comment(owner, repo, comment_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/repos/#{owner}/#{repo}/issues/comments/#{comment_id}",
      method: :get,
      response: [{200, {GitHub.Issue.Comment, :t}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Get an issue event

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/issues#get-an-issue-event)

  """
  @spec get_event(String.t(), String.t(), integer, keyword) ::
          {:ok, GitHub.Issue.Event.t()} | {:error, GitHub.Error.t()}
  def get_event(owner, repo, event_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/repos/#{owner}/#{repo}/issues/events/#{event_id}",
      method: :get,
      response: [
        {200, {GitHub.Issue.Event, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {410, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get a label

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/issues#get-a-label)

  """
  @spec get_label(String.t(), String.t(), String.t(), keyword) ::
          {:ok, GitHub.Label.t()} | {:error, GitHub.Error.t()}
  def get_label(owner, repo, name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/repos/#{owner}/#{repo}/labels/#{name}",
      method: :get,
      response: [{200, {GitHub.Label, :t}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a milestone

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/issues#get-a-milestone)

  """
  @spec get_milestone(String.t(), String.t(), integer, keyword) ::
          {:ok, GitHub.Milestone.t()} | {:error, GitHub.Error.t()}
  def get_milestone(owner, repo, milestone_number, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/repos/#{owner}/#{repo}/milestones/#{milestone_number}",
      method: :get,
      response: [{200, {GitHub.Milestone, :t}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  List issues assigned to the authenticated user

  ## Options

    * `filter` (String.t()): Indicates which sorts of issues to return. `assigned` means issues assigned to you. `created` means issues created by you. `mentioned` means issues mentioning you. `subscribed` means issues you're subscribed to updates for. `all` or `repos` means all issues you can see, regardless of participation or creation.
    * `state` (String.t()): Indicates the state of the issues to return.
    * `labels` (String.t()): A list of comma separated label names. Example: `bug,ui,@high`
    * `sort` (String.t()): What to sort results by.
    * `direction` (String.t()): The direction to sort the results by.
    * `since` (String.t()): Only show notifications updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    * `collab` (boolean): 
    * `orgs` (boolean): 
    * `owned` (boolean): 
    * `pulls` (boolean): 
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/issues#list-issues-assigned-to-the-authenticated-user)

  """
  @spec list(keyword) :: {:ok, [GitHub.Issue.t()]} | {:error, GitHub.Error.t()}
  def list(opts \\ []) do
    client = opts[:client] || @default_client

    query =
      Keyword.take(opts, [
        :collab,
        :direction,
        :filter,
        :labels,
        :orgs,
        :owned,
        :page,
        :per_page,
        :pulls,
        :since,
        :sort,
        :state
      ])

    client.request(%{
      url: "/issues",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.Issue, :t}}},
        {304, nil},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List assignees

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/issues#list-assignees)

  """
  @spec list_assignees(String.t(), String.t(), keyword) ::
          {:ok, [GitHub.User.simple()]} | {:error, GitHub.Error.t()}
  def list_assignees(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      url: "/repos/#{owner}/#{repo}/assignees",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.User, :simple}}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  List issue comments

  ## Options

    * `since` (String.t()): Only show notifications updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/issues#list-issue-comments)

  """
  @spec list_comments(String.t(), String.t(), integer, keyword) ::
          {:ok, [GitHub.Issue.Comment.t()]} | {:error, GitHub.Error.t()}
  def list_comments(owner, repo, issue_number, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page, :since])

    client.request(%{
      url: "/repos/#{owner}/#{repo}/issues/#{issue_number}/comments",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.Issue.Comment, :t}}},
        {404, {GitHub.BasicError, :t}},
        {410, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List issue comments for a repository

  ## Options

    * `sort` (String.t()): The property to sort the results by. `created` means when the repository was starred. `updated` means when the repository was last pushed to.
    * `direction` (String.t()): Either `asc` or `desc`. Ignored without the `sort` parameter.
    * `since` (String.t()): Only show notifications updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/issues#list-issue-comments-for-a-repository)

  """
  @spec list_comments_for_repo(String.t(), String.t(), keyword) ::
          {:ok, [GitHub.Issue.Comment.t()]} | {:error, GitHub.Error.t()}
  def list_comments_for_repo(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:direction, :page, :per_page, :since, :sort])

    client.request(%{
      url: "/repos/#{owner}/#{repo}/issues/comments",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.Issue.Comment, :t}}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List issue events

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/issues#list-issue-events)

  """
  @spec list_events(String.t(), String.t(), integer, keyword) ::
          {:ok,
           [
             GitHub.AddedToProjectIssueEvent.t()
             | GitHub.AssignedIssueEvent.t()
             | GitHub.ConvertedNoteToIssueIssueEvent.t()
             | GitHub.DemilestonedIssueEvent.t()
             | GitHub.LabeledIssueEvent.t()
             | GitHub.LockedIssueEvent.t()
             | GitHub.MilestonedIssueEvent.t()
             | GitHub.MovedColumnInProjectIssueEvent.t()
             | GitHub.RemovedFromProjectIssueEvent.t()
             | GitHub.RenamedIssueEvent.t()
             | GitHub.ReviewDismissedIssueEvent.t()
             | GitHub.ReviewRequestRemovedIssueEvent.t()
             | GitHub.ReviewRequestedIssueEvent.t()
             | GitHub.UnassignedIssueEvent.t()
             | GitHub.UnlabeledIssueEvent.t()
           ]}
          | {:error, GitHub.Error.t()}
  def list_events(owner, repo, issue_number, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      url: "/repos/#{owner}/#{repo}/issues/#{issue_number}/events",
      method: :get,
      query: query,
      response: [
        {200,
         {:array,
          {:union,
           [
             {GitHub.LabeledIssueEvent, :t},
             {GitHub.UnlabeledIssueEvent, :t},
             {GitHub.AssignedIssueEvent, :t},
             {GitHub.UnassignedIssueEvent, :t},
             {GitHub.MilestonedIssueEvent, :t},
             {GitHub.DemilestonedIssueEvent, :t},
             {GitHub.RenamedIssueEvent, :t},
             {GitHub.ReviewRequestedIssueEvent, :t},
             {GitHub.ReviewRequestRemovedIssueEvent, :t},
             {GitHub.ReviewDismissedIssueEvent, :t},
             {GitHub.LockedIssueEvent, :t},
             {GitHub.AddedToProjectIssueEvent, :t},
             {GitHub.MovedColumnInProjectIssueEvent, :t},
             {GitHub.RemovedFromProjectIssueEvent, :t},
             {GitHub.ConvertedNoteToIssueIssueEvent, :t}
           ]}}},
        {410, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List issue events for a repository

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/issues#list-issue-events-for-a-repository)

  """
  @spec list_events_for_repo(String.t(), String.t(), keyword) ::
          {:ok, [GitHub.Issue.Event.t()]} | {:error, GitHub.Error.t()}
  def list_events_for_repo(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      url: "/repos/#{owner}/#{repo}/issues/events",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.Issue.Event, :t}}}, {422, {GitHub.ValidationError, :t}}],
      opts: opts
    })
  end

  @doc """
  List timeline events for an issue

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/issues#list-timeline-events-for-an-issue)

  """
  @spec list_events_for_timeline(String.t(), String.t(), integer, keyword) ::
          {:ok,
           [
             GitHub.AddedToProjectIssueEvent.t()
             | GitHub.ConvertedNoteToIssueIssueEvent.t()
             | GitHub.DemilestonedIssueEvent.t()
             | GitHub.LabeledIssueEvent.t()
             | GitHub.LockedIssueEvent.t()
             | GitHub.MilestonedIssueEvent.t()
             | GitHub.MovedColumnInProjectIssueEvent.t()
             | GitHub.RemovedFromProjectIssueEvent.t()
             | GitHub.RenamedIssueEvent.t()
             | GitHub.ReviewDismissedIssueEvent.t()
             | GitHub.ReviewRequestRemovedIssueEvent.t()
             | GitHub.ReviewRequestedIssueEvent.t()
             | GitHub.StateChangeIssueEvent.t()
             | GitHub.Timeline.AssignedIssueEvent.t()
             | GitHub.Timeline.CommentEvent.t()
             | GitHub.Timeline.CommitCommentedEvent.t()
             | GitHub.Timeline.CommittedEvent.t()
             | GitHub.Timeline.CrossReferencedEvent.t()
             | GitHub.Timeline.LineCommentedEvent.t()
             | GitHub.Timeline.ReviewedEvent.t()
             | GitHub.Timeline.UnassignedIssueEvent.t()
             | GitHub.UnlabeledIssueEvent.t()
           ]}
          | {:error, GitHub.Error.t()}
  def list_events_for_timeline(owner, repo, issue_number, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      url: "/repos/#{owner}/#{repo}/issues/#{issue_number}/timeline",
      method: :get,
      query: query,
      response: [
        {200,
         {:array,
          {:union,
           [
             {GitHub.LabeledIssueEvent, :t},
             {GitHub.UnlabeledIssueEvent, :t},
             {GitHub.MilestonedIssueEvent, :t},
             {GitHub.DemilestonedIssueEvent, :t},
             {GitHub.RenamedIssueEvent, :t},
             {GitHub.ReviewRequestedIssueEvent, :t},
             {GitHub.ReviewRequestRemovedIssueEvent, :t},
             {GitHub.ReviewDismissedIssueEvent, :t},
             {GitHub.LockedIssueEvent, :t},
             {GitHub.AddedToProjectIssueEvent, :t},
             {GitHub.MovedColumnInProjectIssueEvent, :t},
             {GitHub.RemovedFromProjectIssueEvent, :t},
             {GitHub.ConvertedNoteToIssueIssueEvent, :t},
             {GitHub.Timeline.CommentEvent, :t},
             {GitHub.Timeline.CrossReferencedEvent, :t},
             {GitHub.Timeline.CommittedEvent, :t},
             {GitHub.Timeline.ReviewedEvent, :t},
             {GitHub.Timeline.LineCommentedEvent, :t},
             {GitHub.Timeline.CommitCommentedEvent, :t},
             {GitHub.Timeline.AssignedIssueEvent, :t},
             {GitHub.Timeline.UnassignedIssueEvent, :t},
             {GitHub.StateChangeIssueEvent, :t}
           ]}}},
        {404, {GitHub.BasicError, :t}},
        {410, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List user account issues assigned to the authenticated user

  ## Options

    * `filter` (String.t()): Indicates which sorts of issues to return. `assigned` means issues assigned to you. `created` means issues created by you. `mentioned` means issues mentioning you. `subscribed` means issues you're subscribed to updates for. `all` or `repos` means all issues you can see, regardless of participation or creation.
    * `state` (String.t()): Indicates the state of the issues to return.
    * `labels` (String.t()): A list of comma separated label names. Example: `bug,ui,@high`
    * `sort` (String.t()): What to sort results by.
    * `direction` (String.t()): The direction to sort the results by.
    * `since` (String.t()): Only show notifications updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/issues#list-user-account-issues-assigned-to-the-authenticated-user)

  """
  @spec list_for_authenticated_user(keyword) ::
          {:ok, [GitHub.Issue.t()]} | {:error, GitHub.Error.t()}
  def list_for_authenticated_user(opts \\ []) do
    client = opts[:client] || @default_client

    query =
      Keyword.take(opts, [:direction, :filter, :labels, :page, :per_page, :since, :sort, :state])

    client.request(%{
      url: "/user/issues",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.Issue, :t}}}, {304, nil}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  List organization issues assigned to the authenticated user

  ## Options

    * `filter` (String.t()): Indicates which sorts of issues to return. `assigned` means issues assigned to you. `created` means issues created by you. `mentioned` means issues mentioning you. `subscribed` means issues you're subscribed to updates for. `all` or `repos` means all issues you can see, regardless of participation or creation.
    * `state` (String.t()): Indicates the state of the issues to return.
    * `labels` (String.t()): A list of comma separated label names. Example: `bug,ui,@high`
    * `sort` (String.t()): What to sort results by.
    * `direction` (String.t()): The direction to sort the results by.
    * `since` (String.t()): Only show notifications updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/issues#list-organization-issues-assigned-to-the-authenticated-user)

  """
  @spec list_for_org(String.t(), keyword) ::
          {:ok, [GitHub.Issue.t()]} | {:error, GitHub.Error.t()}
  def list_for_org(org, opts \\ []) do
    client = opts[:client] || @default_client

    query =
      Keyword.take(opts, [:direction, :filter, :labels, :page, :per_page, :since, :sort, :state])

    client.request(%{
      url: "/orgs/#{org}/issues",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.Issue, :t}}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  List repository issues

  ## Options

    * `milestone` (String.t()): If an `integer` is passed, it should refer to a milestone by its `number` field. If the string `*` is passed, issues with any milestone are accepted. If the string `none` is passed, issues without milestones are returned.
    * `state` (String.t()): Indicates the state of the issues to return.
    * `assignee` (String.t()): Can be the name of a user. Pass in `none` for issues with no assigned user, and `*` for issues assigned to any user.
    * `creator` (String.t()): The user that created the issue.
    * `mentioned` (String.t()): A user that's mentioned in the issue.
    * `labels` (String.t()): A list of comma separated label names. Example: `bug,ui,@high`
    * `sort` (String.t()): What to sort results by.
    * `direction` (String.t()): The direction to sort the results by.
    * `since` (String.t()): Only show notifications updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/issues#list-repository-issues)

  """
  @spec list_for_repo(String.t(), String.t(), keyword) ::
          {:ok, [GitHub.Issue.t()]} | {:error, GitHub.Error.t()}
  def list_for_repo(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    query =
      Keyword.take(opts, [
        :assignee,
        :creator,
        :direction,
        :labels,
        :mentioned,
        :milestone,
        :page,
        :per_page,
        :since,
        :sort,
        :state
      ])

    client.request(%{
      url: "/repos/#{owner}/#{repo}/issues",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.Issue, :t}}},
        {301, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List labels for issues in a milestone

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/issues#list-labels-for-issues-in-a-milestone)

  """
  @spec list_labels_for_milestone(String.t(), String.t(), integer, keyword) ::
          {:ok, [GitHub.Label.t()]} | {:error, GitHub.Error.t()}
  def list_labels_for_milestone(owner, repo, milestone_number, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      url: "/repos/#{owner}/#{repo}/milestones/#{milestone_number}/labels",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.Label, :t}}}],
      opts: opts
    })
  end

  @doc """
  List labels for a repository

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/issues#list-labels-for-a-repository)

  """
  @spec list_labels_for_repo(String.t(), String.t(), keyword) ::
          {:ok, [GitHub.Label.t()]} | {:error, GitHub.Error.t()}
  def list_labels_for_repo(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      url: "/repos/#{owner}/#{repo}/labels",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.Label, :t}}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  List labels for an issue

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/issues#list-labels-for-an-issue)

  """
  @spec list_labels_on_issue(String.t(), String.t(), integer, keyword) ::
          {:ok, [GitHub.Label.t()]} | {:error, GitHub.Error.t()}
  def list_labels_on_issue(owner, repo, issue_number, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      url: "/repos/#{owner}/#{repo}/issues/#{issue_number}/labels",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.Label, :t}}},
        {301, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {410, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List milestones

  ## Options

    * `state` (String.t()): The state of the milestone. Either `open`, `closed`, or `all`.
    * `sort` (String.t()): What to sort results by. Either `due_on` or `completeness`.
    * `direction` (String.t()): The direction of the sort. Either `asc` or `desc`.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/issues#list-milestones)

  """
  @spec list_milestones(String.t(), String.t(), keyword) ::
          {:ok, [GitHub.Milestone.t()]} | {:error, GitHub.Error.t()}
  def list_milestones(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:direction, :page, :per_page, :sort, :state])

    client.request(%{
      url: "/repos/#{owner}/#{repo}/milestones",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.Milestone, :t}}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Lock an issue

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/issues#lock-an-issue)

  """
  @spec lock(String.t(), String.t(), integer, map | nil, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def lock(owner, repo, issue_number, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/repos/#{owner}/#{repo}/issues/#{issue_number}/lock",
      body: body,
      method: :put,
      request: [{"application/json", {:nullable, :map}}],
      response: [
        {204, nil},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {410, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Remove all labels from an issue

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/issues#remove-all-labels-from-an-issue)

  """
  @spec remove_all_labels(String.t(), String.t(), integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def remove_all_labels(owner, repo, issue_number, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/repos/#{owner}/#{repo}/issues/#{issue_number}/labels",
      method: :delete,
      response: [
        {204, nil},
        {301, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {410, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Remove assignees from an issue

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/issues#remove-assignees-from-an-issue)

  """
  @spec remove_assignees(String.t(), String.t(), integer, map, keyword) ::
          {:ok, GitHub.Issue.t()} | {:error, GitHub.Error.t()}
  def remove_assignees(owner, repo, issue_number, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/repos/#{owner}/#{repo}/issues/#{issue_number}/assignees",
      body: body,
      method: :delete,
      request: [{"application/json", :map}],
      response: [{200, {GitHub.Issue, :t}}],
      opts: opts
    })
  end

  @doc """
  Remove a label from an issue

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/issues#remove-a-label-from-an-issue)

  """
  @spec remove_label(String.t(), String.t(), integer, String.t(), keyword) ::
          {:ok, [GitHub.Label.t()]} | {:error, GitHub.Error.t()}
  def remove_label(owner, repo, issue_number, name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/repos/#{owner}/#{repo}/issues/#{issue_number}/labels/#{name}",
      method: :delete,
      response: [
        {200, {:array, {GitHub.Label, :t}}},
        {301, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {410, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Set labels for an issue

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/issues#set-labels-for-an-issue)

  """
  @spec set_labels(
          String.t(),
          String.t(),
          integer,
          map | String.t() | [map] | [String.t()],
          keyword
        ) :: {:ok, [GitHub.Label.t()]} | {:error, GitHub.Error.t()}
  def set_labels(owner, repo, issue_number, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/repos/#{owner}/#{repo}/issues/#{issue_number}/labels",
      body: body,
      method: :put,
      request: [
        {"application/json", {:union, [:map, {:array, :string}, {:array, :map}, :string]}}
      ],
      response: [
        {200, {:array, {GitHub.Label, :t}}},
        {301, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {410, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Unlock an issue

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/issues#unlock-an-issue)

  """
  @spec unlock(String.t(), String.t(), integer, keyword) :: :ok | {:error, GitHub.Error.t()}
  def unlock(owner, repo, issue_number, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/repos/#{owner}/#{repo}/issues/#{issue_number}/lock",
      method: :delete,
      response: [{204, nil}, {403, {GitHub.BasicError, :t}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Update an issue

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/issues#update-an-issue)

  """
  @spec update(String.t(), String.t(), integer, map, keyword) ::
          {:ok, GitHub.Issue.t()} | {:error, GitHub.Error.t()}
  def update(owner, repo, issue_number, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/repos/#{owner}/#{repo}/issues/#{issue_number}",
      body: body,
      method: :patch,
      request: [{"application/json", :map}],
      response: [
        {200, {GitHub.Issue, :t}},
        {301, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {410, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}},
        {503, :map}
      ],
      opts: opts
    })
  end

  @doc """
  Update an issue comment

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/issues#update-an-issue-comment)

  """
  @spec update_comment(String.t(), String.t(), integer, map, keyword) ::
          {:ok, GitHub.Issue.Comment.t()} | {:error, GitHub.Error.t()}
  def update_comment(owner, repo, comment_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/repos/#{owner}/#{repo}/issues/comments/#{comment_id}",
      body: body,
      method: :patch,
      request: [{"application/json", :map}],
      response: [{200, {GitHub.Issue.Comment, :t}}, {422, {GitHub.ValidationError, :t}}],
      opts: opts
    })
  end

  @doc """
  Update a label

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/issues#update-a-label)

  """
  @spec update_label(String.t(), String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.Label.t()} | {:error, GitHub.Error.t()}
  def update_label(owner, repo, name, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/repos/#{owner}/#{repo}/labels/#{name}",
      body: body,
      method: :patch,
      request: [{"application/json", :map}],
      response: [{200, {GitHub.Label, :t}}],
      opts: opts
    })
  end

  @doc """
  Update a milestone

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/issues#update-a-milestone)

  """
  @spec update_milestone(String.t(), String.t(), integer, map, keyword) ::
          {:ok, GitHub.Milestone.t()} | {:error, GitHub.Error.t()}
  def update_milestone(owner, repo, milestone_number, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/repos/#{owner}/#{repo}/milestones/#{milestone_number}",
      body: body,
      method: :patch,
      request: [{"application/json", :map}],
      response: [{200, {GitHub.Milestone, :t}}],
      opts: opts
    })
  end
end
