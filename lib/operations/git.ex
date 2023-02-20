defmodule GitHub.Git do
  @moduledoc """
  Provides API endpoints related to git
  """

  @default_client GitHub.Client

  @doc """
  Create a blob

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/git#create-a-blob)

  """
  @spec create_blob(String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.ShortBlob.t()} | {:error, GitHub.Error.t()}
  def create_blob(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      url: "/repos/#{owner}/#{repo}/git/blobs",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {201, {GitHub.ShortBlob, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {409, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Create a commit

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/git#create-a-commit)

  """
  @spec create_commit(String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.Git.Commit.t()} | {:error, GitHub.Error.t()}
  def create_commit(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      url: "/repos/#{owner}/#{repo}/git/commits",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {201, {GitHub.Git.Commit, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Create a reference

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/git#create-a-reference)

  """
  @spec create_ref(String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.Git.Ref.t()} | {:error, GitHub.Error.t()}
  def create_ref(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      url: "/repos/#{owner}/#{repo}/git/refs",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{201, {GitHub.Git.Ref, :t}}, {422, {GitHub.ValidationError, :t}}],
      opts: opts
    })
  end

  @doc """
  Create a tag object

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/git#create-a-tag-object)

  """
  @spec create_tag(String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.Git.Tag.t()} | {:error, GitHub.Error.t()}
  def create_tag(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      url: "/repos/#{owner}/#{repo}/git/tags",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{201, {GitHub.Git.Tag, :t}}, {422, {GitHub.ValidationError, :t}}],
      opts: opts
    })
  end

  @doc """
  Create a tree

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/git#create-a-tree)

  """
  @spec create_tree(String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.Git.Tree.t()} | {:error, GitHub.Error.t()}
  def create_tree(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      url: "/repos/#{owner}/#{repo}/git/trees",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {201, {GitHub.Git.Tree, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Delete a reference

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/git#delete-a-reference)

  """
  @spec delete_ref(String.t(), String.t(), String.t(), keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def delete_ref(owner, repo, ref, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, ref: ref],
      url: "/repos/#{owner}/#{repo}/git/refs/#{ref}",
      method: :delete,
      response: [{204, nil}, {422, {GitHub.ValidationError, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a blob

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/git#get-a-blob)

  """
  @spec get_blob(String.t(), String.t(), String.t(), keyword) ::
          {:ok, GitHub.Blob.t()} | {:error, GitHub.Error.t()}
  def get_blob(owner, repo, file_sha, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, file_sha: file_sha],
      url: "/repos/#{owner}/#{repo}/git/blobs/#{file_sha}",
      method: :get,
      response: [
        {200, {GitHub.Blob, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get a commit

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/git#get-a-commit)

  """
  @spec get_commit(String.t(), String.t(), String.t(), keyword) ::
          {:ok, GitHub.Git.Commit.t()} | {:error, GitHub.Error.t()}
  def get_commit(owner, repo, commit_sha, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, commit_sha: commit_sha],
      url: "/repos/#{owner}/#{repo}/git/commits/#{commit_sha}",
      method: :get,
      response: [{200, {GitHub.Git.Commit, :t}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a reference

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/git#get-a-reference)

  """
  @spec get_ref(String.t(), String.t(), String.t(), keyword) ::
          {:ok, GitHub.Git.Ref.t()} | {:error, GitHub.Error.t()}
  def get_ref(owner, repo, ref, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, ref: ref],
      url: "/repos/#{owner}/#{repo}/git/ref/#{ref}",
      method: :get,
      response: [{200, {GitHub.Git.Ref, :t}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a tag

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/git#get-a-tag)

  """
  @spec get_tag(String.t(), String.t(), String.t(), keyword) ::
          {:ok, GitHub.Git.Tag.t()} | {:error, GitHub.Error.t()}
  def get_tag(owner, repo, tag_sha, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, tag_sha: tag_sha],
      url: "/repos/#{owner}/#{repo}/git/tags/#{tag_sha}",
      method: :get,
      response: [{200, {GitHub.Git.Tag, :t}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a tree

  ## Options

    * `recursive` (String.t()): Setting this parameter to any value returns the objects or subtrees referenced by the tree specified in `:tree_sha`. For example, setting `recursive` to any of the following will enable returning objects or subtrees: `0`, `1`, `"true"`, and `"false"`. Omit this parameter to prevent recursively returning objects or subtrees.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/git#get-a-tree)

  """
  @spec get_tree(String.t(), String.t(), String.t(), keyword) ::
          {:ok, GitHub.Git.Tree.t()} | {:error, GitHub.Error.t()}
  def get_tree(owner, repo, tree_sha, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:recursive])

    client.request(%{
      args: [owner: owner, repo: repo, tree_sha: tree_sha],
      url: "/repos/#{owner}/#{repo}/git/trees/#{tree_sha}",
      method: :get,
      query: query,
      response: [
        {200, {GitHub.Git.Tree, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List matching references

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/git#list-matching-references)

  """
  @spec list_matching_refs(String.t(), String.t(), String.t(), keyword) ::
          {:ok, [GitHub.Git.Ref.t()]} | {:error, GitHub.Error.t()}
  def list_matching_refs(owner, repo, ref, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, ref: ref],
      url: "/repos/#{owner}/#{repo}/git/matching-refs/#{ref}",
      method: :get,
      response: [{200, {:array, {GitHub.Git.Ref, :t}}}],
      opts: opts
    })
  end

  @doc """
  Update a reference

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/git#update-a-reference)

  """
  @spec update_ref(String.t(), String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.Git.Ref.t()} | {:error, GitHub.Error.t()}
  def update_ref(owner, repo, ref, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo, ref: ref],
      url: "/repos/#{owner}/#{repo}/git/refs/#{ref}",
      body: body,
      method: :patch,
      request: [{"application/json", :map}],
      response: [{200, {GitHub.Git.Ref, :t}}, {422, {GitHub.ValidationError, :t}}],
      opts: opts
    })
  end
end
