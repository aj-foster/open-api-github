defmodule GitHub.Activity do
  @moduledoc """
  Provides API endpoints related to activity
  """

  @default_client GitHub.Client

  @doc """
  Check if a repository is starred by the authenticated user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/activity#check-if-a-repository-is-starred-by-the-authenticated-user)

  """
  @spec check_repo_is_starred_by_authenticated_user(String.t(), String.t(), keyword) ::
          :ok | {:error, GitHub.BasicError.t()}
  def check_repo_is_starred_by_authenticated_user(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/user/starred/#{owner}/#{repo}",
      method: :get,
      response: [
        {204, nil},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Delete a repository subscription

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/activity#delete-a-repository-subscription)

  """
  @spec delete_repo_subscription(String.t(), String.t(), keyword) :: :ok | :error
  def delete_repo_subscription(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/repos/#{owner}/#{repo}/subscription",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Delete a thread subscription

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/activity#delete-a-thread-subscription)

  """
  @spec delete_thread_subscription(integer, keyword) :: :ok | {:error, GitHub.BasicError.t()}
  def delete_thread_subscription(thread_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/notifications/threads/#{thread_id}/subscription",
      method: :delete,
      response: [
        {204, nil},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get feeds

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/activity#get-feeds)

  """
  @spec get_feeds(keyword) :: {:ok, GitHub.Feed.t()} | :error
  def get_feeds(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/feeds",
      method: :get,
      response: [{200, {GitHub.Feed, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a repository subscription

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/activity#get-a-repository-subscription)

  """
  @spec get_repo_subscription(String.t(), String.t(), keyword) ::
          {:ok, GitHub.Repository.Subscription.t()} | {:error, GitHub.BasicError.t()}
  def get_repo_subscription(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/repos/#{owner}/#{repo}/subscription",
      method: :get,
      response: [
        {200, {GitHub.Repository.Subscription, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, nil}
      ],
      opts: opts
    })
  end

  @doc """
  Get a thread

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/activity#get-a-thread)

  """
  @spec get_thread(integer, keyword) :: {:ok, GitHub.Thread.t()} | {:error, GitHub.BasicError.t()}
  def get_thread(thread_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/notifications/threads/#{thread_id}",
      method: :get,
      response: [
        {200, {GitHub.Thread, :t}},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get a thread subscription for the authenticated user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/activity#get-a-thread-subscription-for-the-authenticated-user)

  """
  @spec get_thread_subscription_for_authenticated_user(integer, keyword) ::
          {:ok, GitHub.ThreadSubscription.t()} | {:error, GitHub.BasicError.t()}
  def get_thread_subscription_for_authenticated_user(thread_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/notifications/threads/#{thread_id}/subscription",
      method: :get,
      response: [
        {200, {GitHub.ThreadSubscription, :t}},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List events for the authenticated user

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/activity#list-events-for-the-authenticated-user)

  """
  @spec list_events_for_authenticated_user(String.t(), keyword) ::
          {:ok, [GitHub.Event.t()]} | :error
  def list_events_for_authenticated_user(username, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      url: "/users/#{username}/events",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.Event, :t}}}],
      opts: opts
    })
  end

  @doc """
  List notifications for the authenticated user

  ## Options

    * `all` (boolean): If `true`, show notifications marked as read.
    * `participating` (boolean): If `true`, only shows notifications in which the user is directly participating or mentioned.
    * `since` (String.t()): Only show notifications updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    * `before` (String.t()): Only show notifications updated before the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    * `page` (integer): Page number of the results to fetch.
    * `per_page` (integer): The number of results per page (max 50).

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/activity#list-notifications-for-the-authenticated-user)

  """
  @spec list_notifications_for_authenticated_user(keyword) ::
          {:ok, [GitHub.Thread.t()]}
          | {:error, GitHub.BasicError.t() | GitHub.ValidationError.t()}
  def list_notifications_for_authenticated_user(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:all, :before, :page, :participating, :per_page, :since])

    client.request(%{
      url: "/notifications",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.Thread, :t}}},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List organization events for the authenticated user

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/activity#list-organization-events-for-the-authenticated-user)

  """
  @spec list_org_events_for_authenticated_user(String.t(), String.t(), keyword) ::
          {:ok, [GitHub.Event.t()]} | :error
  def list_org_events_for_authenticated_user(username, org, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      url: "/users/#{username}/events/orgs/#{org}",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.Event, :t}}}],
      opts: opts
    })
  end

  @doc """
  List public events

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/activity#list-public-events)

  """
  @spec list_public_events(keyword) ::
          {:ok, [GitHub.Event.t()]} | {:error, map | GitHub.BasicError.t()}
  def list_public_events(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      url: "/events",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.Event, :t}}},
        {304, nil},
        {403, {GitHub.BasicError, :t}},
        {503, :map}
      ],
      opts: opts
    })
  end

  @doc """
  List public events for a network of repositories

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/activity#list-public-events-for-a-network-of-repositories)

  """
  @spec list_public_events_for_repo_network(String.t(), String.t(), keyword) ::
          {:ok, [GitHub.Event.t()]} | {:error, GitHub.BasicError.t()}
  def list_public_events_for_repo_network(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      url: "/networks/#{owner}/#{repo}/events",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.Event, :t}}},
        {301, {GitHub.BasicError, :t}},
        {304, nil},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List public events for a user

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/activity#list-public-events-for-a-user)

  """
  @spec list_public_events_for_user(String.t(), keyword) :: {:ok, [GitHub.Event.t()]} | :error
  def list_public_events_for_user(username, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      url: "/users/#{username}/events/public",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.Event, :t}}}],
      opts: opts
    })
  end

  @doc """
  List public organization events

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/activity#list-public-organization-events)

  """
  @spec list_public_org_events(String.t(), keyword) :: {:ok, [GitHub.Event.t()]} | :error
  def list_public_org_events(org, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      url: "/orgs/#{org}/events",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.Event, :t}}}],
      opts: opts
    })
  end

  @doc """
  List events received by the authenticated user

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/activity#list-events-received-by-the-authenticated-user)

  """
  @spec list_received_events_for_user(String.t(), keyword) :: {:ok, [GitHub.Event.t()]} | :error
  def list_received_events_for_user(username, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      url: "/users/#{username}/received_events",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.Event, :t}}}],
      opts: opts
    })
  end

  @doc """
  List public events received by a user

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/activity#list-public-events-received-by-a-user)

  """
  @spec list_received_public_events_for_user(String.t(), keyword) ::
          {:ok, [GitHub.Event.t()]} | :error
  def list_received_public_events_for_user(username, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      url: "/users/#{username}/received_events/public",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.Event, :t}}}],
      opts: opts
    })
  end

  @doc """
  List repository events

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/activity#list-repository-events)

  """
  @spec list_repo_events(String.t(), String.t(), keyword) :: {:ok, [GitHub.Event.t()]} | :error
  def list_repo_events(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      url: "/repos/#{owner}/#{repo}/events",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.Event, :t}}}],
      opts: opts
    })
  end

  @doc """
  List repository notifications for the authenticated user

  ## Options

    * `all` (boolean): If `true`, show notifications marked as read.
    * `participating` (boolean): If `true`, only shows notifications in which the user is directly participating or mentioned.
    * `since` (String.t()): Only show notifications updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    * `before` (String.t()): Only show notifications updated before the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/activity#list-repository-notifications-for-the-authenticated-user)

  """
  @spec list_repo_notifications_for_authenticated_user(String.t(), String.t(), keyword) ::
          {:ok, [GitHub.Thread.t()]} | :error
  def list_repo_notifications_for_authenticated_user(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:all, :before, :page, :participating, :per_page, :since])

    client.request(%{
      url: "/repos/#{owner}/#{repo}/notifications",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.Thread, :t}}}],
      opts: opts
    })
  end

  @doc """
  List repositories starred by the authenticated user

  ## Options

    * `sort` (String.t()): The property to sort the results by. `created` means when the repository was starred. `updated` means when the repository was last pushed to.
    * `direction` (String.t()): The direction to sort the results by.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/activity#list-repositories-starred-by-the-authenticated-user)

  """
  @spec list_repos_starred_by_authenticated_user(keyword) ::
          {:ok, [GitHub.Repository.t()]} | {:error, GitHub.BasicError.t()}
  def list_repos_starred_by_authenticated_user(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:direction, :page, :per_page, :sort])

    client.request(%{
      url: "/user/starred",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.Repository, :t}}},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List repositories starred by a user

  ## Options

    * `sort` (String.t()): The property to sort the results by. `created` means when the repository was starred. `updated` means when the repository was last pushed to.
    * `direction` (String.t()): The direction to sort the results by.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/activity#list-repositories-starred-by-a-user)

  """
  @spec list_repos_starred_by_user(String.t(), keyword) ::
          {:ok, [GitHub.Repository.t()] | [GitHub.StarredRepository.t()]} | :error
  def list_repos_starred_by_user(username, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:direction, :page, :per_page, :sort])

    client.request(%{
      url: "/users/#{username}/starred",
      method: :get,
      query: query,
      response: [
        {200, {:union, array: {GitHub.StarredRepository, :t}, array: {GitHub.Repository, :t}}}
      ],
      opts: opts
    })
  end

  @doc """
  List repositories watched by a user

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/activity#list-repositories-watched-by-a-user)

  """
  @spec list_repos_watched_by_user(String.t(), keyword) ::
          {:ok, [GitHub.MinimalRepository.t()]} | :error
  def list_repos_watched_by_user(username, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      url: "/users/#{username}/subscriptions",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.MinimalRepository, :t}}}],
      opts: opts
    })
  end

  @doc """
  List stargazers

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/activity#list-stargazers)

  """
  @spec list_stargazers_for_repo(String.t(), String.t(), keyword) ::
          {:ok, [GitHub.Stargazer.t()] | [GitHub.User.simple()]}
          | {:error, GitHub.ValidationError.t()}
  def list_stargazers_for_repo(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      url: "/repos/#{owner}/#{repo}/stargazers",
      method: :get,
      query: query,
      response: [
        {200, {:union, array: {GitHub.User, :simple}, array: {GitHub.Stargazer, :t}}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List repositories watched by the authenticated user

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/activity#list-repositories-watched-by-the-authenticated-user)

  """
  @spec list_watched_repos_for_authenticated_user(keyword) ::
          {:ok, [GitHub.MinimalRepository.t()]} | {:error, GitHub.BasicError.t()}
  def list_watched_repos_for_authenticated_user(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      url: "/user/subscriptions",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.MinimalRepository, :t}}},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List watchers

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/activity#list-watchers)

  """
  @spec list_watchers_for_repo(String.t(), String.t(), keyword) ::
          {:ok, [GitHub.User.simple()]} | :error
  def list_watchers_for_repo(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      url: "/repos/#{owner}/#{repo}/subscribers",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.User, :simple}}}],
      opts: opts
    })
  end

  @doc """
  Mark notifications as read

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/activity#mark-notifications-as-read)

  """
  @spec mark_notifications_as_read(map, keyword) :: {:ok, map} | {:error, GitHub.BasicError.t()}
  def mark_notifications_as_read(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/notifications",
      body: body,
      method: :put,
      response: [
        {202, :map},
        {205, nil},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Mark repository notifications as read

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/activity#mark-repository-notifications-as-read)

  """
  @spec mark_repo_notifications_as_read(String.t(), String.t(), map, keyword) ::
          {:ok, map} | :error
  def mark_repo_notifications_as_read(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/repos/#{owner}/#{repo}/notifications",
      body: body,
      method: :put,
      response: [{202, :map}, {205, nil}],
      opts: opts
    })
  end

  @doc """
  Mark a thread as read

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/activity#mark-a-thread-as-read)

  """
  @spec mark_thread_as_read(integer, keyword) :: :ok | {:error, GitHub.BasicError.t()}
  def mark_thread_as_read(thread_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/notifications/threads/#{thread_id}",
      method: :patch,
      response: [{205, nil}, {304, nil}, {403, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Set a repository subscription

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/activity#set-a-repository-subscription)

  """
  @spec set_repo_subscription(String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.Repository.Subscription.t()} | :error
  def set_repo_subscription(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/repos/#{owner}/#{repo}/subscription",
      body: body,
      method: :put,
      response: [{200, {GitHub.Repository.Subscription, :t}}],
      opts: opts
    })
  end

  @doc """
  Set a thread subscription

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/activity#set-a-thread-subscription)

  """
  @spec set_thread_subscription(integer, map, keyword) ::
          {:ok, GitHub.ThreadSubscription.t()} | {:error, GitHub.BasicError.t()}
  def set_thread_subscription(thread_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/notifications/threads/#{thread_id}/subscription",
      body: body,
      method: :put,
      response: [
        {200, {GitHub.ThreadSubscription, :t}},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Star a repository for the authenticated user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/activity#star-a-repository-for-the-authenticated-user)

  """
  @spec star_repo_for_authenticated_user(String.t(), String.t(), keyword) ::
          :ok | {:error, GitHub.BasicError.t()}
  def star_repo_for_authenticated_user(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/user/starred/#{owner}/#{repo}",
      method: :put,
      response: [
        {204, nil},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Unstar a repository for the authenticated user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/activity#unstar-a-repository-for-the-authenticated-user)

  """
  @spec unstar_repo_for_authenticated_user(String.t(), String.t(), keyword) ::
          :ok | {:error, GitHub.BasicError.t()}
  def unstar_repo_for_authenticated_user(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/user/starred/#{owner}/#{repo}",
      method: :delete,
      response: [
        {204, nil},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end
end
