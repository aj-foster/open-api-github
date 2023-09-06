defmodule GitHub.Apps do
  @moduledoc """
  Provides API endpoints related to apps
  """

  @default_client GitHub.Client

  @doc """
  Add a repository to an app installation

  ## Resources

    * [API method documentation](https://docs.github.com/rest/apps/installations#add-a-repository-to-an-app-installation)

  """
  @spec add_repo_to_installation_for_authenticated_user(integer, integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def add_repo_to_installation_for_authenticated_user(installation_id, repository_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [installation_id: installation_id, repository_id: repository_id],
      call: {GitHub.Apps, :add_repo_to_installation_for_authenticated_user},
      url: "/user/installations/#{installation_id}/repositories/#{repository_id}",
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
  Check a token

  ## Resources

    * [API method documentation](https://docs.github.com/rest/apps/oauth-applications#check-a-token)

  """
  @spec check_token(String.t(), map, keyword) ::
          {:ok, GitHub.Authorization.t()} | {:error, GitHub.Error.t()}
  def check_token(client_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [client_id: client_id, body: body],
      call: {GitHub.Apps, :check_token},
      url: "/applications/#{client_id}/token",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {200, {GitHub.Authorization, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Create a GitHub App from a manifest

  ## Resources

    * [API method documentation](https://docs.github.com/rest/apps/apps#create-a-github-app-from-a-manifest)

  """
  @spec create_from_manifest(String.t(), keyword) :: {:ok, map} | {:error, GitHub.Error.t()}
  def create_from_manifest(code, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [code: code],
      call: {GitHub.Apps, :create_from_manifest},
      url: "/app-manifests/#{code}/conversions",
      method: :post,
      response: [
        {201, :map},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :simple}}
      ],
      opts: opts
    })
  end

  @doc """
  Create an installation access token for an app

  ## Resources

    * [API method documentation](https://docs.github.com/rest/apps/apps#create-an-installation-access-token-for-an-app)

  """
  @spec create_installation_access_token(integer, map, keyword) ::
          {:ok, GitHub.Installation.Token.t()} | {:error, GitHub.Error.t()}
  def create_installation_access_token(installation_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [installation_id: installation_id, body: body],
      call: {GitHub.Apps, :create_installation_access_token},
      url: "/app/installations/#{installation_id}/access_tokens",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {201, {GitHub.Installation.Token, :t}},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Delete an app authorization

  ## Resources

    * [API method documentation](https://docs.github.com/rest/apps/oauth-applications#delete-an-app-authorization)

  """
  @spec delete_authorization(String.t(), map, keyword) :: :ok | {:error, GitHub.Error.t()}
  def delete_authorization(client_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [client_id: client_id, body: body],
      call: {GitHub.Apps, :delete_authorization},
      url: "/applications/#{client_id}/grant",
      body: body,
      method: :delete,
      request: [{"application/json", :map}],
      response: [{204, nil}, {422, {GitHub.ValidationError, :t}}],
      opts: opts
    })
  end

  @doc """
  Delete an installation for the authenticated app

  ## Resources

    * [API method documentation](https://docs.github.com/rest/apps/apps#delete-an-installation-for-the-authenticated-app)

  """
  @spec delete_installation(integer, keyword) :: :ok | {:error, GitHub.Error.t()}
  def delete_installation(installation_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [installation_id: installation_id],
      call: {GitHub.Apps, :delete_installation},
      url: "/app/installations/#{installation_id}",
      method: :delete,
      response: [{204, nil}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Delete an app token

  ## Resources

    * [API method documentation](https://docs.github.com/rest/apps/oauth-applications#delete-an-app-token)

  """
  @spec delete_token(String.t(), map, keyword) :: :ok | {:error, GitHub.Error.t()}
  def delete_token(client_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [client_id: client_id, body: body],
      call: {GitHub.Apps, :delete_token},
      url: "/applications/#{client_id}/token",
      body: body,
      method: :delete,
      request: [{"application/json", :map}],
      response: [{204, nil}, {422, {GitHub.ValidationError, :t}}],
      opts: opts
    })
  end

  @doc """
  Get the authenticated app

  ## Resources

    * [API method documentation](https://docs.github.com/rest/apps/apps#get-the-authenticated-app)

  """
  @spec get_authenticated(keyword) :: {:ok, GitHub.App.t()} | {:error, GitHub.Error.t()}
  def get_authenticated(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      call: {GitHub.Apps, :get_authenticated},
      url: "/app",
      method: :get,
      response: [{200, {GitHub.App, :t}}],
      opts: opts
    })
  end

  @doc """
  Get an app

  ## Resources

    * [API method documentation](https://docs.github.com/rest/apps/apps#get-an-app)

  """
  @spec get_by_slug(String.t(), keyword) :: {:ok, GitHub.App.t()} | {:error, GitHub.Error.t()}
  def get_by_slug(app_slug, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [app_slug: app_slug],
      call: {GitHub.Apps, :get_by_slug},
      url: "/apps/#{app_slug}",
      method: :get,
      response: [
        {200, {GitHub.App, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get an installation for the authenticated app

  ## Resources

    * [API method documentation](https://docs.github.com/rest/apps/apps#get-an-installation-for-the-authenticated-app)

  """
  @spec get_installation(integer, keyword) ::
          {:ok, GitHub.Installation.t()} | {:error, GitHub.Error.t()}
  def get_installation(installation_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [installation_id: installation_id],
      call: {GitHub.Apps, :get_installation},
      url: "/app/installations/#{installation_id}",
      method: :get,
      response: [{200, {GitHub.Installation, :t}}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Get an organization installation for the authenticated app

  ## Resources

    * [API method documentation](https://docs.github.com/rest/apps/apps#get-an-organization-installation-for-the-authenticated-app)

  """
  @spec get_org_installation(String.t(), keyword) ::
          {:ok, GitHub.Installation.t()} | {:error, GitHub.Error.t()}
  def get_org_installation(org, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [org: org],
      call: {GitHub.Apps, :get_org_installation},
      url: "/orgs/#{org}/installation",
      method: :get,
      response: [{200, {GitHub.Installation, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a repository installation for the authenticated app

  ## Resources

    * [API method documentation](https://docs.github.com/rest/apps/apps#get-a-repository-installation-for-the-authenticated-app)

  """
  @spec get_repo_installation(String.t(), String.t(), keyword) ::
          {:ok, GitHub.Installation.t()} | {:error, GitHub.Error.t()}
  def get_repo_installation(owner, repo, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [owner: owner, repo: repo],
      call: {GitHub.Apps, :get_repo_installation},
      url: "/repos/#{owner}/#{repo}/installation",
      method: :get,
      response: [
        {200, {GitHub.Installation, :t}},
        {301, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get a subscription plan for an account

  ## Resources

    * [API method documentation](https://docs.github.com/rest/apps/marketplace#get-a-subscription-plan-for-an-account)

  """
  @spec get_subscription_plan_for_account(integer, keyword) ::
          {:ok, GitHub.Marketplace.Purchase.t()} | {:error, GitHub.Error.t()}
  def get_subscription_plan_for_account(account_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [account_id: account_id],
      call: {GitHub.Apps, :get_subscription_plan_for_account},
      url: "/marketplace_listing/accounts/#{account_id}",
      method: :get,
      response: [
        {200, {GitHub.Marketplace.Purchase, :t}},
        {401, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Get a subscription plan for an account (stubbed)

  ## Resources

    * [API method documentation](https://docs.github.com/rest/apps/marketplace#get-a-subscription-plan-for-an-account-stubbed)

  """
  @spec get_subscription_plan_for_account_stubbed(integer, keyword) ::
          {:ok, GitHub.Marketplace.Purchase.t()} | {:error, GitHub.Error.t()}
  def get_subscription_plan_for_account_stubbed(account_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [account_id: account_id],
      call: {GitHub.Apps, :get_subscription_plan_for_account_stubbed},
      url: "/marketplace_listing/stubbed/accounts/#{account_id}",
      method: :get,
      response: [
        {200, {GitHub.Marketplace.Purchase, :t}},
        {401, {GitHub.BasicError, :t}},
        {404, nil}
      ],
      opts: opts
    })
  end

  @doc """
  Get a user installation for the authenticated app

  ## Resources

    * [API method documentation](https://docs.github.com/rest/apps/apps#get-a-user-installation-for-the-authenticated-app)

  """
  @spec get_user_installation(String.t(), keyword) ::
          {:ok, GitHub.Installation.t()} | {:error, GitHub.Error.t()}
  def get_user_installation(username, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [username: username],
      call: {GitHub.Apps, :get_user_installation},
      url: "/users/#{username}/installation",
      method: :get,
      response: [{200, {GitHub.Installation, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a webhook configuration for an app

  ## Resources

    * [API method documentation](https://docs.github.com/rest/apps/webhooks#get-a-webhook-configuration-for-an-app)

  """
  @spec get_webhook_config_for_app(keyword) ::
          {:ok, GitHub.Webhook.Config.t()} | {:error, GitHub.Error.t()}
  def get_webhook_config_for_app(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      call: {GitHub.Apps, :get_webhook_config_for_app},
      url: "/app/hook/config",
      method: :get,
      response: [{200, {GitHub.Webhook.Config, :t}}],
      opts: opts
    })
  end

  @doc """
  Get a delivery for an app webhook

  ## Resources

    * [API method documentation](https://docs.github.com/rest/apps/webhooks#get-a-delivery-for-an-app-webhook)

  """
  @spec get_webhook_delivery(integer, keyword) ::
          {:ok, GitHub.Hook.Delivery.t()} | {:error, GitHub.Error.t()}
  def get_webhook_delivery(delivery_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [delivery_id: delivery_id],
      call: {GitHub.Apps, :get_webhook_delivery},
      url: "/app/hook/deliveries/#{delivery_id}",
      method: :get,
      response: [
        {200, {GitHub.Hook.Delivery, :t}},
        {400, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List accounts for a plan

  ## Options

    * `sort` (String.t()): The property to sort the results by.
    * `direction` (String.t()): To return the oldest accounts first, set to `asc`. Ignored without the `sort` parameter.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/apps/marketplace#list-accounts-for-a-plan)

  """
  @spec list_accounts_for_plan(integer, keyword) ::
          {:ok, [GitHub.Marketplace.Purchase.t()]} | {:error, GitHub.Error.t()}
  def list_accounts_for_plan(plan_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:direction, :page, :per_page, :sort])

    client.request(%{
      args: [plan_id: plan_id],
      call: {GitHub.Apps, :list_accounts_for_plan},
      url: "/marketplace_listing/plans/#{plan_id}/accounts",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.Marketplace.Purchase, :t}}},
        {401, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List accounts for a plan (stubbed)

  ## Options

    * `sort` (String.t()): The property to sort the results by.
    * `direction` (String.t()): To return the oldest accounts first, set to `asc`. Ignored without the `sort` parameter.
    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/apps/marketplace#list-accounts-for-a-plan-stubbed)

  """
  @spec list_accounts_for_plan_stubbed(integer, keyword) ::
          {:ok, [GitHub.Marketplace.Purchase.t()]} | {:error, GitHub.Error.t()}
  def list_accounts_for_plan_stubbed(plan_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:direction, :page, :per_page, :sort])

    client.request(%{
      args: [plan_id: plan_id],
      call: {GitHub.Apps, :list_accounts_for_plan_stubbed},
      url: "/marketplace_listing/stubbed/plans/#{plan_id}/accounts",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.Marketplace.Purchase, :t}}},
        {401, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List repositories accessible to the user access token

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/apps/installations#list-repositories-accessible-to-the-user-access-token)

  """
  @spec list_installation_repos_for_authenticated_user(integer, keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def list_installation_repos_for_authenticated_user(installation_id, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      args: [installation_id: installation_id],
      call: {GitHub.Apps, :list_installation_repos_for_authenticated_user},
      url: "/user/installations/#{installation_id}/repositories",
      method: :get,
      query: query,
      response: [
        {200, :map},
        {304, nil},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List installation requests for the authenticated app

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/apps/apps#list-installation-requests-for-the-authenticated-app)

  """
  @spec list_installation_requests_for_authenticated_app(keyword) ::
          {:ok, [GitHub.App.InstallationRequest.t()]} | {:error, GitHub.Error.t()}
  def list_installation_requests_for_authenticated_app(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      call: {GitHub.Apps, :list_installation_requests_for_authenticated_app},
      url: "/app/installation-requests",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.App.InstallationRequest, :t}}},
        {304, nil},
        {401, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List installations for the authenticated app

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.
    * `since` (String.t()): Only show results that were last updated after the given time. This is a timestamp in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format: `YYYY-MM-DDTHH:MM:SSZ`.
    * `outdated` (String.t()): 

  ## Resources

    * [API method documentation](https://docs.github.com/rest/apps/apps#list-installations-for-the-authenticated-app)

  """
  @spec list_installations(keyword) ::
          {:ok, [GitHub.Installation.t()]} | {:error, GitHub.Error.t()}
  def list_installations(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:outdated, :page, :per_page, :since])

    client.request(%{
      call: {GitHub.Apps, :list_installations},
      url: "/app/installations",
      method: :get,
      query: query,
      response: [{200, {:array, {GitHub.Installation, :t}}}],
      opts: opts
    })
  end

  @doc """
  List app installations accessible to the user access token

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/apps/installations#list-app-installations-accessible-to-the-user-access-token)

  """
  @spec list_installations_for_authenticated_user(keyword) ::
          {:ok, map} | {:error, GitHub.Error.t()}
  def list_installations_for_authenticated_user(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      call: {GitHub.Apps, :list_installations_for_authenticated_user},
      url: "/user/installations",
      method: :get,
      query: query,
      response: [
        {200, :map},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List plans

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/apps/marketplace#list-plans)

  """
  @spec list_plans(keyword) ::
          {:ok, [GitHub.Marketplace.ListingPlan.t()]} | {:error, GitHub.Error.t()}
  def list_plans(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      call: {GitHub.Apps, :list_plans},
      url: "/marketplace_listing/plans",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.Marketplace.ListingPlan, :t}}},
        {401, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List plans (stubbed)

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/apps/marketplace#list-plans-stubbed)

  """
  @spec list_plans_stubbed(keyword) ::
          {:ok, [GitHub.Marketplace.ListingPlan.t()]} | {:error, GitHub.Error.t()}
  def list_plans_stubbed(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      call: {GitHub.Apps, :list_plans_stubbed},
      url: "/marketplace_listing/stubbed/plans",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.Marketplace.ListingPlan, :t}}},
        {401, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List repositories accessible to the app installation

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/apps/installations#list-repositories-accessible-to-the-app-installation)

  """
  @spec list_repos_accessible_to_installation(keyword) :: {:ok, map} | {:error, GitHub.Error.t()}
  def list_repos_accessible_to_installation(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      call: {GitHub.Apps, :list_repos_accessible_to_installation},
      url: "/installation/repositories",
      method: :get,
      query: query,
      response: [
        {200, :map},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List subscriptions for the authenticated user

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/apps/marketplace#list-subscriptions-for-the-authenticated-user)

  """
  @spec list_subscriptions_for_authenticated_user(keyword) ::
          {:ok, [GitHub.User.MarketplacePurchase.t()]} | {:error, GitHub.Error.t()}
  def list_subscriptions_for_authenticated_user(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      call: {GitHub.Apps, :list_subscriptions_for_authenticated_user},
      url: "/user/marketplace_purchases",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.User.MarketplacePurchase, :t}}},
        {304, nil},
        {401, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List subscriptions for the authenticated user (stubbed)

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `page` (integer): Page number of the results to fetch.

  ## Resources

    * [API method documentation](https://docs.github.com/rest/apps/marketplace#list-subscriptions-for-the-authenticated-user-stubbed)

  """
  @spec list_subscriptions_for_authenticated_user_stubbed(keyword) ::
          {:ok, [GitHub.User.MarketplacePurchase.t()]} | {:error, GitHub.Error.t()}
  def list_subscriptions_for_authenticated_user_stubbed(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:page, :per_page])

    client.request(%{
      call: {GitHub.Apps, :list_subscriptions_for_authenticated_user_stubbed},
      url: "/user/marketplace_purchases/stubbed",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.User.MarketplacePurchase, :t}}},
        {304, nil},
        {401, {GitHub.BasicError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  List deliveries for an app webhook

  ## Options

    * `per_page` (integer): The number of results per page (max 100).
    * `cursor` (String.t()): Used for pagination: the starting delivery from which the page of deliveries is fetched. Refer to the `link` header for the next and previous page cursors.
    * `redelivery` (boolean): 

  ## Resources

    * [API method documentation](https://docs.github.com/rest/apps/webhooks#list-deliveries-for-an-app-webhook)

  """
  @spec list_webhook_deliveries(keyword) ::
          {:ok, [GitHub.Hook.DeliveryItem.t()]} | {:error, GitHub.Error.t()}
  def list_webhook_deliveries(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:cursor, :per_page, :redelivery])

    client.request(%{
      call: {GitHub.Apps, :list_webhook_deliveries},
      url: "/app/hook/deliveries",
      method: :get,
      query: query,
      response: [
        {200, {:array, {GitHub.Hook.DeliveryItem, :t}}},
        {400, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Redeliver a delivery for an app webhook

  ## Resources

    * [API method documentation](https://docs.github.com/rest/apps/webhooks#redeliver-a-delivery-for-an-app-webhook)

  """
  @spec redeliver_webhook_delivery(integer, keyword) :: {:ok, map} | {:error, GitHub.Error.t()}
  def redeliver_webhook_delivery(delivery_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [delivery_id: delivery_id],
      call: {GitHub.Apps, :redeliver_webhook_delivery},
      url: "/app/hook/deliveries/#{delivery_id}/attempts",
      method: :post,
      response: [{202, :map}, {400, {GitHub.BasicError, :t}}, {422, {GitHub.ValidationError, :t}}],
      opts: opts
    })
  end

  @doc """
  Remove a repository from an app installation

  ## Resources

    * [API method documentation](https://docs.github.com/rest/apps/installations#remove-a-repository-from-an-app-installation)

  """
  @spec remove_repo_from_installation_for_authenticated_user(integer, integer, keyword) ::
          :ok | {:error, GitHub.Error.t()}
  def remove_repo_from_installation_for_authenticated_user(
        installation_id,
        repository_id,
        opts \\ []
      ) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [installation_id: installation_id, repository_id: repository_id],
      call: {GitHub.Apps, :remove_repo_from_installation_for_authenticated_user},
      url: "/user/installations/#{installation_id}/repositories/#{repository_id}",
      method: :delete,
      response: [
        {204, nil},
        {304, nil},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, nil}
      ],
      opts: opts
    })
  end

  @doc """
  Reset a token

  ## Resources

    * [API method documentation](https://docs.github.com/rest/apps/oauth-applications#reset-a-token)

  """
  @spec reset_token(String.t(), map, keyword) ::
          {:ok, GitHub.Authorization.t()} | {:error, GitHub.Error.t()}
  def reset_token(client_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [client_id: client_id, body: body],
      call: {GitHub.Apps, :reset_token},
      url: "/applications/#{client_id}/token",
      body: body,
      method: :patch,
      request: [{"application/json", :map}],
      response: [{200, {GitHub.Authorization, :t}}, {422, {GitHub.ValidationError, :t}}],
      opts: opts
    })
  end

  @doc """
  Revoke an installation access token

  ## Resources

    * [API method documentation](https://docs.github.com/rest/apps/installations#revoke-an-installation-access-token)

  """
  @spec revoke_installation_access_token(keyword) :: :ok | {:error, GitHub.Error.t()}
  def revoke_installation_access_token(opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      call: {GitHub.Apps, :revoke_installation_access_token},
      url: "/installation/token",
      method: :delete,
      response: [{204, nil}],
      opts: opts
    })
  end

  @doc """
  Create a scoped access token

  ## Resources

    * [API method documentation](https://docs.github.com/rest/apps/apps#create-a-scoped-access-token)

  """
  @spec scope_token(String.t(), map, keyword) ::
          {:ok, GitHub.Authorization.t()} | {:error, GitHub.Error.t()}
  def scope_token(client_id, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [client_id: client_id, body: body],
      call: {GitHub.Apps, :scope_token},
      url: "/applications/#{client_id}/token/scoped",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [
        {200, {GitHub.Authorization, :t}},
        {401, {GitHub.BasicError, :t}},
        {403, {GitHub.BasicError, :t}},
        {404, {GitHub.BasicError, :t}},
        {422, {GitHub.ValidationError, :t}}
      ],
      opts: opts
    })
  end

  @doc """
  Suspend an app installation

  ## Resources

    * [API method documentation](https://docs.github.com/rest/apps/apps#suspend-an-app-installation)

  """
  @spec suspend_installation(integer, keyword) :: :ok | {:error, GitHub.Error.t()}
  def suspend_installation(installation_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [installation_id: installation_id],
      call: {GitHub.Apps, :suspend_installation},
      url: "/app/installations/#{installation_id}/suspended",
      method: :put,
      response: [{204, nil}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Unsuspend an app installation

  ## Resources

    * [API method documentation](https://docs.github.com/rest/apps/apps#unsuspend-an-app-installation)

  """
  @spec unsuspend_installation(integer, keyword) :: :ok | {:error, GitHub.Error.t()}
  def unsuspend_installation(installation_id, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [installation_id: installation_id],
      call: {GitHub.Apps, :unsuspend_installation},
      url: "/app/installations/#{installation_id}/suspended",
      method: :delete,
      response: [{204, nil}, {404, {GitHub.BasicError, :t}}],
      opts: opts
    })
  end

  @doc """
  Update a webhook configuration for an app

  ## Resources

    * [API method documentation](https://docs.github.com/rest/apps/webhooks#update-a-webhook-configuration-for-an-app)

  """
  @spec update_webhook_config_for_app(map, keyword) ::
          {:ok, GitHub.Webhook.Config.t()} | {:error, GitHub.Error.t()}
  def update_webhook_config_for_app(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {GitHub.Apps, :update_webhook_config_for_app},
      url: "/app/hook/config",
      body: body,
      method: :patch,
      request: [{"application/json", :map}],
      response: [{200, {GitHub.Webhook.Config, :t}}],
      opts: opts
    })
  end
end
