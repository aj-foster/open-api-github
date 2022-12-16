defmodule GitHub.Meta do
  @moduledoc """
  Provides API endpoints related to meta
  """

  @default_client GitHub.Client

  @doc """
  Get GitHub meta information

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/meta#get-github-meta-information)

  """
  @spec get(keyword) :: {:ok, GitHub.ApiOverview.t()} | :error
  def get(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/meta",
      method: :get,
      response: [{200, {GitHub.ApiOverview, :t}}, {304, nil}],
      opts: opts
    })
  end

  @doc """
  Get all API versions

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/meta#get-all-api-versions)

  """
  @spec get_all_versions(keyword) :: {:ok, [String.t()]} | {:error, GitHub.BasicError.t()}
  def get_all_versions(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/versions",
      method: :get,
      response: [{200, {:array, :string}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Get Octocat

  ## Options

    * `s` (String.t()): The words to show in Octocat's speech bubble

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/meta#get-octocat)

  """
  @spec get_octocat(keyword) :: {:ok, String.t()} | :error
  def get_octocat(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:s])

    client.request(%{
      url: "/octocat",
      method: :get,
      query: query,
      response: [{200, :string}],
      opts: opts
    })
  end

  @doc """
  Get the Zen of GitHub

  ## Resources

    * [API method documentation](https://docs.github.com/rest/meta#get-the-zen-of-github)

  """
  @spec get_zen(keyword) :: {:ok, String.t()} | :error
  def get_zen(opts \\ []) do
    client = opts[:client] || @default_client
    client.request(%{url: "/zen", method: :get, response: [{200, :string}], opts: opts})
  end

  @doc """
  GitHub API Root

  ## Resources

    * [API method documentation](https://docs.github.com/rest/overview/resources-in-the-rest-api#root-endpoint)

  """
  @spec root(keyword) :: {:ok, GitHub.Root.t()} | :error
  def root(opts \\ []) do
    client = opts[:client] || @default_client
    client.request(%{url: "/", method: :get, response: [{200, {GitHub.Root, :t}}], opts: opts})
  end
end
