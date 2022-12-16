defmodule GitHub.Packages do
  @moduledoc """
  Provides API endpoints related to packages
  """

  @default_client GitHub.Client

  @doc """
  Delete a package for the authenticated user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/packages#delete-a-package-for-the-authenticated-user)

  """
  @spec delete_package_for_authenticated_user(String.t(), String.t(), keyword) ::
          :ok | {:error, GitHub.BasicError.t()}
  def delete_package_for_authenticated_user(package_type, package_name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/user/packages/#{package_type}/#{package_name}",
      method: :delete,
      response: [
        {204, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Delete a package for an organization

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/packages#delete-a-package-for-an-organization)

  """
  @spec delete_package_for_org(String.t(), String.t(), String.t(), keyword) ::
          :ok | {:error, GitHub.BasicError.t()}
  def delete_package_for_org(org, package_type, package_name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/orgs/#{org}/packages/#{package_type}/#{package_name}",
      method: :delete,
      response: [
        {204, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Delete a package for a user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/packages#delete-a-package-for-a-user)

  """
  @spec delete_package_for_user(String.t(), String.t(), String.t(), keyword) ::
          :ok | {:error, GitHub.BasicError.t()}
  def delete_package_for_user(username, package_type, package_name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/users/#{username}/packages/#{package_type}/#{package_name}",
      method: :delete,
      response: [
        {204, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Delete a package version for the authenticated user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/packages#delete-a-package-version-for-the-authenticated-user)

  """
  @spec delete_package_version_for_authenticated_user(String.t(), String.t(), integer, keyword) ::
          :ok | {:error, GitHub.BasicError.t()}
  def delete_package_version_for_authenticated_user(
        package_type,
        package_name,
        package_version_id,
        opts \\ []
      ) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/user/packages/#{package_type}/#{package_name}/versions/#{package_version_id}",
      method: :delete,
      response: [
        {204, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Delete package version for an organization

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/packages#delete-a-package-version-for-an-organization)

  """
  @spec delete_package_version_for_org(String.t(), String.t(), String.t(), integer, keyword) ::
          :ok | {:error, GitHub.BasicError.t()}
  def delete_package_version_for_org(
        org,
        package_type,
        package_name,
        package_version_id,
        opts \\ []
      ) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/orgs/#{org}/packages/#{package_type}/#{package_name}/versions/#{package_version_id}",
      method: :delete,
      response: [
        {204, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Delete package version for a user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/packages#delete-a-package-version-for-a-user)

  """
  @spec delete_package_version_for_user(String.t(), String.t(), String.t(), integer, keyword) ::
          :ok | {:error, GitHub.BasicError.t()}
  def delete_package_version_for_user(
        username,
        package_type,
        package_name,
        package_version_id,
        opts \\ []
      ) do
    client = opts[:client] || @default_client

    client.request(%{
      url:
        "/users/#{username}/packages/#{package_type}/#{package_name}/versions/#{package_version_id}",
      method: :delete,
      response: [
        {204, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List package versions for a package owned by the authenticated user

  ## Options

    * `page` (integer): Page number of the results to fetch.
    * `per_page` (integer): The number of results per page (max 100).
    * `state` (String.t()): The state of the package, either active or deleted.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/packages#get-all-package-versions-for-a-package-owned-by-the-authenticated-user)

  """
  @spec get_all_package_versions_for_package_owned_by_authenticated_user(
          String.t(),
          String.t(),
          keyword
        ) :: {:ok, [GitHub.PackageVersion.t()]} | {:error, GitHub.BasicError.t()}
  def get_all_package_versions_for_package_owned_by_authenticated_user(
        package_type,
        package_name,
        opts \\ []
      ) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page, :state])

    client.request(%{
      url: "/user/packages/#{package_type}/#{package_name}/versions",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.PackageVersion, :t}}},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List package versions for a package owned by an organization

  ## Options

    * `page` (integer): Page number of the results to fetch.
    * `per_page` (integer): The number of results per page (max 100).
    * `state` (String.t()): The state of the package, either active or deleted.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/packages#get-all-package-versions-for-a-package-owned-by-an-organization)

  """
  @spec get_all_package_versions_for_package_owned_by_org(
          String.t(),
          String.t(),
          String.t(),
          keyword
        ) :: {:ok, [GitHub.PackageVersion.t()]} | {:error, GitHub.BasicError.t()}
  def get_all_package_versions_for_package_owned_by_org(
        org,
        package_type,
        package_name,
        opts \\ []
      ) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page, :state])

    client.request(%{
      url: "/orgs/#{org}/packages/#{package_type}/#{package_name}/versions",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.PackageVersion, :t}}},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List package versions for a package owned by a user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/packages#get-all-package-versions-for-a-package-owned-by-a-user)

  """
  @spec get_all_package_versions_for_package_owned_by_user(
          String.t(),
          String.t(),
          String.t(),
          keyword
        ) :: {:ok, [GitHub.PackageVersion.t()]} | {:error, GitHub.BasicError.t()}
  def get_all_package_versions_for_package_owned_by_user(
        username,
        package_type,
        package_name,
        opts \\ []
      ) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/users/#{username}/packages/#{package_type}/#{package_name}/versions",
      method: :get,
      response: [
        {200, {:array, {GitHub.PackageVersion, :t}}},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get a package for the authenticated user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/packages#get-a-package-for-the-authenticated-user)

  """
  @spec get_package_for_authenticated_user(String.t(), String.t(), keyword) ::
          {:ok, GitHub.Package.t()} | :error
  def get_package_for_authenticated_user(package_type, package_name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/user/packages/#{package_type}/#{package_name}",
      method: :get,
      response: [{200, {GitHub.Package, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a package for an organization

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/packages#get-a-package-for-an-organization)

  """
  @spec get_package_for_organization(String.t(), String.t(), String.t(), keyword) ::
          {:ok, GitHub.Package.t()} | :error
  def get_package_for_organization(org, package_type, package_name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/orgs/#{org}/packages/#{package_type}/#{package_name}",
      method: :get,
      response: [{200, {GitHub.Package, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a package for a user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/packages#get-a-package-for-a-user)

  """
  @spec get_package_for_user(String.t(), String.t(), String.t(), keyword) ::
          {:ok, GitHub.Package.t()} | :error
  def get_package_for_user(username, package_type, package_name, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/users/#{username}/packages/#{package_type}/#{package_name}",
      method: :get,
      response: [{200, {GitHub.Package, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a package version for the authenticated user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/packages#get-a-package-version-for-the-authenticated-user)

  """
  @spec get_package_version_for_authenticated_user(String.t(), String.t(), integer, keyword) ::
          {:ok, GitHub.PackageVersion.t()} | :error
  def get_package_version_for_authenticated_user(
        package_type,
        package_name,
        package_version_id,
        opts \\ []
      ) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/user/packages/#{package_type}/#{package_name}/versions/#{package_version_id}",
      method: :get,
      response: [{200, {GitHub.PackageVersion, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a package version for an organization

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/packages#get-a-package-version-for-an-organization)

  """
  @spec get_package_version_for_organization(String.t(), String.t(), String.t(), integer, keyword) ::
          {:ok, GitHub.PackageVersion.t()} | :error
  def get_package_version_for_organization(
        org,
        package_type,
        package_name,
        package_version_id,
        opts \\ []
      ) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/orgs/#{org}/packages/#{package_type}/#{package_name}/versions/#{package_version_id}",
      method: :get,
      response: [{200, {GitHub.PackageVersion, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a package version for a user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/packages#get-a-package-version-for-a-user)

  """
  @spec get_package_version_for_user(String.t(), String.t(), String.t(), integer, keyword) ::
          {:ok, GitHub.PackageVersion.t()} | :error
  def get_package_version_for_user(
        username,
        package_type,
        package_name,
        package_version_id,
        opts \\ []
      ) do
    client = opts[:client] || @default_client

    client.request(%{
      url:
        "/users/#{username}/packages/#{package_type}/#{package_name}/versions/#{package_version_id}",
      method: :get,
      response: [{200, {GitHub.PackageVersion, :t}}],
      opts: opts
    })
  end

  @doc """
  List packages for the authenticated user's namespace

  ## Options

    * `package_type` (String.t()): The type of supported package. Packages in GitHub's Gradle registry have the type `maven`. Docker images pushed to GitHub's Container registry (`ghcr.io`) have the type `container`. You can use the type `docker` to find images that were pushed to GitHub's Docker registry (`docker.pkg.github.com`), even if these have now been migrated to the Container registry.
    * `visibility` (String.t()): The selected visibility of the packages.  This parameter is optional and only filters an existing result set.

  The `internal` visibility is only supported for GitHub Packages registries that allow for granular permissions. For other ecosystems `internal` is synonymous with `private`.
  For the list of GitHub Packages registries that support granular permissions, see "[About permissions for GitHub Packages](https://docs.github.com/packages/learn-github-packages/about-permissions-for-github-packages#granular-permissions-for-userorganization-scoped-packages)."

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/packages#list-packages-for-the-authenticated-user)

  """
  @spec list_packages_for_authenticated_user(keyword) :: {:ok, [GitHub.Package.t()]} | :error
  def list_packages_for_authenticated_user(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:package_type, :visibility])

    client.request(%{
      url: "/user/packages",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.Package, :t}}}],
      opts: opts
    })
  end

  @doc """
  List packages for an organization

  ## Options

    * `package_type` (String.t()): The type of supported package. Packages in GitHub's Gradle registry have the type `maven`. Docker images pushed to GitHub's Container registry (`ghcr.io`) have the type `container`. You can use the type `docker` to find images that were pushed to GitHub's Docker registry (`docker.pkg.github.com`), even if these have now been migrated to the Container registry.
    * `visibility` (String.t()): The selected visibility of the packages.  This parameter is optional and only filters an existing result set.

  The `internal` visibility is only supported for GitHub Packages registries that allow for granular permissions. For other ecosystems `internal` is synonymous with `private`.
  For the list of GitHub Packages registries that support granular permissions, see "[About permissions for GitHub Packages](https://docs.github.com/packages/learn-github-packages/about-permissions-for-github-packages#granular-permissions-for-userorganization-scoped-packages)."

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/packages#list-packages-for-an-organization)

  """
  @spec list_packages_for_organization(String.t(), keyword) ::
          {:ok, [GitHub.Package.t()]} | {:error, GitHub.BasicError.t()}
  def list_packages_for_organization(org, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:package_type, :visibility])

    client.request(%{
      url: "/orgs/#{org}/packages",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.Package, :t}}},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List packages for a user

  ## Options

    * `package_type` (String.t()): The type of supported package. Packages in GitHub's Gradle registry have the type `maven`. Docker images pushed to GitHub's Container registry (`ghcr.io`) have the type `container`. You can use the type `docker` to find images that were pushed to GitHub's Docker registry (`docker.pkg.github.com`), even if these have now been migrated to the Container registry.
    * `visibility` (String.t()): The selected visibility of the packages.  This parameter is optional and only filters an existing result set.

  The `internal` visibility is only supported for GitHub Packages registries that allow for granular permissions. For other ecosystems `internal` is synonymous with `private`.
  For the list of GitHub Packages registries that support granular permissions, see "[About permissions for GitHub Packages](https://docs.github.com/packages/learn-github-packages/about-permissions-for-github-packages#granular-permissions-for-userorganization-scoped-packages)."

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/packages#list-packages-for-user)

  """
  @spec list_packages_for_user(String.t(), keyword) ::
          {:ok, [GitHub.Package.t()]} | {:error, GitHub.BasicError.t()}
  def list_packages_for_user(username, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:package_type, :visibility])

    client.request(%{
      url: "/users/#{username}/packages",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.Package, :t}}},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Restore a package for the authenticated user

  ## Options

    * `token` (String.t()): package token

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/packages#restore-a-package-for-the-authenticated-user)

  """
  @spec restore_package_for_authenticated_user(String.t(), String.t(), keyword) ::
          :ok | {:error, GitHub.BasicError.t()}
  def restore_package_for_authenticated_user(package_type, package_name, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:token])

    client.request(%{
      url: "/user/packages/#{package_type}/#{package_name}/restore",
      method: :post,
      query: query,
      response: [
        {204, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Restore a package for an organization

  ## Options

    * `token` (String.t()): package token

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/packages#restore-a-package-for-an-organization)

  """
  @spec restore_package_for_org(String.t(), String.t(), String.t(), keyword) ::
          :ok | {:error, GitHub.BasicError.t()}
  def restore_package_for_org(org, package_type, package_name, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:token])

    client.request(%{
      url: "/orgs/#{org}/packages/#{package_type}/#{package_name}/restore",
      method: :post,
      query: query,
      response: [
        {204, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Restore a package for a user

  ## Options

    * `token` (String.t()): package token

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/packages#restore-a-package-for-a-user)

  """
  @spec restore_package_for_user(String.t(), String.t(), String.t(), keyword) ::
          :ok | {:error, GitHub.BasicError.t()}
  def restore_package_for_user(username, package_type, package_name, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:token])

    client.request(%{
      url: "/users/#{username}/packages/#{package_type}/#{package_name}/restore",
      method: :post,
      query: query,
      response: [
        {204, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Restore a package version for the authenticated user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/packages#restore-a-package-version-for-the-authenticated-user)

  """
  @spec restore_package_version_for_authenticated_user(String.t(), String.t(), integer, keyword) ::
          :ok | {:error, GitHub.BasicError.t()}
  def restore_package_version_for_authenticated_user(
        package_type,
        package_name,
        package_version_id,
        opts \\ []
      ) do
    client = opts[:client] || @default_client

    client.request(%{
      url:
        "/user/packages/#{package_type}/#{package_name}/versions/#{package_version_id}/restore",
      method: :post,
      response: [
        {204, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Restore package version for an organization

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/packages#restore-a-package-version-for-an-organization)

  """
  @spec restore_package_version_for_org(String.t(), String.t(), String.t(), integer, keyword) ::
          :ok | {:error, GitHub.BasicError.t()}
  def restore_package_version_for_org(
        org,
        package_type,
        package_name,
        package_version_id,
        opts \\ []
      ) do
    client = opts[:client] || @default_client

    client.request(%{
      url:
        "/orgs/#{org}/packages/#{package_type}/#{package_name}/versions/#{package_version_id}/restore",
      method: :post,
      response: [
        {204, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Restore package version for a user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/packages#restore-a-package-version-for-a-user)

  """
  @spec restore_package_version_for_user(String.t(), String.t(), String.t(), integer, keyword) ::
          :ok | {:error, GitHub.BasicError.t()}
  def restore_package_version_for_user(
        username,
        package_type,
        package_name,
        package_version_id,
        opts \\ []
      ) do
    client = opts[:client] || @default_client

    client.request(%{
      url:
        "/users/#{username}/packages/#{package_type}/#{package_name}/versions/#{package_version_id}/restore",
      method: :post,
      response: [
        {204, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end
end
