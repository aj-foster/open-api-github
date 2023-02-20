defmodule GitHub.Projects do
  @moduledoc """
  Provides API endpoints related to projects
  """

  @default_client GitHub.Client

  @doc """
  Add project collaborator

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/projects#add-project-collaborator)

  """
  @spec add_collaborator(integer, String.t(), map | nil, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def add_collaborator(project_id, username, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [project_id: project_id, username: username],
      url: "/projects/#{project_id}/collaborators/#{username}",
      body: body,
      method: :put,
      request: [{"application/json", {:nullable, :map}}],
      response: [
        {204, nil},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Create a project card

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/projects#create-a-project-card)

  """
  @spec create_card(integer, map, keyword) ::
          {:ok, GitHub.Project.Card.t()} | {:error, GitHub.Error.t()}
  def create_card(column_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [column_id: column_id],
      url: "/projects/columns/#{column_id}/cards",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {201, {GitHub.Project.Card, :t}},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {422, {:union, [{GitHub.ValidationError, :t}, {GitHub.ValidationError, :simple}]}},
        {503, :map}
      ],
      opts: opts
    })
  end

  @doc """
  Create a project column

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/projects#create-a-project-column)

  """
  @spec create_column(integer, map, keyword) ::
          {:ok, GitHub.Project.Column.t()} | {:error, GitHub.Error.t()}
  def create_column(project_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [project_id: project_id],
      url: "/projects/#{project_id}/columns",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {201, {GitHub.Project.Column, :t}},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :simple}}
      ],
      opts: opts
    })
  end

  @doc """
  Create a user project

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/projects#create-a-user-project)

  """
  @spec create_for_authenticated_user(map, keyword) ::
          {:ok, GitHub.Project.t()} | {:error, GitHub.Error.t()}
  def create_for_authenticated_user(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/user/projects",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {201, {GitHub.Project, :t}},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :simple}}
      ],
      opts: opts
    })
  end

  @doc """
  Create an organization project

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/projects#create-an-organization-project)

  """
  @spec create_for_org(String.t(), map, keyword) ::
          {:ok, GitHub.Project.t()} | {:error, GitHub.Error.t()}
  def create_for_org(org, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org],
      url: "/orgs/#{org}/projects",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {201, {GitHub.Project, :t}},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {410, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :simple}}
      ],
      opts: opts
    })
  end

  @doc """
  Create a repository project

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/projects#create-a-repository-project)

  """
  @spec create_for_repo(String.t(), String.t(), map, keyword) ::
          {:ok, GitHub.Project.t()} | {:error, GitHub.Error.t()}
  def create_for_repo(owner, repo, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      url: "/repos/#{owner}/#{repo}/projects",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {201, {GitHub.Project, :t}},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {410, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :simple}}
      ],
      opts: opts
    })
  end

  @doc """
  Delete a project

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/projects#delete-a-project)

  """
  @spec delete(integer, keyword) :: :ok | {:error, GitHub.Error.t()}
  def delete(project_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [project_id: project_id],
      url: "/projects/#{project_id}",
      method: :delete,
      response: [
        {204, nil},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, :map},
        {404, {GitHub.BasicError, :t}},
        {410, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Delete a project card

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/projects#delete-a-project-card)

  """
  @spec delete_card(integer, keyword) :: :ok | {:error, GitHub.Error.t()}
  def delete_card(card_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [card_id: card_id],
      url: "/projects/columns/cards/#{card_id}",
      method: :delete,
      response: [
        {204, nil},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, :map},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Delete a project column

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/projects#delete-a-project-column)

  """
  @spec delete_column(integer, keyword) :: :ok | {:error, GitHub.Error.t()}
  def delete_column(column_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [column_id: column_id],
      url: "/projects/columns/#{column_id}",
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
  Get a project

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/projects#get-a-project)

  """
  @spec get(integer, keyword) :: {:ok, GitHub.Project.t()} | {:error, GitHub.Error.t()}
  def get(project_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [project_id: project_id],
      url: "/projects/#{project_id}",
      method: :get,
      response: [
        {200, {GitHub.Project, :t}},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get a project card

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/projects#get-a-project-card)

  """
  @spec get_card(integer, keyword) :: {:ok, GitHub.Project.Card.t()} | {:error, GitHub.Error.t()}
  def get_card(card_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [card_id: card_id],
      url: "/projects/columns/cards/#{card_id}",
      method: :get,
      response: [
        {200, {GitHub.Project.Card, :t}},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get a project column

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/projects#get-a-project-column)

  """
  @spec get_column(integer, keyword) ::
          {:ok, GitHub.Project.Column.t()} | {:error, GitHub.Error.t()}
  def get_column(column_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [column_id: column_id],
      url: "/projects/columns/#{column_id}",
      method: :get,
      response: [
        {200, {GitHub.Project.Column, :t}},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get project permission for a user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/projects#get-project-permission-for-a-user)

  """
  @spec get_permission_for_user(integer, String.t(), keyword) ::
          {:ok, GitHub.Project.CollaboratorPermission.t()} | {:error, GitHub.Error.t()}
  def get_permission_for_user(project_id, username, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [project_id: project_id, username: username],
      url: "/projects/#{project_id}/collaborators/#{username}/permission",
      method: :get,
      response: [
        {200, {GitHub.Project.CollaboratorPermission, :t}},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List project cards

  ## Options

    * `archived_state` (String.t()): Filters the project cards that are returned by the card's state.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/projects#list-project-cards)

  """
  @spec list_cards(integer, keyword) ::
          {:ok, [GitHub.Project.Card.t()]} | {:error, GitHub.Error.t()}
  def list_cards(column_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:archived_state, :page, :per_page])

    client.request(%{
      args: [column_id: column_id],
      url: "/projects/columns/#{column_id}/cards",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.Project.Card, :t}}},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List project collaborators

  ## Options

    * `affiliation` (String.t()): Filters the collaborators by their affiliation. `outside` means outside collaborators of a project that are not a member of the project's organization. `direct` means collaborators with permissions to a project, regardless of organization membership status. `all` means all collaborators the authenticated user can see.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/projects#list-project-collaborators)

  """
  @spec list_collaborators(integer, keyword) ::
          {:ok, [GitHub.User.simple()]} | {:error, GitHub.Error.t()}
  def list_collaborators(project_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:affiliation, :page, :per_page])

    client.request(%{
      args: [project_id: project_id],
      url: "/projects/#{project_id}/collaborators",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.User, :simple}}},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List project columns

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/projects#list-project-columns)

  """
  @spec list_columns(integer, keyword) ::
          {:ok, [GitHub.Project.Column.t()]} | {:error, GitHub.Error.t()}
  def list_columns(project_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [project_id: project_id],
      url: "/projects/#{project_id}/columns",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.Project.Column, :t}}},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List organization projects

  ## Options

    * `state` (String.t()): Indicates the state of the projects to return.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/projects#list-organization-projects)

  """
  @spec list_for_org(String.t(), keyword) ::
          {:ok, [GitHub.Project.t()]} | {:error, GitHub.Error.t()}
  def list_for_org(org, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page, :state])

    client.request(%{
      args: [org: org],
      url: "/orgs/#{org}/projects",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.Project, :t}}}, {422, {GitHub.ValidationError, :simple}}],
      opts: opts
    })
  end

  @doc """
  List repository projects

  ## Options

    * `state` (String.t()): Indicates the state of the projects to return.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/projects#list-repository-projects)

  """
  @spec list_for_repo(String.t(), String.t(), keyword) ::
          {:ok, [GitHub.Project.t()]} | {:error, GitHub.Error.t()}
  def list_for_repo(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page, :state])

    client.request(%{
      args: [owner: owner, repo: repo],
      url: "/repos/#{owner}/#{repo}/projects",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.Project, :t}}},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {410, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :simple}}
      ],
      opts: opts
    })
  end

  @doc """
  List user projects

  ## Options

    * `state` (String.t()): Indicates the state of the projects to return.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/projects#list-user-projects)

  """
  @spec list_for_user(String.t(), keyword) ::
          {:ok, [GitHub.Project.t()]} | {:error, GitHub.Error.t()}
  def list_for_user(username, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page, :state])

    client.request(%{
      args: [username: username],
      url: "/users/#{username}/projects",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.Project, :t}}}, {422, {GitHub.ValidationError, :t}}],
      opts: opts
    })
  end

  @doc """
  Move a project card

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/projects#move-a-project-card)

  """
  @spec move_card(integer, map, keyword) :: {:ok, map} | {:error, GitHub.Error.t()}
  def move_card(card_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [card_id: card_id],
      url: "/projects/columns/cards/#{card_id}/moves",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {201, :map},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, :map},
        {422, {GitHub.ValidationError, :t}},
        {503, :map}
      ],
      opts: opts
    })
  end

  @doc """
  Move a project column

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/projects#move-a-project-column)

  """
  @spec move_column(integer, map, keyword) :: {:ok, map} | {:error, GitHub.Error.t()}
  def move_column(column_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [column_id: column_id],
      url: "/projects/columns/#{column_id}/moves",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {201, :map},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :simple}}
      ],
      opts: opts
    })
  end

  @doc """
  Remove user as a collaborator

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/projects#remove-project-collaborator)

  """
  @spec remove_collaborator(integer, String.t(), keyword) :: :ok | {:error, GitHub.Error.t()}
  def remove_collaborator(project_id, username, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [project_id: project_id, username: username],
      url: "/projects/#{project_id}/collaborators/#{username}",
      method: :delete,
      response: [
        {204, nil},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Update a project

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/projects#update-a-project)

  """
  @spec update(integer, map, keyword) :: {:ok, GitHub.Project.t()} | {:error, GitHub.Error.t()}
  def update(project_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [project_id: project_id],
      url: "/projects/#{project_id}",
      body: body,
      method: :patch,
      request: [{"application/json", :map}],
      response: [
        {200, {GitHub.Project, :t}},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, :map},
        {404, nil},
        {410, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :simple}}
      ],
      opts: opts
    })
  end

  @doc """
  Update an existing project card

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/projects#update-a-project-card)

  """
  @spec update_card(integer, map, keyword) ::
          {:ok, GitHub.Project.Card.t()} | {:error, GitHub.Error.t()}
  def update_card(card_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [card_id: card_id],
      url: "/projects/columns/cards/#{card_id}",
      body: body,
      method: :patch,
      request: [{"application/json", :map}],
      response: [
        {200, {GitHub.Project.Card, :t}},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :simple}}
      ],
      opts: opts
    })
  end

  @doc """
  Update an existing project column

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/projects#update-a-project-column)

  """
  @spec update_column(integer, map, keyword) ::
          {:ok, GitHub.Project.Column.t()} | {:error, GitHub.Error.t()}
  def update_column(column_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [column_id: column_id],
      url: "/projects/columns/#{column_id}",
      body: body,
      method: :patch,
      request: [{"application/json", :map}],
      response: [
        {200, {GitHub.Project.Column, :t}},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end
end
