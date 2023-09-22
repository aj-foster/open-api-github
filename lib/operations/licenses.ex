defmodule GitHub.Licenses do
  @moduledoc """
  Provides API endpoints related to licenses
  """

  @default_client GitHub.Client

  @doc """
  Get a license

  Gets information about a specific license. For more information, see "[Licensing a repository ](https://docs.github.com/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/licensing-a-repository)."

  ## Resources

    * [API method documentation](https://docs.github.com/rest/licenses/licenses#get-a-license)

  """
  @spec get(String.t(), keyword) :: {:ok, GitHub.License.t()} | {:error, GitHub.Error.t()}
  def get(license, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [license: license],
      call: {GitHub.Licenses, :get},
      url: "/licenses/#{license}",
      method: :get,
      response: [
        {200, {GitHub.License, :t}},
        {304, :null},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get all commonly used licenses

  Lists the most commonly used licenses on GitHub. For more information, see "[Licensing a repository ](https://docs.github.com/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/licensing-a-repository)."

  ## Options

    * `featured`
    * `per_page`: The number of results per page (max 100).
    * `page`: Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/licenses/licenses#get-all-commonly-used-licenses)

  """
  @spec get_all_commonly_used(keyword) ::
          {:ok, [GitHub.License.simple()]} | {:error, GitHub.Error.t()}
  def get_all_commonly_used(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:featured, :page, :per_page])

    client.request(%{
      args: [],
      call: {GitHub.Licenses, :get_all_commonly_used},
      url: "/licenses",
      method: :get,
      query: query,
      response: [{200, [{GitHub.License, :simple}]}, {304, :null}],
      opts: opts
    })
  end

  @doc """
  Get the license for a repository

  This method returns the contents of the repository's license file, if one is detected.

  Similar to [Get repository content](https://docs.github.com/rest/repos/contents#get-repository-content), this method also supports [custom media types](https://docs.github.com/rest/overview/media-types) for retrieving the raw license content or rendered license HTML.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/licenses/licenses#get-the-license-for-a-repository)

  """
  @spec get_for_repo(String.t(), String.t(), keyword) ::
          {:ok, GitHub.License.Content.t()} | {:error, GitHub.Error.t()}
  def get_for_repo(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Licenses, :get_for_repo},
      url: "/repos/#{owner}/#{repo}/license",
      method: :get,
      response: [{200, {GitHub.License.Content, :t}}],
      opts: opts
    })
  end
end
