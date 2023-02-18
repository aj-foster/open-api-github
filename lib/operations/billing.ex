defmodule GitHub.Billing do
  @moduledoc """
  Provides API endpoints related to billing
  """

  @default_client GitHub.Client

  @doc """
  Get GitHub Actions billing for an organization

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/billing#get-github-actions-billing-for-an-organization)

  """
  @spec get_github_actions_billing_org(String.t(), keyword) ::
          {:ok, GitHub.Actions.BillingUsage.t()} | {:error, GitHub.Error.t()}
  def get_github_actions_billing_org(org, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/orgs/#{org}/settings/billing/actions",
      method: :get,
      response: [{200, {GitHub.Actions.BillingUsage, :t}}],
      opts: opts
    })
  end

  @doc """
  Get GitHub Actions billing for a user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/billing#get-github-actions-billing-for-a-user)

  """
  @spec get_github_actions_billing_user(String.t(), keyword) ::
          {:ok, GitHub.Actions.BillingUsage.t()} | {:error, GitHub.Error.t()}
  def get_github_actions_billing_user(username, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/users/#{username}/settings/billing/actions",
      method: :get,
      response: [{200, {GitHub.Actions.BillingUsage, :t}}],
      opts: opts
    })
  end

  @doc """
  Get GitHub Packages billing for an organization

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/billing#get-github-packages-billing-for-an-organization)

  """
  @spec get_github_packages_billing_org(String.t(), keyword) ::
          {:ok, GitHub.PackagesBillingUsage.t()} | {:error, GitHub.Error.t()}
  def get_github_packages_billing_org(org, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/orgs/#{org}/settings/billing/packages",
      method: :get,
      response: [{200, {GitHub.PackagesBillingUsage, :t}}],
      opts: opts
    })
  end

  @doc """
  Get GitHub Packages billing for a user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/billing#get-github-packages-billing-for-a-user)

  """
  @spec get_github_packages_billing_user(String.t(), keyword) ::
          {:ok, GitHub.PackagesBillingUsage.t()} | {:error, GitHub.Error.t()}
  def get_github_packages_billing_user(username, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/users/#{username}/settings/billing/packages",
      method: :get,
      response: [{200, {GitHub.PackagesBillingUsage, :t}}],
      opts: opts
    })
  end

  @doc """
  Get shared storage billing for an organization

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/billing#get-shared-storage-billing-for-an-organization)

  """
  @spec get_shared_storage_billing_org(String.t(), keyword) ::
          {:ok, GitHub.CombinedBillingUsage.t()} | {:error, GitHub.Error.t()}
  def get_shared_storage_billing_org(org, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/orgs/#{org}/settings/billing/shared-storage",
      method: :get,
      response: [{200, {GitHub.CombinedBillingUsage, :t}}],
      opts: opts
    })
  end

  @doc """
  Get shared storage billing for a user

  ## Resources

    * [API method documentation](https://docs.github.com/rest/reference/billing#get-shared-storage-billing-for-a-user)

  """
  @spec get_shared_storage_billing_user(String.t(), keyword) ::
          {:ok, GitHub.CombinedBillingUsage.t()} | {:error, GitHub.Error.t()}
  def get_shared_storage_billing_user(username, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      url: "/users/#{username}/settings/billing/shared-storage",
      method: :get,
      response: [{200, {GitHub.CombinedBillingUsage, :t}}],
      opts: opts
    })
  end
end
