defmodule GitHub.DependencyGraph do
  @moduledoc """
  Provides API endpoints related to dependency graph
  """

  @default_client GitHub.Client

  @doc """
  Create a snapshot of dependencies for a repository

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/dependency-graph#create-a-snapshot-of-dependencies-for-a-repository)

  """
  @spec create_repository_snapshot(String.t(), String.t(), GitHub.Snapshot.t(), keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def create_repository_snapshot(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, body: body],
      call: {GitHub.DependencyGraph, :create_repository_snapshot},
      url: "/repos/#{owner}/#{repo}/dependency-graph/snapshots",
      body: body,
      method: :post,
      request: [{"application/json", {GitHub.Snapshot, :t}}],
      response: [{201, :map}],
      opts: opts
    })
  end

  @doc """
  Get a diff of the dependencies between commits

  ## Options

    * `name` (String.t()): The full path, relative to the repository root, of the dependency manifest file.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/dependency-graph#get-a-diff-of-the-dependencies-between-commits)

  """
  @spec diff_range(String.t(), String.t(), String.t(), keyword) ::
          {:ok, [map]} | {:error, GitHub.Error.t()}
  def diff_range(owner, repo, basehead, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:name])

    client.request(%{
      args: [owner: owner, repo: repo, basehead: basehead],
      call: {GitHub.DependencyGraph, :diff_range},
      url: "/repos/#{owner}/#{repo}/dependency-graph/compare/#{basehead}",
      method: :get,
      query: query,
      response: [
        {200, {:array, :map}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Export a software bill of materials (SBOM) for a repository.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/dependency-graph/sboms#export-a-software-bill-of-materials-sbom-for-a-repository)

  """
  @spec export_sbom(String.t(), String.t(), keyword) ::
          {:ok, GitHub.DependencyGraph.SpdxSbom.t()} | {:error, GitHub.Error.t()}
  def export_sbom(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.DependencyGraph, :export_sbom},
      url: "/repos/#{owner}/#{repo}/dependency-graph/sbom",
      method: :get,
      response: [
        {200, {GitHub.DependencyGraph.SpdxSbom, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end
end
