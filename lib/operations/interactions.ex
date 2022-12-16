defmodule GitHub.Interactions do
  @moduledoc """
  Provides API endpoints related to interactions
  """

  @default_client GitHub.Client

  @doc """
  Get interaction restrictions for your public repositories

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/interactions#get-interaction-restrictions-for-your-public-repositories)

  """
  @spec get_restrictions_for_authenticated_user(keyword) ::
          {:ok, map | GitHub.Interaction.Limit.Response.t()} | :error
  def get_restrictions_for_authenticated_user(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/user/interaction-limits",
      method: :get,
      response: [{200, {:union, [{GitHub.Interaction.Limit.Response, :t}, :map]}}, {204, nil}],
      opts: opts
    })
  end

  @doc """
  Get interaction restrictions for an organization

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/interactions#get-interaction-restrictions-for-an-organization)

  """
  @spec get_restrictions_for_org(String.t(), keyword) ::
          {:ok, map | GitHub.Interaction.Limit.Response.t()} | :error
  def get_restrictions_for_org(org, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/orgs/#{org}/interaction-limits",
      method: :get,
      response: [{200, {:union, [{GitHub.Interaction.Limit.Response, :t}, :map]}}],
      opts: opts
    })
  end

  @doc """
  Get interaction restrictions for a repository

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/interactions#get-interaction-restrictions-for-a-repository)

  """
  @spec get_restrictions_for_repo(String.t(), String.t(), keyword) ::
          {:ok, map | GitHub.Interaction.Limit.Response.t()} | :error
  def get_restrictions_for_repo(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/repos/#{owner}/#{repo}/interaction-limits",
      method: :get,
      response: [{200, {:union, [{GitHub.Interaction.Limit.Response, :t}, :map]}}],
      opts: opts
    })
  end

  @doc """
  Remove interaction restrictions from your public repositories

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/interactions#remove-interaction-restrictions-from-your-public-repositories)

  """
  @spec remove_restrictions_for_authenticated_user(keyword) :: :ok | :error
  def remove_restrictions_for_authenticated_user(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/user/interaction-limits",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Remove interaction restrictions for an organization

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/interactions#remove-interaction-restrictions-for-an-organization)

  """
  @spec remove_restrictions_for_org(String.t(), keyword) :: :ok | :error
  def remove_restrictions_for_org(org, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/orgs/#{org}/interaction-limits",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Remove interaction restrictions for a repository

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/interactions#remove-interaction-restrictions-for-a-repository)

  """
  @spec remove_restrictions_for_repo(String.t(), String.t(), keyword) :: :ok | :error
  def remove_restrictions_for_repo(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/repos/#{owner}/#{repo}/interaction-limits",
      method: :delete,
      response: [{204, nil}, {409, nil}],
      opts: opts
    })
  end

  @doc """
  Set interaction restrictions for your public repositories

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/interactions#set-interaction-restrictions-for-your-public-repositories)

  """
  @spec set_restrictions_for_authenticated_user(map, keyword) ::
          {:ok, GitHub.Interaction.Limit.Response.t()} | {:error, GitHub.ValidationError.t()}
  def set_restrictions_for_authenticated_user(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/user/interaction-limits",
      body: body,
      method: :put,
      response: [
        {200, {GitHub.Interaction.Limit.Response, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Set interaction restrictions for an organization

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/interactions#set-interaction-restrictions-for-an-organization)

  """
  @spec set_restrictions_for_org(String.t(), map, keyword) ::
          {:ok, GitHub.Interaction.Limit.Response.t()} | {:error, GitHub.ValidationError.t()}
  def set_restrictions_for_org(org, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/orgs/#{org}/interaction-limits",
      body: body,
      method: :put,
      response: [
        {200, {GitHub.Interaction.Limit.Response, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Set interaction restrictions for a repository

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/interactions#set-interaction-restrictions-for-a-repository)

  """
  @spec set_restrictions_for_repo(String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.Interaction.Limit.Response.t()} | :error
  def set_restrictions_for_repo(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/repos/#{owner}/#{repo}/interaction-limits",
      body: body,
      method: :put,
      response: [{200, {GitHub.Interaction.Limit.Response, :t}}, {409, nil}],
      opts: opts
    })
  end
end
