defmodule GitHub.Gists do
  @moduledoc """
  Provides API endpoints related to gists
  """

  @default_client GitHub.Client

  @doc """
  Check if a gist is starred

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/gists#check-if-a-gist-is-starred)

  """
  @spec check_is_starred(String.t(), keyword) :: :ok | {:error, GitHub.Error.t()}
  def check_is_starred(gist_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [gist_id: gist_id],
      call: {GitHub.Gists, :check_is_starred},
      url: "/gists/#{gist_id}/star",
      method: :get,
      response: [{204, nil}, {304, nil}, {403, {GitHub.BasicError, :t}}, {404, :map}],
      opts: opts
    })
  end

  @doc """
  Create a gist

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/gists#create-a-gist)

  """
  @spec create(map, keyword) :: {:ok, GitHub.Gist.simple()} | {:error, GitHub.Error.t()}
  def create(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      call: {GitHub.Gists, :create},
      url: "/gists",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {201, {GitHub.Gist, :simple}},
        {304, nil},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Create a gist comment

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/gists#create-a-gist-comment)

  """
  @spec create_comment(String.t(), map, keyword) ::
          {:ok, GitHub.Gist.Comment.t()} | {:error, GitHub.Error.t()}
  def create_comment(gist_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [gist_id: gist_id],
      call: {GitHub.Gists, :create_comment},
      url: "/gists/#{gist_id}/comments",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {201, {GitHub.Gist.Comment, :t}},
        {304, nil},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Delete a gist

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/gists#delete-a-gist)

  """
  @spec delete(String.t(), keyword) :: :ok | {:error, GitHub.Error.t()}
  def delete(gist_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [gist_id: gist_id],
      call: {GitHub.Gists, :delete},
      url: "/gists/#{gist_id}",
      method: :delete,
      response: [
        {204, nil},
        {304, nil},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Delete a gist comment

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/gists#delete-a-gist-comment)

  """
  @spec delete_comment(String.t(), integer, keyword) :: :ok | {:error, GitHub.Error.t()}
  def delete_comment(gist_id, comment_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [gist_id: gist_id, comment_id: comment_id],
      call: {GitHub.Gists, :delete_comment},
      url: "/gists/#{gist_id}/comments/#{comment_id}",
      method: :delete,
      response: [
        {204, nil},
        {304, nil},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Fork a gist

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/gists#fork-a-gist)

  """
  @spec fork(String.t(), keyword) :: {:ok, GitHub.BaseGist.t()} | {:error, GitHub.Error.t()}
  def fork(gist_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [gist_id: gist_id],
      call: {GitHub.Gists, :fork},
      url: "/gists/#{gist_id}/forks",
      method: :post,
      response: [
        {201, {GitHub.BaseGist, :t}},
        {304, nil},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get a gist

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/gists#get-a-gist)

  """
  @spec get(String.t(), keyword) :: {:ok, GitHub.Gist.simple()} | {:error, GitHub.Error.t()}
  def get(gist_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [gist_id: gist_id],
      call: {GitHub.Gists, :get},
      url: "/gists/#{gist_id}",
      method: :get,
      response: [
        {200, {GitHub.Gist, :simple}},
        {304, nil},
        {403, :map},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get a gist comment

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/gists#get-a-gist-comment)

  """
  @spec get_comment(String.t(), integer, keyword) ::
          {:ok, GitHub.Gist.Comment.t()} | {:error, GitHub.Error.t()}
  def get_comment(gist_id, comment_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [gist_id: gist_id, comment_id: comment_id],
      call: {GitHub.Gists, :get_comment},
      url: "/gists/#{gist_id}/comments/#{comment_id}",
      method: :get,
      response: [
        {200, {GitHub.Gist.Comment, :t}},
        {304, nil},
        {403, :map},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get a gist revision

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/gists#get-a-gist-revision)

  """
  @spec get_revision(String.t(), String.t(), keyword) ::
          {:ok, GitHub.Gist.simple()} | {:error, GitHub.Error.t()}
  def get_revision(gist_id, sha, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [gist_id: gist_id, sha: sha],
      call: {GitHub.Gists, :get_revision},
      url: "/gists/#{gist_id}/#{sha}",
      method: :get,
      response: [
        {200, {GitHub.Gist, :simple}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List gists for the authenticated user

  ## Options

    * `since` (String.t()): Only show notifications updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/gists#list-gists-for-the-authenticated-user)

  """
  @spec list(keyword) :: {:ok, [GitHub.BaseGist.t()]} | {:error, GitHub.Error.t()}
  def list(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page, :since])

    client.request(%{
      call: {GitHub.Gists, :list},
      url: "/gists",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.BaseGist, :t}}},
        {304, nil},
        {403, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List gist comments

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/gists#list-gist-comments)

  """
  @spec list_comments(String.t(), keyword) ::
          {:ok, [GitHub.Gist.Comment.t()]} | {:error, GitHub.Error.t()}
  def list_comments(gist_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [gist_id: gist_id],
      call: {GitHub.Gists, :list_comments},
      url: "/gists/#{gist_id}/comments",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.Gist.Comment, :t}}},
        {304, nil},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List gist commits

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/gists#list-gist-commits)

  """
  @spec list_commits(String.t(), keyword) ::
          {:ok, [GitHub.Gist.Commit.t()]} | {:error, GitHub.Error.t()}
  def list_commits(gist_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [gist_id: gist_id],
      call: {GitHub.Gists, :list_commits},
      url: "/gists/#{gist_id}/commits",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.Gist.Commit, :t}}},
        {304, nil},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List gists for a user

  ## Options

    * `since` (String.t()): Only show notifications updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/gists#list-gists-for-a-user)

  """
  @spec list_for_user(String.t(), keyword) ::
          {:ok, [GitHub.BaseGist.t()]} | {:error, GitHub.Error.t()}
  def list_for_user(username, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page, :since])

    client.request(%{
      args: [username: username],
      call: {GitHub.Gists, :list_for_user},
      url: "/users/#{username}/gists",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.BaseGist, :t}}}, {422, {GitHub.ValidationError, :t}}],
      opts: opts
    })
  end

  @doc """
  List gist forks

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/gists#list-gist-forks)

  """
  @spec list_forks(String.t(), keyword) ::
          {:ok, [GitHub.Gist.simple()]} | {:error, GitHub.Error.t()}
  def list_forks(gist_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [gist_id: gist_id],
      call: {GitHub.Gists, :list_forks},
      url: "/gists/#{gist_id}/forks",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.Gist, :simple}}},
        {304, nil},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List public gists

  ## Options

    * `since` (String.t()): Only show notifications updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/gists#list-public-gists)

  """
  @spec list_public(keyword) :: {:ok, [GitHub.BaseGist.t()]} | {:error, GitHub.Error.t()}
  def list_public(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page, :since])

    client.request(%{
      call: {GitHub.Gists, :list_public},
      url: "/gists/public",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.BaseGist, :t}}},
        {304, nil},
        {403, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List starred gists

  ## Options

    * `since` (String.t()): Only show notifications updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/gists#list-starred-gists)

  """
  @spec list_starred(keyword) :: {:ok, [GitHub.BaseGist.t()]} | {:error, GitHub.Error.t()}
  def list_starred(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page, :since])

    client.request(%{
      call: {GitHub.Gists, :list_starred},
      url: "/gists/starred",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.BaseGist, :t}}},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Star a gist

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/gists#star-a-gist)

  """
  @spec star(String.t(), keyword) :: :ok | {:error, GitHub.Error.t()}
  def star(gist_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [gist_id: gist_id],
      call: {GitHub.Gists, :star},
      url: "/gists/#{gist_id}/star",
      method: :put,
      response: [
        {204, nil},
        {304, nil},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Unstar a gist

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/gists#unstar-a-gist)

  """
  @spec unstar(String.t(), keyword) :: :ok | {:error, GitHub.Error.t()}
  def unstar(gist_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [gist_id: gist_id],
      call: {GitHub.Gists, :unstar},
      url: "/gists/#{gist_id}/star",
      method: :delete,
      response: [
        {204, nil},
        {304, nil},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Update a gist

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/gists/#update-a-gist)

  """
  @spec update(String.t(), map | nil, keyword) ::
          {:ok, GitHub.Gist.simple()} | {:error, GitHub.Error.t()}
  def update(gist_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [gist_id: gist_id],
      call: {GitHub.Gists, :update},
      url: "/gists/#{gist_id}",
      body: body,
      method: :patch,
      request: [{"application/json", {:nullable, :map}}],
      response: [
        {200, {GitHub.Gist, :simple}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Update a gist comment

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/gists#update-a-gist-comment)

  """
  @spec update_comment(String.t(), integer, map, keyword) ::
          {:ok, GitHub.Gist.Comment.t()} | {:error, GitHub.Error.t()}
  def update_comment(gist_id, comment_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [gist_id: gist_id, comment_id: comment_id],
      call: {GitHub.Gists, :update_comment},
      url: "/gists/#{gist_id}/comments/#{comment_id}",
      body: body,
      method: :patch,
      request: [{"application/json", :map}],
      response: [{200, {GitHub.Gist.Comment, :t}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end
end
