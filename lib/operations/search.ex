defmodule GitHub.Search do
  @moduledoc """
  Provides API endpoints related to search
  """

  @default_client GitHub.Client

  @doc """
  Search code

  ## Options

    * `q` (String.t()): The query contains one or more search keywords and qualifiers. Qualifiers allow you to limit your search to specific areas of GitHub. The REST API supports the same qualifiers as the web interface for GitHub. To learn more about the format of the query, see [Constructing a search query](https://docs.github.com/rest/search/search#constructing-a-search-query). See "[Searching code](https://docs.github.com/search-github/searching-on-github/searching-code)" for a detailed list of qualifiers.
    * `sort` (String.t()): **This field is deprecated.** Sorts the results of your query. Can only be `indexed`, which indicates how recently a file has been indexed by the GitHub search infrastructure. Default: [best match](https://docs.github.com/rest/search/search#ranking-search-results)
    * `order` (String.t()): **This field is deprecated.** Determines whether the first search result returned is the highest number of matches (`desc`) or lowest number of matches (`asc`). This parameter is ignored unless you provide `sort`. 
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/search/search#search-code)

  """
  @spec code(keyword) :: {:ok, map} | {:error, GitHub.Error.t()}
  def code(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:order, :page, :per_page, :q, :sort])

    client.request(%{
      call: {GitHub.Search, :code},
      url: "/search/code",
      method: :get,
      query: query,
      response: [
        {200, :map},
        {304, nil},
        {403, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}},
        {503, :map}
      ],
      opts: opts
    })
  end

  @doc """
  Search commits

  ## Options

    * `q` (String.t()): The query contains one or more search keywords and qualifiers. Qualifiers allow you to limit your search to specific areas of GitHub. The REST API supports the same qualifiers as the web interface for GitHub. To learn more about the format of the query, see [Constructing a search query](https://docs.github.com/rest/search/search#constructing-a-search-query). See "[Searching commits](https://docs.github.com/search-github/searching-on-github/searching-commits)" for a detailed list of qualifiers.
    * `sort` (String.t()): Sorts the results of your query by `author-date` or `committer-date`. Default: [best match](https://docs.github.com/rest/search/search#ranking-search-results)
    * `order` (String.t()): Determines whether the first search result returned is the highest number of matches (`desc`) or lowest number of matches (`asc`). This parameter is ignored unless you provide `sort`.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/search/search#search-commits)

  """
  @spec commits(keyword) :: {:ok, map} | {:error, GitHub.Error.t()}
  def commits(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:order, :page, :per_page, :q, :sort])

    client.request(%{
      call: {GitHub.Search, :commits},
      url: "/search/commits",
      method: :get,
      query: query,
      response: [{200, :map}, {304, nil}],
      opts: opts
    })
  end

  @doc """
  Search issues and pull requests

  ## Options

    * `q` (String.t()): The query contains one or more search keywords and qualifiers. Qualifiers allow you to limit your search to specific areas of GitHub. The REST API supports the same qualifiers as the web interface for GitHub. To learn more about the format of the query, see [Constructing a search query](https://docs.github.com/rest/search/search#constructing-a-search-query). See "[Searching issues and pull requests](https://docs.github.com/search-github/searching-on-github/searching-issues-and-pull-requests)" for a detailed list of qualifiers.
    * `sort` (String.t()): Sorts the results of your query by the number of `comments`, `reactions`, `reactions-+1`, `reactions--1`, `reactions-smile`, `reactions-thinking_face`, `reactions-heart`, `reactions-tada`, or `interactions`. You can also sort results by how recently the items were `created` or `updated`, Default: [best match](https://docs.github.com/rest/search/search#ranking-search-results)
    * `order` (String.t()): Determines whether the first search result returned is the highest number of matches (`desc`) or lowest number of matches (`asc`). This parameter is ignored unless you provide `sort`.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/search/search#search-issues-and-pull-requests)

  """
  @spec issues_and_pull_requests(keyword) :: {:ok, map} | {:error, GitHub.Error.t()}
  def issues_and_pull_requests(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:order, :page, :per_page, :q, :sort])

    client.request(%{
      call: {GitHub.Search, :issues_and_pull_requests},
      url: "/search/issues",
      method: :get,
      query: query,
      response: [
        {200, :map},
        {304, nil},
        {403, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}},
        {503, :map}
      ],
      opts: opts
    })
  end

  @doc """
  Search labels

  ## Options

    * `repository_id` (integer): The id of the repository.
    * `q` (String.t()): The search keywords. This endpoint does not accept qualifiers in the query. To learn more about the format of the query, see [Constructing a search query](https://docs.github.com/rest/search/search#constructing-a-search-query).
    * `sort` (String.t()): Sorts the results of your query by when the label was `created` or `updated`. Default: [best match](https://docs.github.com/rest/search/search#ranking-search-results)
    * `order` (String.t()): Determines whether the first search result returned is the highest number of matches (`desc`) or lowest number of matches (`asc`). This parameter is ignored unless you provide `sort`.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/search/search#search-labels)

  """
  @spec labels(keyword) :: {:ok, map} | {:error, GitHub.Error.t()}
  def labels(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:order, :page, :per_page, :q, :repository_id, :sort])

    client.request(%{
      call: {GitHub.Search, :labels},
      url: "/search/labels",
      method: :get,
      query: query,
      response: [
        {200, :map},
        {304, nil},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Search repositories

  ## Options

    * `q` (String.t()): The query contains one or more search keywords and qualifiers. Qualifiers allow you to limit your search to specific areas of GitHub. The REST API supports the same qualifiers as the web interface for GitHub. To learn more about the format of the query, see [Constructing a search query](https://docs.github.com/rest/search/search#constructing-a-search-query). See "[Searching for repositories](https://docs.github.com/articles/searching-for-repositories/)" for a detailed list of qualifiers.
    * `sort` (String.t()): Sorts the results of your query by number of `stars`, `forks`, or `help-wanted-issues` or how recently the items were `updated`. Default: [best match](https://docs.github.com/rest/search/search#ranking-search-results)
    * `order` (String.t()): Determines whether the first search result returned is the highest number of matches (`desc`) or lowest number of matches (`asc`). This parameter is ignored unless you provide `sort`.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/search/search#search-repositories)

  """
  @spec repos(keyword) :: {:ok, map} | {:error, GitHub.Error.t()}
  def repos(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:order, :page, :per_page, :q, :sort])

    client.request(%{
      call: {GitHub.Search, :repos},
      url: "/search/repositories",
      method: :get,
      query: query,
      response: [{200, :map}, {304, nil}, {422, {GitHub.ValidationError, :t}}, {503, :map}],
      opts: opts
    })
  end

  @doc """
  Search topics

  ## Options

    * `q` (String.t()): The query contains one or more search keywords and qualifiers. Qualifiers allow you to limit your search to specific areas of GitHub. The REST API supports the same qualifiers as the web interface for GitHub. To learn more about the format of the query, see [Constructing a search query](https://docs.github.com/rest/search/search#constructing-a-search-query).
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/search/search#search-topics)

  """
  @spec topics(keyword) :: {:ok, map} | {:error, GitHub.Error.t()}
  def topics(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page, :q])

    client.request(%{
      call: {GitHub.Search, :topics},
      url: "/search/topics",
      method: :get,
      query: query,
      response: [{200, :map}, {304, nil}],
      opts: opts
    })
  end

  @doc """
  Search users

  ## Options

    * `q` (String.t()): The query contains one or more search keywords and qualifiers. Qualifiers allow you to limit your search to specific areas of GitHub. The REST API supports the same qualifiers as the web interface for GitHub. To learn more about the format of the query, see [Constructing a search query](https://docs.github.com/rest/search/search#constructing-a-search-query). See "[Searching users](https://docs.github.com/search-github/searching-on-github/searching-users)" for a detailed list of qualifiers.
    * `sort` (String.t()): Sorts the results of your query by number of `followers` or `repositories`, or when the person `joined` GitHub. Default: [best match](https://docs.github.com/rest/search/search#ranking-search-results)
    * `order` (String.t()): Determines whether the first search result returned is the highest number of matches (`desc`) or lowest number of matches (`asc`). This parameter is ignored unless you provide `sort`.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/search/search#search-users)

  """
  @spec users(keyword) :: {:ok, map} | {:error, GitHub.Error.t()}
  def users(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:order, :page, :per_page, :q, :sort])

    client.request(%{
      call: {GitHub.Search, :users},
      url: "/search/users",
      method: :get,
      query: query,
      response: [{200, :map}, {304, nil}, {422, {GitHub.ValidationError, :t}}, {503, :map}],
      opts: opts
    })
  end
end
